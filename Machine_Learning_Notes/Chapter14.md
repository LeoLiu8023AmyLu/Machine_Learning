# 无监督学习

**有监督学习** : 有数据，有标签
**无监督学习** : 有数据, 无标签

## 聚类算法 Clustering : K-Means

K-Means k 均值算法 流程
1. 初始化 $K$ 值， 随机生成 聚类中心点 $\mu_1,\mu_2,...,\mu_K$ ($K$个类别)
2. 循环 (循环到结果不再变化)
   1. 循环样本 $i=1,...,m$，得到 $\begin{bmatrix}\lVert x^{(i)} - \mu_1\rVert^2 \\\lVert x^{(i)} - \mu_2\rVert^2 \\ \vdots \\ \lVert x^{(i)} -  \mu_K\rVert^2 \end{bmatrix} = \lVert X^{(i)} - \mu_K\rVert^2$
   找出 $\underset{K}{min}\lVert X^{(i)} - \mu_K\rVert^2$ 时的 $K$ 值，赋给$c^{(i)}$ 
   即: $c^{(i)} = \underset{K}{min}\lVert X^{(i)} - \mu_K\rVert^2$
   1. 计算均值并移动

