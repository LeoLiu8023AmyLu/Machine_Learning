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

# 降维 {ignore=true}

[TOC]

## 数据压缩

简单来说，降维可以理解为 将 2D 数据 压缩为 1D 数据 (厘米 英寸 数据实际是一个维度的数据)
降维的好处可以降低空间(内存)的使用(即压缩数据)

3维数据可以投影到一个平面上，便可以使用两个参数($z_1,z_2$)表示了，从而达到压缩数据的效果。

## 数据可视化

可以通过可视化的形式，形象的理解数据

## PCA 主成分分析

找个低维度的线(面)，将数据投影到其上。核心是求最小化正交投影误差。(所有特征都平等对待)

PCA 算法步骤
假设 训练集： $x^{(1)},x^{(2)},...,x^{(m)}$
1. 标准归一化处理 (feature scaling / mean normalization)
  $\mu_j = \dfrac{1}{m} \sum^m_{i=1} x_j^{(i)}$
  之后使用 $x_j - \mu_j$ 来替换 $x_j^{(i)}$
2. 如果不同的特征值有不同的缩放范围，我们可以处理为标准差

拓展：将数据从 $n$ 维空间 降维到 $k$ 维空间，需要计算协方差矩阵(covarirance matrix)
$\Sigma = \dfrac{1}{m} \sum^n_{i=1}(x^{(i)})(x^{(i)})^T$
求取特征值 可以利用 $svd$ 计算方法(奇异值分解)

奇异值分解讲解：[奇异值分解](https://blog.csdn.net/u011251945/article/details/81362642)

取 $U$ 矩阵前 $k$ 列 组成新矩阵, 令 $Z=U_{k}^T X$ 其中 $U_k$ 是 $U$ 取前 $k$ 列组成的新矩阵 

总结：
1. 归一化，特征尺度缩放
2. 计算 $\Sigma$ Sigma 矩阵 $Sigma = \dfrac{1}{m} \sum^n_{i=1}(x^{(i)})(x^{(i)})^T$
3. 利用奇异值分解: $[U,S,V] = svd(Sigma)$
4. 组成新的矩阵 $U_{reduce} = U(:,1:k)$ U 矩阵前 $k$ 列
5. $Z = U_{reduce}^TX$

## 主成分数量选择
关于选择 $k$ PCA 算法中主成分的参数数字。

算法需要求得的误差：$\dfrac{1}{m} \sum^m_{i=1} \Vert x^{(i)} - x^{(i)}_{approx} \Vert^2$


@import "index.md"