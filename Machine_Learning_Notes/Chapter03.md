# 线性回归回顾
## 矩阵与向量
### 矩阵
* **Matrix** 矩阵 ：Rectangular array of numbers 矩形数组 :
	> </br>$\begin{bmatrix} 1402 & 191 \\ 1371 & 821 \\ 949 & 1437 \\ 147 & 1448 \end{bmatrix}$ 或者 $\begin{bmatrix} 1 & 2 & 3 \\ 4 & 5 & 6 \end{bmatrix}$
	> </br>

* Dimension of matrix 矩阵的尺寸 : number of rows $\times$ numbers of columns 行数 $\times$ 列数
	> </br>第一个矩阵是 $ 4 \times 2$ 矩阵( $\Re^{4 \times 2}$)，第二个矩阵是 $2 \times 3$ 矩阵
	> </br>

* Matrix Elements (entries of matrix) 矩阵元素 (矩阵元素表示)
	> </br>$A =\begin{bmatrix} 1402 & 191 \\ 1371 & 821 \\ 949 & 1437 \\ 147 & 1448	\end{bmatrix}$
	> </br>$A_{ij} =$ "$i,j$ entry" in the $i^{th}$ row , $j^{th}$ column 第 $i$ 行，第 $j$ 列.
	> </br>举例: $A_{11} = 1402 ,A_{12} = 191 , A_{32} = 1437 , A_{43}=undefined(error)$
	> </br>

### 向量
* **Vector** 向量 : An $n \times 1 $ matrix  ( 只有一列的矩阵 )
	> </br>$y = \begin{bmatrix} 460 \\ 232 \\ 315 \\ 178 \end{bmatrix}$ ， 4-dimensional vectors , $\Re^4$
	> </br>$y_i = i^{th} $ element (注意 0 -indexed 与 1 - indexed 两种引索方式)
	> </br>

## 加法 与 标量乘法
### Matrix Addition
举例 $\begin{bmatrix} 1 & 0 \\ 2 &5 \\3&1\end{bmatrix} + \begin{bmatrix} 4 & 0.5 \\ 2 & 5 \\ 0 & 1 \end{bmatrix} = \begin{bmatrix} 5 & 0.5 \\ 4 & 10 \\ 3 & 2 \end{bmatrix}$
> 相同维度的矩阵相加得到相同维度的矩阵，不同维度的矩阵不能进行加法运算

### Scalar Multiplication 标量乘法 (Scalar : real number 实数)
举例 :  
</br>$3 \times \begin{bmatrix} 1 & 0 \\ 2 &5 \\3&1\end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 2 &5 \\3&1\end{bmatrix} \times 3 = \begin{bmatrix} 3 & 0 \\ 6 & 15 \\ 9 & 3 \end{bmatrix}$  
</br>
$\begin{bmatrix} 4 & 0 \\ 6 & 3 \end{bmatrix} / 4 = \dfrac{1}{4} \begin{bmatrix} 4 & 0 \\ 6 & 3 \end{bmatrix} = \begin{bmatrix} 1 & 0 \\ 3/2 & 3/4 \end{bmatrix}$
</br>
> 乘法得到的矩阵与之前矩阵维度相同

### Combination of Operands 组合运算
举例: $3 \times \begin{bmatrix} 1 \\ 4 \\ 2 \end{bmatrix} + \begin{bmatrix} 0 \\ 0 \\ 5 \end{bmatrix} -\begin{bmatrix} 3 \\ 0 \\ 2 \end{bmatrix} /3 =\begin{bmatrix} 3 \\ 12 \\ 6 \end{bmatrix} + \begin{bmatrix} 0 \\ 0 \\ 5 \end{bmatrix} - \begin{bmatrix} 1 \\ 0 \\ 2/3 \end{bmatrix} = \begin{bmatrix} 2 \\ 12 \\ 10\dfrac{1}{3} \end{bmatrix}$

## 矩阵向量乘法
举例: $\begin{bmatrix}1&3\\4&0\\2&1\end{bmatrix}*\begin{bmatrix}1\\5\end{bmatrix} = \begin{bmatrix}1\times1+3\times5 = 16 \\4\times1+0\times5 = 4\\2\times1+1\times5 = 7 \end{bmatrix} = \begin{bmatrix}16\\4\\7\end{bmatrix}$

### Details 运算细节
运算数学表达式 : $A \times x = y$
> </br>$A$ : $m \times n$ matrix ( $m$ rows , $n$ columns )
> $x$ : $n \times 1$ matrix ( $n$-dimensional vector )
> $y$ : $m \times 1$ matrix ( $m$-dimensional vector )
> </br>矩阵的 **列数** 必须与后矩阵的 **行数** 相同
> </br>

To get $y_i$ , multiply $A's \ i^{th}$ row with elements of vector $x$, and add them up.
> 若要获得 $y_i$ 需要矩阵 $A$ 用第 $i^{th}$ 行乘 向量 $x$ 中的每个元素 并相加

举例： $\begin{bmatrix}1&2&1&5\\0&3&0&4\\-1&-2&0&0\end{bmatrix} \begin{bmatrix}1\\3\\2\\1\end{bmatrix} = \begin{bmatrix}14\\13\\-7\end{bmatrix}$
计算过程:
> </br>$1\times1+2\times3+2\times1+1\times5=1+6+2+5=14$
> </br>$0\times1+3\times3+0\times1+4\times5=0+9+0+4=13$
> </br>$(-1)\times1+(-2)\times3+0\times1+0\times5=-1-6+0+0=-7$
> </br>

### 矩阵向量乘法应用技巧
举例:
* House sizes: [2104,1416,1534,852] 
* 房价预测假设方程: $h_\theta(x)=-40+0.25x$
> </br>房屋大小转化为矩阵: $\begin{bmatrix}1&2104\\1&1416\\1&1534\\1&852\end{bmatrix}$
> 
> 方程参数转化为向量: $\begin{bmatrix}-40\\0.25\end{bmatrix}$
>
> 计算 $\begin{bmatrix}1&2104\\1&1416\\1&1534\\1&852\end{bmatrix} \times \begin{bmatrix}-40\\0.25\end{bmatrix} = \begin{bmatrix}
> 1\times(-40) + 2104\times0.25\\
> 1\times(-40) + 1416\times0.25\\
> 1\times(-40) + 1535\times0.25\\
> 1\times(-40) + 852\times0.25\\\end{bmatrix} = \begin{bmatrix}h_\theta(2104)\\h_\theta(1416)\\h_\theta(1534)\\h_\theta(852)\end{bmatrix}$
> 
> 得到每个不同尺寸的房子的预测房价 **预测 = 数据矩阵 * 参数**
> </br>

## 矩阵乘法 (关键数学概念)
举例：
$\begin{bmatrix}1&3&2\\4&0&1\end{bmatrix}\begin{bmatrix}1&3\\0&1\\5&2\end{bmatrix}$
单列计算方式:
1. $\begin{bmatrix}1&3&2\\4&0&1\end{bmatrix}\times\begin{bmatrix}1\\0\\5\end{bmatrix} = \begin{bmatrix}11\\9\end{bmatrix}$
</br>
2. $\begin{bmatrix}1&3&2\\4&0&1\end{bmatrix}\times\begin{bmatrix}3\\1\\2\end{bmatrix} = \begin{bmatrix}10\\14\end{bmatrix}$

组合结果:
$\begin{bmatrix}1&3&2\\4&0&1\end{bmatrix}\begin{bmatrix}1&3\\0&1\\5&2\end{bmatrix} = \begin{bmatrix}11&10\\9&14\end{bmatrix}$

> $\textcolor{red}{2}\times\textcolor{blue}{3}$ 矩阵 乘上 $\textcolor{blue}{3}\times\textcolor{red}{2}$ 矩阵，结果为 $\textcolor{red}{2}\times\textcolor{red}{2}$ 矩阵

### Details 运算细节
数学运算公示 : $A \times B = C$
> </br>$A$ : $\textcolor{red}{m} \times \textcolor{blue}{n}$ matrix ( $m$ rows , $n$ columns )
> $B$ : $\textcolor{blue}{n} \times \textcolor{red}{o}$ matrix ( $n$ rows , $o$ columns )
> $C$ : $\textcolor{red}{m} \times \textcolor{red}{o}$ matrix ( $m$ rows , $o$ columns )
> 
> 规律：
> * 前矩阵的 **列数** 必须与后矩阵的 **行数** 相同
> * 结果矩阵维度为 前矩阵 **行数** $\times$ 后矩阵 **列数**
> * 矩阵与向量相乘 可以看做 $o=1$
> </br>

### 矩阵向量乘法应用技巧
举例:
* House sizes: [2104,1416,1534,852] 
* 房价预测假设方程: 
	1. $h_\theta(x)=-40+0.25x$
	2. $h_\theta(x)=200+0.1x$
	3. $h_\theta(x)=-150+0.4x$

> </br>房屋大小转化为矩阵: $\begin{bmatrix}1&2104\\1&1416\\1&1534\\1&852\end{bmatrix}$
> 
> 方程参数转化为向量: $\begin{bmatrix}-40&200&-150\\0.25&0.1&0.4\end{bmatrix}$
>
> 计算 $\begin{bmatrix}1&2104\\1&1416\\1&1534\\1&852\end{bmatrix} \times \begin{bmatrix}-40&200&-150\\0.25&0.1&0.4\end{bmatrix} = \begin{bmatrix}h_{\theta 1}(2104)&h_{\theta 2}(2104)&h_{\theta 3}(2104)\\h_{\theta 1}(1416)&h_{\theta 2}(1416)&h_{\theta 3}(1416)\\h_{\theta 1}(1534)&h_{\theta 2}(1534)&h_{\theta 3}(1534)\\h_{\theta 1}(852)&h_{\theta 2}(852)&h_{\theta 3}(852)\end{bmatrix} = \begin{bmatrix}486&410&692\\314&342&416\\344&353&464\\173&285&191\end{bmatrix}$
> 
> 得到每个不同尺寸的房子的预测房价 **预测 = 数据矩阵 * 参数**
> </br>

## 矩阵乘法特征
1. 标量运算有乘法交换律，矩阵运算 **不符合** 交换律
	> </br>$A \times B \ne B \times A$ (not commutative 不符合乘法交换律)
	> 举例:
	> * $\begin{bmatrix}1&1\\0&0\end{bmatrix} \begin{bmatrix}0&0\\2&0\end{bmatrix} = \begin{bmatrix}2&0\\0&0\end{bmatrix}$
	> * $\begin{bmatrix}0&0\\2&0\end{bmatrix} \begin{bmatrix}1&1\\0&0\end{bmatrix} = \begin{bmatrix}0&0\\2&2\end{bmatrix}$
	> 证明细节:
	> 假设 $A$ 是 $m \times n$ 矩阵，$B$ 是 $n \times m$ 矩阵
	> * $A \times B$ 结果为 $m \times m$ 矩阵
	> * $B \times A$ 结果为 $n \times n$ 矩阵
	> 因此矩阵乘法不符合交换律
	> </br>

2. 标量运算符合结合律，矩阵运算也 **符合** 结合律
	> </br>$A \times B \times C$ 
	> Let $D = B \times C$ Compute $A \times D = A \times (B \times C)$
	> Let $E = A \times B$ Compute $E \times C = (A \times B) \times C$
	> </br>

3. Identity Matrix (Special Matrix) 单位矩阵
	> </br>1 可以看作是单位数字，$1*z=z*1=z$
	> Denoted $I$ (or $I_{n \times n}$) 表示为 $I$
	> **举例**:
	> * 2*2 单位矩阵 $\begin{bmatrix}1&0\\0&1\end{bmatrix}$ 
	> * 3*3 单位矩阵 $\begin{bmatrix}1&0&0\\0&1&0\\0&0&1\end{bmatrix}$ 
	> * 4*4 单位矩阵 $\begin{bmatrix}1&0&0&0\\0&1&0&0\\0&0&1&0\\0&0&0&1\end{bmatrix}$ 
	>
	> **特征**:
	> * 对角为 **1**，其余为 **0**
	> * $A \times I = I \times A = A$ (设 $A$ 为 $ m \times n$ 矩阵)
	> </br>
	 
	第一个 $I$ 矩阵为 $n \times n$ 矩阵
	第二个 $I$ 矩阵为 $m \times m$ 矩阵

## 矩阵逆运算与矩阵转置运算
### 逆
倒数
> </br>$3*3^{-1}=1$ , $12*12^{-1}=1$
> 0 没有倒数
> </br>

Matrix inverse 逆矩阵:
if $A$ is an $m \times m$ matrix , and if is has an inverse, only square matrix ( row = columns ) 
$A A^{-1}=A^{-1}A=I$
> 只有正方形矩阵才有逆矩阵 行列数相同

举例：
$\begin{bmatrix}3&4\\2&16\end{bmatrix}\begin{bmatrix}0.4&-0.1\\-0.05&0.075\end{bmatrix}=\begin{bmatrix}1&0\\0&1\end{bmatrix}=I_{2 \times 2}$

### 转置
Matrix Transpose 矩阵转置:
举例:
$A = \begin{bmatrix}1&2&0\\3&5&9\end{bmatrix}$ 

$A^T = \begin{bmatrix}1&3\\2&5\\0&9\end{bmatrix}$ 

假设 $A$ 是一个 $m \times n$ 的矩阵，设 $B = A^T$, 则 $B$ 是一个 $n \times m$ 的矩阵
> 存在关系: $B_{ij} = A_{ji}$


上一章 [单变量线性回归](./Chapter02.md)
下一章 [多变量线性回归](./Chapter05.md)
[返回目录](./Topic.md)