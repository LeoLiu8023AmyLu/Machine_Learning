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
   1. 循环样本 $i=1,...,m$，得到 $\begin{bmatrix}\lVert x^{(i)} - \mu_1\rVert^2 \\\lVert x^{(i)} - \mu_2\rVert^2 \\ \vdots \\ \lVert x^{(i)} -  \mu_K\rVert^2 \end{bmatrix} = \lVert X^{(i)} - \mu_K\rVert^2$
      * 找出 $\underset{K}{min}\lVert X^{(i)} - \mu_K\rVert^2$ 时的 $K$ 值，赋给$c^{(i)}$ 
      * 即: $c^{(i)} = \underset{K}{min}\lVert X^{(i)} - \mu_K\rVert^2$
   2. 计算均值并移动聚类中心
      * $\mu_k$ 更新为 聚类点 $k$ 所关联点的平均值
      * 如果聚类没有点分配关联，则重新随机产生聚类点，或者直接移除该点

## 优化目标


@import "index.md"