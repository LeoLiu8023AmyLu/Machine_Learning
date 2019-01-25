# 神经网络学习

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
> $x_0$ 偏差单元 一般可以省略；
> 输出函数 : $h_\theta(x) = \dfrac{1}{1+e^{-\theta^Tx}}$
> Sigmoid ( logistic ) activation function :  $g(z) = \dfrac{1}{1+e^{-z}}$

多层神经网络
