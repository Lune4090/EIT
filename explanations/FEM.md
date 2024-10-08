# 背景

## 解析力学の初歩(ハミルトニアンまで)

問題: ニュートン方程式は座標変換すると対称性が失われてしまう

解法: 座標変換の影響を**ラグランジアン $L$ なる関数に繰り込んで、座標変換しても一定の形の方程式**にする

$$
L = T - V
\\ 
\\ デカルト座標系の保存力に対する
\\ ニュートン方程式に対してのラグランジアン
$$

というのが「ニュートン力学を座標変換について一般化した」視点から見たラグランジアンの導入。

より一般的には、ラグランジアンは下記のEuler-Lagrange方程式を満たすような量である。

$$
\frac{d}{dx}\frac{\partial L}{\partial q'} - \frac{\partial L}{\partial q} = 0
\\  
\\ eq.EL: Euler-Lagrange方程式
$$

注意: ラグランジアンは関数であり、更に物理系によって様々に変わるため、**その物理的実体について考えることはあまり意味がない**
- 実際、上記の $L=T-V$ という定義もあくまで一例でしか無く、同じ系に対しても様々なラグランジアンを定義できる。
- しかし一般的には、**ルジャンドル変換** $H = \Sigma_{i=1}^{n: dim} p_i q_i - L$ によって生み出される**ハミルトニアン $H$ を $H = T + V$ という「総エネルギー」にする**事ができる上記の形式がよく使われる。

ラグランジアンとオイラー・ラグランジュ方程式のおかげで方程式の一般化ができたので、ついでに座標・運動量・力も一般化することを考える。

$$
q_i
\\ 
\\ 一般化座標
$$

$$
p_i = \frac{\partial L}{\partial v_i}
= \frac{\partial L}{\partial q_i'}
\\ 
\\ 一般化運動量
$$

$$
F_i = \frac{\partial L}{\partial x_i}= \frac{\partial L}{\partial q_i}
\\ 
\\ 一般化運動量
$$

## 変分原理

[参考1](https://ja.wikipedia.org/wiki/%E6%9C%80%E5%B0%8F%E4%BD%9C%E7%94%A8%E3%81%AE%E5%8E%9F%E7%90%86)

変分原理(歴史的名称: 最小作用の原理)
- _「力学系の運動は、**作用**と呼ばれる汎関数を停留値とするような軌道に沿って実現される」_

ここで、作用とは汎関数であり、系の状態を指定する**関数** $\phi$ を引数にとる作用汎関数 $S[\phi]$ として与えられる。
ここで、 $\phi$ がなんであるかは具体例に依存するすることに注意。

ここまでを数式で表現すると、

$$
\frac{\delta{S[\phi]}}{\delta{\phi}} = 0
\\  
\\ eq.1: 一般化運動方程式
$$

なる方程式を満たすことが必要であることがわかる。

つまり、上式は作用 $S[\phi]$ を定義すれば軌道 $\phi$ が一意に決まる方程式といえることから、**変分原理から求まる一般化された運動方程式**と見なすことができる。

ここで問題になるのが、**どのようにしてこの式を解くか**という点である。勿論、作用と軌道は問題毎に定式化(例: 最速降下問題なら時間t(f)が作用で降下軌道f(x)が軌道)すれば良いのだが、ではその条件下でどのように汎関数微分を求めれば良いのかが問題である。

実は、作用をラグランジュ形式

$$
S[L(\phi)] = \int_{t_0}^{t_1}L(\phi) \ dt
\\  
\\ eq.2: 作用汎関数のラグランジュ形式
$$

で表すことで、**一般化運動方程式eq.1を変形し、ラグランジアン $L(\phi)$ に対するオイラー・ラグランジュ方程式を解く**という問題にすり替えられることを示すことができる。

wikipediaにはここまでしか書いていなかったので、後は[EMANの物理学](https://eman-physics.net/)に頼ることとする。

### 具体例: 最速降下曲線の導出

[参考2](https://eman-physics.net/analytic/chapter3.html)

というわけで、「作用最小化問題をオイラー・ラグランジュ方程式にすり替える」という解説をしたいのだが、具体例がないと分かりづらい。

そこで、地点$A$から$B$までの最速降下曲線を求めることを変分原理で考えることにする。

変分原理の公式との対応関係は以下の通り。

- 作用 $S[\phi]$ = 降下時間 $t(f)$
- 状態 $\phi$ = 降下軌道 $f$
- ラグランジュ関数 $L(f) = T(f)$ (リネームした)
$$
T(f) = \sqrt{\frac{1 + f'(x)^2}{2gf(x)}}
$$

ここで求めたいのは、降下時間$t$を最小にするような降下軌道$f$である。すなわち、一般化された運動方程式に従えば

$$
\frac{\delta{t[f]}}{\delta{f(x)}} = 0
\\  
\\ eq.3: 最速降下問題における一般化運動方程式
$$

が満たされることが必要であり、上式を満たす $f$ を代入した $t$ が解となる。

以下、**$eq.3$ をEuler-Lagrange方程式に変形できること**を示す。

まずは分子に当たる $\delta t[f]$ (質点の軌道が微小変化( $f(x) \to f(x) + \delta f(x)$ )したときの降下時間の変分)を求める。

これは $eq.2$ より、ラグランジュ関数 $T$ の経路積分

$$
\delta t = \int_A^B \delta T dx
$$

に変形できることが分かっている。被積分関数の微小ラグランジアン

$$
\delta T = T(f + \delta f, f' + \delta f) - T(f, f')
$$

については、テイラー展開で1次近似してしまえば

$$
\delta T = \frac{\partial T(f, f')}{\partial f}\delta f + \frac{\partial T(f, f')}{\partial f'}\delta f'
$$

であることがわかるので、$eq.2$ に従いこれを再び作用汎関数 $t[f]$ に代入すれば

$$
\delta t = \int_A^B (\frac{\partial T}{\partial f}\delta f + \frac{\partial T}{\partial f'}\delta f') \ dx
$$

として立式される。後は $\delta f' = \frac{d(\delta f)}{dx}$ に注意して部分積分を行うと

$$
\delta t = \left[ \frac{\partial T}{\partial f'}\delta f \right]_A^B + \int_A^B (\frac{\partial T}{\partial f}\delta f - \frac{d}{dx}\frac{\partial T}{\partial f'}\delta f) \ dx
$$

となり、始点と終点が変化しない($\delta f(A) = \delta f(B)$)という拘束条件の下では第一項が消えるので

$$
\delta t = \int_A^B (\frac{\partial T}{\partial f} - \frac{d}{dx}\frac{\partial T}{\partial f'})\delta f \ dx
$$

となる。ここで、**降下時間 $t$ が最短になる場合には変分 $\delta t$ が微小変化 $\delta f$ によらず0になる**、即ち被積分関数が0になっていれば良いので、結局求めたい関数は

$$
\frac{d}{dx}\frac{\partial T}{\partial f'} - \frac{\partial T}{\partial f} = 0
\\  
\\ eq.4: 最速降下問題におけるEuler-Lagrange方程式
$$

である。これは**オイラー・ラグランジュ方程式**であり、即ち当初の目標であった、一般化運動方程式 $eq.1$ のオイラー・ラグランジュ方程式 $eq.4$ によるすりかえ、即ち**オイラー・ラグランジュ方程式を満たす軌道こそが最速降下曲線である**ことを示せた。

## 変分原理に基づくFEMの定式化: 変分原理の静電場への応用

[参考3](https://qiita.com/atily17/items/fa8abcc4d778c16fa11a)

前節では、最速降下問題を通じて、一般化運動方程式をオイラー・ラグランジュ方程式に帰着できることを見た。

これと同様に、静電場についても変分原理から、静電ポテンシャルエネルギー(= 作用汎関数)を最小化する電位分布(= 軌道)をオイラー・ラグランジュ方程式を解けば求まることが言える。

しかし、ここではオイラー・ラグランジュ方程式をそのまま解くのではなく、上記の原理を逆に利用し、オイラー・ラグランジュ方程式中のラグランジアンからポテンシャルエネルギーを計算し、その最小化を目指すことを考える。

具体的には、二次元の静電場を考え、静電場の支配方程式であるラプラス方程式 $\nabla \cdot \nabla u = 0$ について、オイラー・ラグランジュ方程式と同型に変形することでラグランジアンを電位の関数として定め、そのラグランジアンの積分からなるポテンシャルエネルギーを最小化する問題を考える。(本当はポアソン方程式 $\nabla \cdot \nabla u = f$ を考えるべきなのだが、ここでは簡単のため右辺を0にしたラプラス方程式で妥協している)

### 定式化

二次元オイラー・ラグランジュ方程式

$$
\frac{\partial}{\partial x} \frac{\partial h}{\partial \frac{\partial u}{\partial x}} + \frac{\partial}{\partial y} \frac{\partial h}{\partial \frac{\partial u}{\partial y}} - \frac{\partial h}{\partial u} = 0
\\ 
\\ (1)
$$

について、ラグランジアン $h$ を

$$
h = \frac{1}{2}(\frac{\partial u}{\partial x})^2 + \frac{1}{2}(\frac{\partial u}{\partial y})^2 
\\ 
\\ u(x, y): 電位
$$

として解けば、ラプラス方程式

$$
\frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} = 0
$$

に帰着できることからラグランジアン $h$ が定まる。

この時、作用汎関数であるポテンシャルエネルギー $X(u)$ は、ラグランジアン $h$ を用いて、その領域内積分

$$
X(u) = \int \int h(x, y, \frac{\partial u}{\partial x}, \frac{\partial u}{\partial y}) \ dxdy
$$

で表される。後はこの $X(u)$ を最小化する、つまり一般化運動方程式

$$
\frac{\delta X(u)}{\delta u} = 0
$$

を考えれば良い。

### 形状関数

さて、これで静電場における変分原理の適用はできたわけだが、$u(x, y)$ の形状が分からない為、このままでは折角定式化した一般化運動方程式が解けずに困ってしまう。

そこで活躍するのが**有限要素法**(**FEM**)である。以下

- 次元: 2
- エレメント: 3
- 近似: 1次
- 物理量: 電位

と仮定する。

FEMでは、位置 $(x, y)$ における電位 $u(x, y)$ について、計算領域内に一定数のノードをばら撒き、そのノードを繋いでできる3角形の**要素**(**エレメント**)で領域を分割する。
- ここで、要素は有限サイズの多角形のため、曲面に対しては領域を多角形で近似している事に注意。

そして分割した領域について、電位を各エレメント $e$ 毎に、ある1次式 $u_e(x, y)$ で近似する。

ここで、$u_e(x, y)$ を適当な1次の関数 $u(x, y) = a_1 x + a_2 y + a_3$ などで表されることを考えてみる。

しかし、**係数 $a_i$ はエレメント及びそれを構成するノードに直接対応しない変数**のため、このままでは扱いづらい。

そこで、ノードの情報だけでこの式を表すため、**各ノードの座標と電位** $(x_i, \ y_i, \ u(x_i, y_i))$を代入して、これらを変数とした関数で表すことを考える。

具体的には

$$
u_e(N_i, u_i) = \Sigma_{i=1}^3 N_i u_i
\\  
\\ N_i(x_i, y_i) = \frac{1}{2S}(a_i x + b_i y + c_i)
\\  
\\ S: Element's \ Area
\\ a_i = y_j - y_k
\\ b_i = x_k - x_j
\\ c_i = x_j y_k - x_k y_j
\\  
\\ (i, j, k) = (1,2,3), (2,3,1), (3,2,1)
$$

のように表される。こうして表現された $u_e(N_i, u_i)$ を**形状関数**という。

ここで、**隣接するエレメント間の形状関数の連続性は、互いに一部のノードを共有しており、かつ形状関数がノード間の電位をノードの電位で補間する関数であること**によって担保されていることに注意。

### 形状関数による一般化運動方程式の連立方程式化

上述した形状関数 $u_e(N_i, u_i)$ によって、求める電位 $u(x, y)$ の形状をエレメントごとに、そのエレメントを構成するノードの情報(座標と電位)によって近似することができた。

これにより、一般化運動方程式

$$
\frac{\delta X(u)}{\delta u} = 0
$$

について、実際の電位分布である連続関数 $u(x,y)$ を、各エレメントにおける近似的な電位の関数である形状関数 $u_e(N_i, u_i)$ の集合で近似していることから、各エレメント毎に$u$ の代わりに $u_e$ を用いて微分し、3つの方程式

$$
\frac{\partial X_e}{\partial u_i} = \frac{1}{4S}[ \ a_i\Sigma_{k=1}^3a_ku_k + b_i\Sigma_{k=1}^3b_ku_k \ ] = 0
$$

を得る。これを領域全体について拡張すると、全体のポテンシャルエネルギー $X$ は各エレメントのポテンシャルエネルギー $X_e$ の総和であり、結局一般化運動方程式は

$$
\frac{\partial (\Sigma_{e=1}^E X_e)}{\delta u_i} = 0
\\ 
\\ E: エレメント数
$$

が全てのノード $u_i$ 上で成り立てば良いことがわかる。

ここで、ポテンシャルエネルギーはエレメント毎に分割されているが、偏微分対象の変数はノード毎になっており、全体としては、**各エレメント毎に、その範囲内でのポテンシャルエネルギーについて、どのノードの電位変数について偏微分しても0**という条件を意味していることに注意。

但し、上の式では対象のノードを含まないエレメントについても計算してしまっているので、これらを除くと

$$
\forall i \in \Omega \qquad \frac{\partial (\Sigma_{i \in e} X_e)}{\delta u_i} = 0 
$$

が正しい定式化となる。

### 境界条件

さて、実は上の方程式は、変数(各ノードにおける電位 $u_e$)の個数と、方程式の数(各ノードにおける偏微分方程式、実際には形状関数が代入されているため単なる電位 $u_e$ の線型方程式)の個数が一致する(どちらもノード点に等しい)ため、実は**もう解くことができる**。しかし、ここで疑問が生じる。

FDM, FEMといった離散化技術とは別に、一般にある領域に対しての微分方程式を解く場合、何らかの境界条件が与えられる必要がある。例として、上記の二次元ポアソン方程式 $\nabla \cdot \gamma \nabla u = 0$ ($u:$ 電場 $\gamma:$ 複素伝導率)
に対しては、

1. ディリクレ境界条件 
$$
\gamma u = g(x, y)
$$
2. ノイマン境界条件
$$
\gamma \ \frac{\partial u}{\partial n} = g(x, y)
$$

のいずれかが課される。これらはどこに行ってしまったのだろうか?

実は、これは定式化の際に支配方程式として、ラプラス方程式

$$
\frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} = 0
$$

を選んだ際に、暗黙の内に取り込んでしまっていたのである。上の方程式では右辺を0としているが、より一般的な静電場に対するFEMの定式化には、**ノイマン境界条件を考慮したポアソン方程式**

$$
(x,y) \in \Omega \qquad \frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} = - \frac{\rho}{\epsilon} 
\\ \quad
\\(x,y) \in \Gamma \qquad \frac{\partial u}{\partial \vec{n}} = g(x,y) 
$$

を支配方程式として用いるべきである。ここで、この方程式に対して $\rho = 0, \quad g(x,y) = const.$ としてしまえば、2つ目のノイマン境界条件を微分した式は1つ目のポアソン方程式と同一であるため、ノイマン境界条件の特殊形 ( $g(x,y) = const.$ ) が暗黙のうちに取り込まれてしまっていたことがわかる。

実際の問題を解く場合、これでは困ってしまうので、実質的な電極に当たる外周ノードについては、ポテンシャルエネルギーの偏微分を考慮しないとすることで境界条件を要求するのだが、これは、周囲の4つのノードがある内側のノードについては対応する差分方程式が立式できるものの、不足がある外側のノードはそのままだと差分方程式が立式できない為に境界条件を要求するFDMと比較すると、やや場当たり的な要求に感じる。

しかし実は、FEMもFDM同様に「境界面上のノードについては偏微分を行ってはいけない」という制約が存在することが分かる。これは、変分原理の要請である「始点と終点は固定されており、条件が境界条件として記述されること」に由来している。

具体的には、前節で述べた最速降下曲線の問題で、始点Aと終点Bに対しては、$\delta f(A) = \delta f(B) = 0$ と固定されていた事を思い出すと良い。

今回の2次元静電場の問題においては、領域境界がそれに当たる為、結局FEMにおいてもFDMと同様に、自然な形で領域内部はポテンシャルエネルギーの最小化、外周は境界条件を要求するという理論が成立する。

# 弱形式に基づくFEMの定式化

[弱形式による議論](https://www.jstage.jst.go.jp/article/sicejl/56/11/56_827/_pdf)では、上記で言及した「ノイマン境界条件=印加電流(領域境界上ノードにおける電位勾配)を課した状態での作用=静電ポテンシャルエネルギーの最小化問題」

$$
(x,y) \in \Omega \qquad \frac{\partial^2 u}{\partial x^2} + \frac{\partial^2 u}{\partial y^2} = - \frac{\rho}{\epsilon} 
\\ \quad
\\(x,y) \in \Gamma \qquad \frac{\partial u}{\partial \vec{n}} = g(x,y)
$$

と、式(15)

$$
$$

で示される「各ノードについて、境界面上エレメントでの印加電流と(補間関数で表された)各ノード電位との積( $(I/S)*(VdS)=IV=Energy$ )を足し合わせた値と、領域内静電ポテンシャルエネルギー(エレメント毎に $(\sigma / 2)  \int \ \vec{E} \cdot \vec{E} \ dV$ を足し合わせた)が等しい」という2つの式は等価である

- (15)の左辺が分かりづらいが、結局これは印加電流とそれが加えられる位置でのポテンシャルの積なので、電流が領域内に供給するポテンシャルエネルギーということ

## FEMの特徴

### 有限差分法(FDM)と有限要素法(FEM)

FDMとFEMは、どちらもある支配方程式で表現される物理量について、一定領域内での値の分布を得る手法であるが、仕組みは大きく異なる。以下、静電場(物理量: 電位、支配方程式: ポアソン方程式)の例を通じて両者を比較する。

FDM

1. 対象領域中にノードを**一定間隔で**配置
2. 各ノードについて、物理量の違いに着目し、支配方程式(例: ポアソン方程式)を**位置変数**についての差分方程式として離散化
3. それぞれのノードについて得た方程式と、境界条件を連立して解く

FEM

1. 対象領域中にノードを配置(**ランダムでも良い**)
2. 複数のノードから成るエレメント(n角形領域)について、エレメント内の物理量分布を表す方程式(**形状関数**)を、エレメントを構成する各ノードの物理量を係数とする超平面方程式の線形結合によって補間(1次式が基本だが高次も可)することで得る
3. オイラー・ラグランジュ方程式が対象の物理量の支配方程式と同型になるようなラグランジュ関数(物理量の関数)を設定
4.  形状関数を代入した支配方程式を、3. で導出したラグランジュの領域内積分で求まる作用汎関数(例: 静電ポテンシャルエネルギー)に代入し、**変分原理**を用いて作用汎関数の偏微分方程式を立式
5.  4. の偏微分方程式が、代入した形状関数によって各ノードの物理量の変数(例: 電位)についての単なる方程式になっていることを利用、それぞれのノードについての方程式と、境界条件を連立して解く

FEMがFDMよりも優れるのがノードの配置の自由度の高さ
