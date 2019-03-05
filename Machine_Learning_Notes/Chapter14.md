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

# 无监督学习 {ignore=true}

[TOC]

## 引言

**有监督学习** : 有数据，有标签
**无监督学习** : 有数据, 无标签

## 聚类算法 Clustering : K-Means

K-Means k 均值算法 流程
1. 初始化 $K$ 值， 随机生成 聚类中心点 $\mu_1,\mu_2,...,\mu_K$ ($K$个类别)
2. 循环 (循环到结果不再变化)
   1. **族分配** 
    循环样本 $i=1,...,m$，得到 $\begin{bmatrix}\lVert x^{(i)} - \mu_1\rVert^2 \\\lVert x^{(i)} - \mu_2\rVert^2 \\ \vdots \\ \lVert x^{(i)} -  \mu_K\rVert^2 \end{bmatrix} = \lVert X^{(i)} - \mu_K\rVert^2$
      * 找出 $\underset{K}{min}\lVert X^{(i)} - \mu_K\rVert^2$ 时的 $K$ 值，赋给$c^{(i)}$ 
      * 即: $c^{(i)} = \underset{K}{min}\lVert X^{(i)} - \mu_K\rVert^2$
   2. **移动聚类中心**
      * $\mu_k$ 更新为 聚类点 $k$ 所关联点的平均值
      * 如果聚类没有点分配关联，则重新随机产生聚类点，或者直接移除该点

## 优化目标

K-均值算法优化目标
* $c^{(i)}$ 为族($1,2,...,K$)的引索编号，表示样本 $x^{(i)}$ 相关联的族的序号;
* $\mu_k$ 表示 第$k$个聚类的中心 ($\mu_k \in \R^n$)
* $\mu_{c^{(i)}}$ 表示 $x^{(i)}$ 所关联的聚类族的中心

优化目标:
$\underset{\begin{matrix}c^{(1)},...,c^{(m)}\\ \mu_1,...,\mu_K\end{matrix}}{min}\ J(c^{(1)},...,c^{(m)},\mu_1,...,\mu_K) = \dfrac{1}{m} \sum^m_{i=1} \lVert x^{(i)} -\mu_{c^{(i)}} \rVert^2$

> 其中，$\lVert x^{(i)} -\mu_{c^{(i)}} \rVert^2$ 表示 **样本** 到与其相关联 **族中心** 的 **距离平方**

## 随机初始化

1. 方法1:随机抽取样本中不同的数据作为族的初始中心
   * 选取不超过样本的聚类族数 $K<m$
   * 随机选取 $K$ 个训练样本
   * 将抽取的样本，随机赋值给 $\mu_1,...,\mu_K$
   > **问题**：容易得到局部最优解，并非全局最优解
   > **解决方案**：可以尝试多次初始化，来找到最好的结果(最小的代价函数 $J(c^{(1)},...,c^{(m)},\mu_1,...,\mu_K)$ )
   > 方法适用于 $K \in [2,10]$ 族数较少的情况

## 选取聚类数量

没有太多可以自动化解决的方法，基本上是 **手动选择族数**

* 肘部选择法 (Elbow method) :
  * 代价函数曲线下降变缓的突变点就是解($K$)
  * 这个方法只适用于 曲线成“肘部”特征的曲线，平滑下降的情况不适用

* 为了下游目的，可以根据需求，反向思考得到 $K$ 值

@import "index.md"