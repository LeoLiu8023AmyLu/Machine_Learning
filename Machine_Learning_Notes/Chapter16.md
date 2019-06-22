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

# 异常检测 {ignore=true}

[TOC]

## 异常定义

异常点就是与数据集大部分数据分布不一致的数据。
按照数据分布的概率来表示：
* $p(x_{test}) < \varepsilon$ 不正常
* $p(x_{test}) \geqslant \varepsilon$ 正常 

Ps: 分布正中心概率越大，离中心越远概率越小

异常检测可以应用于：
* 欺骗行为检测
* 制造业
* 计算机集群监控

## 高斯分布(正太分布)
高斯分布定义：$x \in \R$ , $x$ 的期望( mean )为 $\mu$,方差( variance )为 $\sigma^2$ ， 记为 $x \sim N(\mu,\sigma^2)$。
高斯分布的数学公式为：$p(x;\mu,\sigma^2) = \dfrac{1}{\sqrt{2\pi} \sigma} ~ e^{-\dfrac{(x-\mu)^2}{2\sigma^2}}$

高斯分布特性：
1. 高斯分布的曲线积分面积为 $1$
2. $\sigma$ 越大，概率的最高点越低，$\sigma = 1$ 时，最大概率为 $0.4$
3. $\mu$ 控制概率分布的中心位置

参数估计是指假定一组数据集服从高斯分布(正态分布),然后通过计算得到 $\mu$ 与 $\sigma$ (极大似然估计)
* $\mu = \dfrac{1}{m} \sum^m_{i=1} x^{(i)}$
* $\sigma^2 = \dfrac{1}{m} \sum^m_{i=1}(x^{(i)}-\mu)^2$


## 异常检测算法
密度估计，假设训练集 $\{x^{(i)},...,x^{(m)} \}$，其中 $x \in \R^n$

$p(x) = p(x_1;\mu_1,\sigma_1^2)p(x_2;\mu_2,\sigma_2^2)...p(x_n;\mu_n,\sigma_n^2)$
简写为：$p(x)=\prod^n_{j=1} p(x_j;\mu_j,\sigma_j^2)$

**总结异常检测算法**
1. 选择可能表征异常样本的特征 $x_i$
2. 计算参数 $\mu_1,...,\mu_n$ 以及 $\sigma^2_1,...,\sigma^2_n$
   * $\mu_j = \dfrac{1}{m} \sum^m_{i=1} x_j^{(i)}$
   * $\sigma_j^2 = \dfrac{1}{m} \sum^m_{i=1}(x_j^{(i)}-\mu_j)^2$
3. 提供一个样本 $x$ 计算 $p(x)$:
   $p(x)=\prod^n_{j=1} p(x_j;\mu_j,\sigma_j^2) = \prod^n_{j=1} \dfrac{1}{\sqrt{2\pi}\sigma_j}~e^{-\dfrac{(x_j-\mu_j)^2}{2\sigma_j^2}}$
   如果 $p(x) < \varepsilon$ 则是异常值

## 异常检测算法的开发与评估
组建**训练集**、**检查验证集**以及**测试集**，假设训练集中有少量异常样本，交叉验证集与测试集都包含一定一直的异常值。不推荐交叉验证机与测试集使用相同的数据。

$$y=\begin{cases}1 ~ \text{if} p(x) < \varepsilon ~ (\text{anomaly})\\ 0 ~ \text{if} p(x) \geqslant \varepsilon ~ (\text{nomaly})\end{cases}$$

可用于评估的度量：
* TP FP FN TN
* 准确率 / 召回率
* $F_1$ 分数

我们也可以使用交叉验证集来选取参数 $\varepsilon$

## 异常检测与监督学习

区别对比：
|         异常检测         |       监督学习       |
| :----------------------: | :------------------: |
| 异常样本少，正常样本很多 | 正样本与负样本都很多 |

应用：
|    异常检测    |    监督学习    |
| :------------: | :------------: |
| * 欺骗行为识别 | * 垃圾邮件分类 |
|    * 制造业    |   * 天气预测   |
|  * 计算机监控  |   * 癌症分类   |


@import "index.md"