import std/[math, sequtils]
import arraymancer, results
import calc

type  
  Vertice2D* = object
    ## 2D-EITを対象とするため2次元を仮定
    pos*: (float, float)
    V*: float
    I*: float
    ΔV* = 0.0
    ΔI* = 0.0
    isElectrode* = false
  
  Element* = object
    ## counter-clock-wiseに並んでいることを要請する予定
    idxVertice1*: int
    idxVertice2*: int
    idxVertice3*: int
    σ* = 1.0
    Δσ* = 0.0

  Mesh* = object
    elements*: seq[Element]
    vertices*: seq[Vertice2D]
    numOuterVertices*: int

func generate_outer_vertices(num_outer_vertices: int, R: float): Result[seq[Vertice2D], CatchableError] = 
  ## 円形状で一定間隔で電極扱いのノードを形成
  if num_outer_vertices <= 1:
    return CatchableError(msg: "num_outer_vertices must be over 1").err()

  var vertices: seq[Vertice2D]

  for i in 0..<num_outer_vertices:
    let
      x = R*cos((i/num_outer_vertices)*2*PI)
      y = R*sin((i/num_outer_vertices)*2*PI)
      vertice = Vertice2D(pos: (x, y), V : 0.0, I : 0.0, isElectrode : true)
    vertices.add(vertice)

  return vertices.ok()

func generate_mesh_circle*(num_outer_vertices: int, R: float): Result[Mesh, CatchableError] =
  ## 円周をセンサ数
  ## まず電極として設定した、円周上の各点から円の中心に向けてエッジを描く
  ## これで最初のメッシュを作り、ノードと合わせてシステムオブジェクトを生成する
  var
    elements: seq[Element]
    vertices: seq[Vertice2D]
    outer_vertices = generate_outer_vertices(num_outer_vertices, R).value
    num_outer_vertices = len(outer_vertices)

  for item in outer_vertices.items():
    vertices.add(item)
  vertices.add(Vertice2D(pos: (0.0, 0.0), V: 0.0))

  for i in 0..<len(outer_vertices):
    elements.add(Element(idxVertice1: num_outer_vertices, idxVertice2: i mod num_outer_vertices, idxVertice3: (i+1) mod num_outer_vertices))

  return Mesh(elements: elements, vertices: vertices, num_outer_vertices: num_outer_vertices).ok()

func delauney_method_mesh_update*(mesh: var Mesh, newVertice: Vertice2D) =
  ## delauney法に基づく頂点追加に対応した逐次メッシュ更新
  ## 取り扱う頂点は内部頂点のみを対象とする
  ## このプログラムはiterateされ、新ノードは外側から与えられることを想定
  ## 新ノードは必ず末尾に加えられると仮定
  ## 1. メッシュ毎に外心を算出し、更新対象に入るか(= 新しい頂点を外接円内に含むか)を確認
  ## 2. 更新対象のエレメントをメッシュから削除
  ## 3. 更新対象のエレメントについてその頂点インデックスをリストに入れる
  ## 4. 対象の頂点群に対して新しい頂点からエッジを引く形で新しいエレメント群を生成
  
  var elementsUpdated: seq[(int, Element)]
  let vert0pos = newVertice.pos

  # 1. メッシュ毎に外心を算出し、更新対象に入るか(= 新ノードを外接円内に含むか)を確認
  for i, element in mesh.elements.pairs():
    let      
      vert1pos = mesh.vertices[element.idxVertice1].pos
      vert2pos = mesh.vertices[element.idxVertice2].pos
      vert3pos = mesh.vertices[element.idxVertice3].pos
      circumcenter = circumcenter_2D(vert1pos, vert2pos, vert3pos).value

    if dist_2D(circumcenter, vert0pos) < dist_2D(circumcenter, vert1pos):
      elementsUpdated.add((i, element))
  
  # 2. 更新対象のエレメントをメッシュから削除
  var deletedNum = 0
  for (i, element) in elementsUpdated.items():
    mesh.elements.delete(i-deletedNum)
    deletedNum += 1
  
  # 3. 更新対象のエレメントについてその頂点インデックスをリストに入れる
  var
    idxVertsUpdated: seq[int]

  for (i, element) in elementsUpdated.items():
    if not idxVertsUpdated.anyIt(it == element.idxVertice1):
      idxVertsUpdated.add(element.idxVertice1)
    if not idxVertsUpdated.anyIt(it == element.idxVertice2):
      idxVertsUpdated.add(element.idxVertice2)
    if not idxVertsUpdated.anyIt(it == element.idxVertice3):
      idxVertsUpdated.add(element.idxVertice3)

  # 4. 対象の頂点群に対して新しい頂点からエッジを引く形で新しいエレメント群を生成
  # 単純に新ノードを中心とした時の角度を算出してソート
  var
    vertsUpdated: seq[(int, float)]
  
  # 角度を算出して格納
  for i in idxVertsUpdated.items():
    let
      vec = (mesh.vertices[i].pos[0] - vert0pos[0], mesh.vertices[i].pos[1] - vert0pos[1])
      nvec = normalize_vec_2D(vec)
      rad = rad_nvec_2D(nvec)
    vertsUpdated.add((i, rad))
  
  # 昇順ソート
  var
    probe = 0
    vertsUpdatedSorted: seq[(int, float)]

  while probe < len(vertsUpdated):
    if probe == 0:
      vertsUpdatedSorted.add(vertsUpdated[probe])
      probe += 1
    else:
      for i in 0..<len(vertsUpdatedSorted):
        if vertsUpdated[probe][1] > vertsUpdatedSorted[i][1]:
          vertsUpdatedSorted.insert(vertsUpdated[probe], i)
          probe += 1
          break
        elif i == len(vertsUpdatedSorted)-1:
          vertsUpdatedSorted.add(vertsUpdated[probe])
          probe += 1
          break

  # ソート済みのノード番号を用いてaddしていく
  for i in 0..<len(vertsUpdatedSorted):
    mesh.elements.add(Element(idxVertice1: len(mesh.vertices), idxVertice2: vertsUpdatedSorted[i][0], idxVertice3: vertsUpdatedSorted[(i+1) mod len(vertsUpdatedSorted)][0]))

  # ダブリが生じないように最後に新しい頂点を加える
  mesh.vertices.add(newVertice)