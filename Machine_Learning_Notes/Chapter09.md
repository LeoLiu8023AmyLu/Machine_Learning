---
html:
  embed_local_images: true
  embed_svg: true
  offline: false
  toc: true
print_background: true

export_on_save:
  html: true

toc:
  depth_from: 1
  depth_to: 6
  ordered: true
---

# 神经网络学习 {ignore=true}

[TOC]

## 非线性假设
当特征 $n$ 很多的时候，多项式拟合便不再适用。
图像数据是高维度的矩阵，因此 使用 非线性假设 会事半功倍。
> $50 \times 50$ 像素的图像 具有 $2500$ 个像素，如果是 $RGB$ 彩色图像，特征会有 $7500$ 个
> 
> 图像的特征 表示为 $x=\begin{bmatrix}pixel \ 1 \ intensity\\ pixel \ 2 \ intensity\\ \vdots \\ pixel \ 2500 \ intensity \end{bmatrix}$ 
> 
> intensity 取值 在 $ intensity \in [0,255]$

## 神经元 与 大脑

### 神经网络
神经元为大脑神经网络的最基本组成单元，我们可以抽象这个结构模型。
``` mermaid
graph LR
    A((x0)) --> E((神经元))
    B((x1)) --> E
    C((x2)) --> E
    D((x3)) --> E
    E --> F(( 输出 ))
```

数学逻辑抽象：

$$
\begin{bmatrix}x_0\\x_1\\x_2\\x_3\end{bmatrix} \begin{bmatrix}a_0\\a_1\end{bmatrix} \Rarr h_\Theta(x)
$$

> $x_0$ , $a_0$ 偏差单元 一般可以省略；
> 输出函数 : $h_\theta(x) = \dfrac{1}{1+e^{-\theta^Tx}}$
> Sigmoid ( logistic ) activation function :  $g(z) = \dfrac{1}{1+e^{-z}}$

### 多层神经网络

$$
\begin{bmatrix}x_0\\x_1\\x_2\\x_3\end{bmatrix} \Rarr \begin{bmatrix}a_0^{(2)}\\a_1^{(2)}\\a_2^{(2)}\\a_3^{(2)}\end{bmatrix} \Rarr \begin{bmatrix}a_0^{(3)}\\a_1^{(3)}\\a_2^{(3)}\\a_3^{(3)}\end{bmatrix} \Rarr \begin{bmatrix}a_0^{(4)}\\a_1^{(4)}\end{bmatrix} \Rarr h_\Theta(x)
$$

* 第一层 称为 输入层 (Input Layer)
* 最后一层 称为 输出层 (Output Layer)
* 其余 层 称为 隐藏层 (Hidden Layer)
* $a_i^{(j)}$ 第 $j$ 层 的第 $i$ 个活动的神经单元
* $\Theta^{(j)}$ 第 $j$ 层的权重

> 如果 神经网络在第 $j$ 层有 $s_j$ 个单元；同理 神经网络在第 $j+1$ 层有 $s_{j+1}$ 个单元; 权重矩阵的维度为 $s_{j+1} \times (s_j + 1)$

## 前向传播

$a_1^{(2)} = g(\Theta^{(1)}_{10} x_0+\Theta^{(1)}_{11} x_1+\Theta^{(1)}_{12} x_2+\Theta^{(1)}_{13} x_3)$ 
$a_2^{(2)} = g(\Theta^{(1)}_{20} x_0+\Theta^{(1)}_{21} x_1+\Theta^{(1)}_{22} x_2+\Theta^{(1)}_{23} x_3)$
$a_3^{(2)} = g(\Theta^{(1)}_{30} x_0+\Theta^{(1)}_{31} x_1+\Theta^{(1)}_{32} x_2+\Theta^{(1)}_{33} x_3)$

$h_{\Theta}(x) = g(\Theta^{(2)}_{10} a_0+\Theta^{(2)}_{11} a_1+\Theta^{(2)}_{12} a_2+\Theta^{(2)}_{13} a_3)$

> 其中定义 $z_1^{(2)} = \Theta^{(1)}_{10} x_0+\Theta^{(1)}_{11} x_1+\Theta^{(1)}_{12} x_2+\Theta^{(1)}_{13} x_3$ 
> 
> $x = \begin{bmatrix}x_0\\x_1\\x_2\\x_3\end{bmatrix}$ , $z^{(2)} = \begin{bmatrix}z_1^{(2)}\\z_2^{(2)}\\z_3^{(2)}\end{bmatrix} = \Theta^{(1)}x$ , $a^{(2)} = g(z^{(2)}) = g(\Theta^{(1)}x)$

### 例子
* **AND 与运算**  $h_\Theta(x) = g(-30+20*x_1+20*x_2)$
    | $x_1$ | $x_2$ |   $h_\Theta(x)$    |
    | :---: | :---: | :----------------: |
    |   0   |   0   | $g(-30) \approx 0$ |
    |   0   |   1   | $g(-10) \approx 0$ |
    |   1   |   0   | $g(-10) \approx 0$ |
    |   1   |   1   | $g(10) \approx 1$  |

* **OR 或运算**  $h_\Theta(x) = g(-10+20*x_1+20*x_2)$
    | $x_1$ | $x_2$ |   $h_\Theta(x)$    |
    | :---: | :---: | :----------------: |
    |   0   |   0   | $g(-10) \approx 0$ |
    |   0   |   1   | $g(10) \approx 1$  |
    |   1   |   0   | $g(10) \approx 1$  |
    |   1   |   1   | $g(30) \approx 1$  |

* **NOT 取反运算**  $h_\Theta(x) = g(10-20*x_1)$
    | $x_1$ |   $h_\Theta(x)$    |
    | :---: | :----------------: |
    |   0   | $g(10) \approx 1$  |
    |   1   | $g(-10) \approx 0$ |

* **XNOR 异或运算** 
  * AND : $a_1^{(2)}$  $x_1$ AND $x_2$ 
    > $a_1^{(2)} = g(-30+20*x_1+20*x_2)$
  * NOR : $a_2^{(2)}$  ( NOT $x_1$ ) AND ( NOT $x_2$ )
    > $a_2^{(2)} = g(10-20*x_1-20*x_2)$
  * OR  : $h_\Theta(x)$  $x_1$ OR $x_2$
    > $h_\Theta(x) = g(-10+20*a_1^{(2)}+20*a_2^{(2)})$

    | $x_1$ | $x_2$ | $a_1^{(2)}$ | $a_2^{(2)}$ | $h_\Theta(x)$ |
    | :---: | :---: | :---------: | :---------: | :-----------: |
    |   0   |   0   |      0      |      1      |       1       |
    |   0   |   1   |      0      |      0      |       0       |
    |   1   |   0   |      0      |      0      |       0       |
    |   1   |   1   |      1      |      0      |       1       |

* **XOR 异或运算**
  * AND : $a_1^{(2)}$  $x_1$ AND $x_2$ 
    > $a_1^{(2)} = g(-30+20*x_1+20*x_2)$
  * NOR : $a_2^{(2)}$  ( NOT $x_1$ ) AND ( NOT $x_2$ )
    > $a_2^{(2)} = g(10-20*x_1-20*x_2)$
  * NOR  : $h_\Theta(x)$  ( NOT $x_1$ ) AND ( NOT $x_2$ ) == NOT ( $x_1$ OR $x_2$ )
    > $h_\Theta(x) = g(10-20*a_1^{(2)}-20*a_2^{(2)})$

    | $x_1$ | $x_2$ | $a_1^{(2)}$ | $a_2^{(2)}$ | $h_\Theta(x)$ |
    | :---: | :---: | :---------: | :---------: | :-----------: |
    |   0   |   0   |      0      |      1      |       0       |
    |   0   |   1   |      0      |      0      |       1       |
    |   1   |   0   |      0      |      0      |       1       |
    |   1   |   1   |      1      |      0      |       0       |

## 多元分类
模型最后的输出是多个结果，例如 $h_\Theta(x) \in \Re^4$
* 训练集: $(x^{(1)},y^{(1)}),(x^{(2)},y^{(2)}),...,(x^{(m)},y^{(m)})$
  
* 输出 : $y^{(i)} \in \Biggl\{ \begin{bmatrix}1\\0\\0\\0\end{bmatrix},\begin{bmatrix}0\\1\\0\\0\end{bmatrix},\begin{bmatrix}0\\0\\1\\0\end{bmatrix},\begin{bmatrix}0\\0\\0\\1\end{bmatrix} \Biggr\}$ 

> 最后输出会采用一些方法 输出 得分最高的类别，以及其分数

## 反向传播

定义：
* $L$ 神经网络层数 total no. of layers in network
* $s_l$ 第 $l$ 层神经网络拥有的神经单元节点数 (不包括偏置单元) no. of units (not counting bias unit) in layer $l$
* $K$ 输出层的单元数 output unit 可以表示为: $s_L = K$
  * $K = 1$ 二分类任务 
  * $K > 2$ 多分类任务

## 代价函数 Cost function
* 逻辑回归 Logistic regression :
$$
J(\theta) = - \dfrac{1}{m}\Biggr[ \sum^m_{i=1}y^{(i)} \log(h_\theta(x^{(i)})) + (1-y^{(i)}) \log(1-h_\theta(x^{(i)})) \Biggr] + \dfrac{\lambda}{2m}\sum^n_{j=1}\theta^2_j
$$
* 神经网络 Neural network :
$$
h_\Theta(x) \in \Re^K , (h_\Theta(x))_i = i^{th} output 
$$

$$
J(\Theta) = - \dfrac{1}{m}\Biggr[ \sum^m_{i=1} \sum^K_{k=1} y_k^{(i)} \log(h_\Theta(x^{(i)}))_k + (1-y_k^{(i)}) \log(1-(h_\Theta(x^{(i)}))_k) \Biggr] + \dfrac{\lambda}{2m}\sum^{L-1}_{l=1} \sum^{s_l}_{i=1} \sum^{s_{l+1}}_{j=1}(\Theta^{l}_{ji})^2
$$

## 梯度下降
$$
\underset{\Theta}{min} \ J(\Theta) = - \dfrac{1}{m}\Biggr[ \sum^m_{i=1} \sum^K_{k=1} y_k^{(i)} \log(h_\Theta(x^{(i)}))_k + (1-y_k^{(i)}) \log(1-(h_\Theta(x^{(i)}))_k) \Biggr] + \dfrac{\lambda}{2m}\sum^{L-1}_{l=1} \sum^{s_l}_{i=1} \sum^{s_{l+1}}_{j=1}(\Theta^{l}_{ji})^2
$$

需要计算的是：
* $J(\Theta)$
* $\dfrac{\partial}{\partial\Theta^{(l)}_{ij}} J(\Theta)$
> 其中 $\Theta^{(l)}_{ij} \in \Re$

### 简单例子
假设: 一组训练样本 $(x,y)$

神经网络结构：$\begin{bmatrix}x_1\\x_2\\x_3\end{bmatrix} \Rarr \begin{bmatrix}a_1^{(2)}\\a_2^{(2)}\\a_3^{(2)}\\a_4^{(2)}\\a_5^{(2)}\end{bmatrix} \Rarr \begin{bmatrix}a_1^{(3)}\\a_2^{(3)}\\a_3^{(3)}\\a_4^{(3)}\\a_5^{(3)}\end{bmatrix} \Rarr \begin{bmatrix}a_1^{(4)}\\a_2^{(4)}\\a_3^{(4)}\\a_4^{(4)}\end{bmatrix}$

* **前向传播**
    $a^{(1)} = x$
    $z^{(2)} = \Theta^{(1)}a^{(1)}$
    $a^{(2)} = g(z^{(2)}) \ \ (add \ a_0^{(2)})$
    $z^{(3)} = \Theta^{(2)}a^{(2)}$
    $a^{(3)} = g(z^{(3)}) \ \ (add \ a_0^{(3)})$
    $z^{(4)} = \Theta^{(3)}a^{(3)}$
    $a^{(4)} = h_\Theta(x) = g(z^{4})$

* **反向传播**
  $\delta^{(l)}_j$ : 第 $l$ 层 第 $j$ 个节点的误差 "error" of node $j$ in layer $l$.
  因此可以推导:
  $\delta^{(4)}_j = a^{(4)}_j - y_j = (h_\Theta(x))_j - y_j$ , 向量式写法 : $\delta^{(4)} = a^{(4)} - y$
  $\delta^{(3)} = (\Theta^{(3)})^T\delta^{(4)}.*g'(z^{(3)})$ 其中 $g'(z^{(3)}) = a^{(3)} .* (1-a^{(3)})$
  $\delta^{(2)} = (\Theta^{(2)})^T\delta^{(3)}.*g'(z^{(2)})$ 其中 $g'(z^{(2)}) = a^{(2)} .* (1-a^{(2)})$

  > 简单可以推导 : $\dfrac{\partial}{\partial\Theta^{(l)}_{ij}} J(\Theta) = a_j^{(l)} \delta_i^{(l+1)}$ (当 $\lambda = 0$ 需要忽略 $\lambda_j$ )

### 完整梯度下降算法流程
假设: 训练样本为 ${(x^{(1)},y^{(1)}),...,(x^{(m)},y^{(m)})}$ ，$\Delta^{(l)}_{ij} = 0$ (全部 $l,i,j$ 有效)

For $i$ = 1 to $m$ :
  1. 赋值 $a^{(1)} = x^{(i)}$ 
  2. 依次计算前向传播 $a^{(l)} \ \ l=2,3,...,L$ 
  3. 利用 $y^{(i)}$ 计算 $\delta^{(L)} = a^{(L)}-y^{(i)}$
  4. 计算误差: $\delta^{(L-1)},\delta^{(L-2)},...,\delta^{(2)}$
  5. 更新误差: $\Delta^{(l)}_{ij} := \Delta^{(l)}_ij + a^{(l)}_j\delta^{(l+1)}_i$ 向量形式的表达式: $\Delta^{(l)} := \Delta^{(l)} + \delta^{(l+1)}(a^{(l)})^T$   
  ( $l$ 的取值为 $l = 1,2,3,...,L-1$ )
  > </br>$D^{(l)}_{ij}:= \begin{cases} \dfrac{1}{m}\Delta^{(l)}_{ij} + \lambda\Theta^{(l)}_{ij} &\text{if } j \ne 0\\ \dfrac{1}{m}\Delta^{(l)}_{ij} &\text{if } j = 0 \end{cases}$
  >  
  > 简单推导可知: $\dfrac{\partial}{\partial\Theta^{(l)}_{ij}}J(\Theta) = D^{(l)}_{ij}$

### 举例理解反向传播
网络结构:
$$
\begin{bmatrix}+1\\x_1\\x_2\end{bmatrix} \Rightarrow 
\begin{bmatrix}+1\\a^{(2)}_1\\a^{(2)}_2\end{bmatrix} \Rightarrow 
\begin{bmatrix}+1\\a^{(3)}_1\\a^{(3)}_2\end{bmatrix} \Rightarrow 
\begin{bmatrix}h_\Theta(x)\end{bmatrix}
$$

* **前向传播**
$$
\begin{bmatrix}+1\\x_1\\x_2\end{bmatrix} \Rightarrow 
\begin{bmatrix}+1\\z^{(2)}_1 \to a^{(2)}_1\\z^{(2)}_2 \to a^{(2)}_2\end{bmatrix} \Rightarrow 
\begin{bmatrix}+1\\z^{(3)}_1 \to a^{(3)}_1\\z^{(3)}_2 \to a^{(3)}_2\end{bmatrix} \Rightarrow 
\begin{bmatrix}z^{(4)}_1 \to a^{(4)}_1\end{bmatrix}
$$
  > 其中  $z^{(l+1)}=\Theta^{(l)} a^{(l)}$ 注意 : $l= 1,2,...,L-1$

* **反向传播**
  代价函数:
  $$
    J(\Theta) = - \dfrac{1}{m}\Biggr[ \sum^m_{i=1} \sum^K_{k=1} y_k^{(i)} \log(h_\Theta(x^{(i)}))_k + (1-y_k^{(i)}) \log(1-(h_\Theta(x^{(i)}))_k) \Biggr] + \dfrac{\lambda}{2m}\sum^{L-1}_{l=1} \sum^{s_l}_{i=1} \sum^{s_{l+1}}_{j=1}(\Theta^{l}_{ji})^2
  $$
  假设只有一个训练样本，且忽略正则化($\lambda = 0$)
  则代价函数为: $cost(i)=y^{(i)} \log h_\Theta(x^{(i)})+(1-y^{(i)}) \log h_\Theta(x^{(i)})$
  已知 $\delta^{(l)}_j$ 为 $a^{(l)}_j$ 的误差 ( $a^{(l)}_j$ 为第 $l$ 层第 $j$ 个神经单元 )
  $\delta^{(l)}_j = \dfrac{\partial}{\partial z^{(l)}_j}cost(i)$  for $j \geqslant 0$
  反向传播网络示意图:
  $$
    \begin{bmatrix}\delta^{(2)}_0 = None\\ \delta^{(2)}_1 = \Theta^{(2)}_{11} \delta^{(3)}_1 + \Theta^{(2)}_{21} \delta^{(3)}_2\\ \delta^{(2)}_2 = \Theta^{(2)}_{12} \delta^{(3)}_1 + \Theta^{(2)}_{22} \delta^{(3)}_2 \end{bmatrix} \Leftarrow 
    \begin{bmatrix}\delta^{(3)}_0 =None\\ \delta^{(3)}_1 = \Theta^{(3)}_{11} \delta^{(4)}_1\\ \delta^{(3)}_2 = \Theta^{(3)}_{12} \delta^{(4)}_1 \end{bmatrix} \Leftarrow  
    \begin{bmatrix}\delta^{(4)}_1 = y^{i}-a^{(4)}_1 \end{bmatrix}
  $$

## 梯度检查 Gradient Checking

### 近似算法: 
* 双侧差分 : $\dfrac{\partial}{\partial\theta} J(\theta) \approx \dfrac{J(\theta+\epsilon)-J(\theta-\epsilon)}{2\epsilon}$ 其中 $\epsilon = 10^{-4}$ (一般采用这个方法)
* 单侧差分 : $\dfrac{\partial}{\partial\theta} J(\theta) \approx \dfrac{J(\theta+\epsilon)-J(\theta)}{\epsilon}$ 其中 $\epsilon = 10^{-4}$ (这个方法不是很准确,一般不采用)

**拓展为一般情况**:
$\theta \in \Re^n$ , $\theta = \theta_1,\theta_2,\theta_3,...,\theta_b$
$\dfrac{\partial}{\partial\theta_1} J(\theta) \approx \dfrac{J(\theta_1+\epsilon,\theta_2,\theta_3,...,\theta_n)-J(\theta_1-\epsilon,\theta_2,\theta_3,...,\theta_n)}{2\epsilon}$

$\dfrac{\partial}{\partial\theta_2} J(\theta) \approx \dfrac{J(\theta_1,\theta_2+\epsilon,\theta_3,...,\theta_n)-J(\theta_1,\theta_2-\epsilon,\theta_3,...,\theta_n)}{2\epsilon}$
$\ \ \ \ \vdots$
$\dfrac{\partial}{\partial\theta_n} J(\theta) \approx \dfrac{J(\theta_1,\theta_2,\theta_3,...,\theta_n+\epsilon)-J(\theta_1,\theta_2,\theta_3,...,\theta_n-\epsilon)}{2\epsilon}$

### 实现步骤:
1. 需要利用反向传播计算 $Dvec$ ( 其表达式为 : $\dfrac{\partial}{\partial\Theta^{(l)}_{ij}}J(\Theta) = D^{(l)}_{ij}$) ；
2. 使用数学 **双侧差分** 逼近的方法求出 梯度 $gradApprox$ ；
3. 判断 $Dvec \approx gradApprox$
4. 关闭 梯度检查，使用梯度下降算法进行训练学习;
> **提示**: 如果训练过程中忘记关闭 **剃度检查** ,训练速度将会非常非常的 **慢** !

## 随机初始化
为 $\Theta$ 初始化一些 初始值:
* Zero initialization 全部设置为 0 (不会起作用)
  隐藏层同一个节点会有来自上一层的相同的权重 $\Theta^{(l)}$
* Random initialization 随机初始化: (Symmetry breaking 非对称)
  初始化 $\Theta^{(l)}_ij$ 为在 $[-\epsilon,\epsilon]$ 间的任意值： $-\epsilon \leqslant \Theta^{(l)}_{ij} \leqslant \epsilon$
  > 这里的 $\epsilon$ 与 剃度检查中使用的 $\epsilon$ 不是同一个值，没有关联性；

## 总结回顾

训练神经网络流程:
1. 确定神经网络结构 ，例如 : [ 3,5,4 ] , [ 3,5,5,4 ] , [ 3,5,5,5,4 ] ...
    * 首先可以确定输入层 , 与 $x^{(i)}$ 维度相同
    * 其次可以确认输出层 , 与 分类数 相同
    * 隐藏层没有默认的选择，
      * 可以从简单的 **单隐藏层** 开始探索
      * 多层时，建议每层选用 **相同数量** 的神经元数量，或者采用 **整倍数的** 神经元数量
      * 通常情况，隐藏单元数 **越多越好**
2. 训练神经网络步骤:
   1. 随机初始化权重参数;
   2. **前向传播** 为每个 $x^{(i)}$ 计算 $h_\Theta(x^{(i)})$;
   3. 计算 **代价函数** $J(\Theta)$;
   4. **反向传播** 计算 偏导数 $\dfrac{\partial}{\partial \Theta^{(l)}_jk}J(\Theta)$;
        > 运行 **前向传播** 以及 **反向传播** 可以得到隐藏层 $a^{(l)}$ , 误差 $\delta^{(l)}$  for  $l=2,3,...,L$
   5. 使用 **剃度检查** 的方法验证 **反向传播** 与 **数学近似** (双侧差分) 方法是否结果相近; 如果没有问题则关闭 **剃度检查**;
   6. 结合 **反向传播** 算法 与 **梯度下降** 或 更高级的优化算法，计算 $J(\Theta)$ 接近最小时,参数 $\Theta$ 的值; 
        > **反向传播** 的方法是为了计算出 偏导数项: $\dfrac{\partial}{\partial \Theta^{(l)}_jk}J(\Theta)$;
        > $J(\Theta)$ 是非凸函数，因此 梯度下降 算法一般可以下降到局部最小值(非全局最优);

@import "index.md"