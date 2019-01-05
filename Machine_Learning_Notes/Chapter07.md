# Logistics 回归 逻辑回归
## 分类
分类任务：
* 邮件: 是否是垃圾邮件
* 线上欺骗行为：是否是欺骗行为
* 肿瘤：是否是良性肿瘤

$y \in \{0,1\}$
* 0 : 'Negative Class' 负类
* 1 : 'Positive Class' 正类

其实还可以有 多元分类：$y \in \{0,1,2,3,4 ...\}$

假设 $h_{\theta}(x)$ 输出阈值设置为 0.5 ：
* 如果 $h_{\theta}(x) \geqslant 0.5$ , 预测为 "y=1" .
* 如果 $h_{\theta}(x) \lt 0.5$ , 预测为 "y=0" . 

> 加入某些样本会使线性回归变差

**分类** : y = 0 或者 y =1 , $h_{\theta}(x)$ 可以大于 1 也可以小于 0。
**逻辑回归** : $0 \leqslant h_{\theta}(x) \leqslant 1$

## 假设陈述
Logistic Regression Model 逻辑回归模型: $0 \leqslant h_{\theta}(x) \leqslant 1$
$h_{\theta}(x) = g(\theta^Tx)$ ，其中 $g(z)=\dfrac{1}{1+e^{-z}}$ 称为 `sigmoid function` sigmoid 函数 (Logistic function)。
结合后 $h_{\theta}(x) = \dfrac{1}{1+e^{-\theta^Tx}}$

Sigmoid 函数:
``` vega
{
  "$schema": "https://vega.github.io/schema/vega/v4.json",
  "width": 500,
  "height": 200,
  "padding": 5,

  "signals": [
    {
      "name": "interpolate",
      "value": "basis",
      "bind": {
        "input": "select",
        "options": [
          "basis",
          "cardinal",
          "catmull-rom",
          "linear",
          "monotone",
          "natural",
          "step",
          "step-after",
          "step-before"
        ]
      }
    }
  ],

  "data": [
    {
      "name": "table",
      "values": [
        {"x": -4, "y": 0, "c":0},
        {"x": -3, "y": 0, "c":0}, 
        {"x": -2, "y": 0, "c":0}, 
        {"x": -1, "y": 0.1, "c":0},
        {"x": 0, "y": 0.5, "c":0},
        {"x": 1, "y": 0.9, "c":0}, 
        {"x": 2, "y": 1, "c":0}, 
        {"x": 3, "y": 1, "c":0}, 
        {"x": 4, "y": 1, "c":0}
      ]
    }
  ],

  "scales": [
    {
      "name": "x",
      "type": "linear",
      "range": "width",
      "domain": {"data": "table", "field": "x"}
    },
    {
      "name": "y",
      "type": "linear",
      "range": "height",
      "nice": true,
      "zero": true,
      "domain": {"data": "table", "field": "y"}
    },
    {
      "name": "color",
      "type": "ordinal",
      "range": "category",
      "domain": {"data": "table", "field": "c"}
    }
  ],

  "axes": [
    {"orient": "bottom", "scale": "x"},
    {"orient": "left", "scale": "y"}
  ],

  "marks": [
    {
      "type": "group",
      "from": {
        "facet": {
          "name": "series",
          "data": "table",
          "groupby": "c"
        }
      },
      "marks": [
        {
          "type": "line",
          "from": {"data": "series"},
          "encode": {
            "enter": {
              "x": {"scale": "x", "field": "x"},
              "y": {"scale": "y", "field": "y"},
              "stroke": {"scale": "color", "field": "c"},
              "strokeWidth": {"value": 2}
            },
            "update": {
              "interpolate": {"signal": "interpolate"},
              "fillOpacity": {"value": 1}
            },
            "hover": {
              "fillOpacity": {"value": 0.5}
            }
          }
        }
      ]
    }
  ]
}
```
Interpretation of Hypothesis Output 解释假设的输出含义
$h_{\theta}(x)$ = estimates probability that y=1 on input x , 输入 x 时，y=1 的可能性。
> </br>举例:
> </br>$x=\begin{bmatrix}x_0\\x_1\end{bmatrix} = \begin{bmatrix}1\\tumorSize\end{bmatrix}$ , $h_\theta(x) = 0.7$ ，意味着病人的肿瘤有 70% 的概率是恶性的
> </br>

$h_\theta(x)=P(y=1|x;\theta)$ 给出 特征 $x$ , 参数 $\theta$ 时 $y=1$ 的概率
$P(y=0|x;\theta) + P(y=1|x;\theta)=1$ ,可以推导出 : $P(y=0|x;\theta) = 1 - P(y=1|x;\theta)$

## 决策边界
Logistic regression 逻辑回归 : $h_{\theta}(x) = g(\theta^Tx)$ ，其中 $g(z)=\dfrac{1}{1+e^{-z}}$
Suppose  :
* predict 预测 $y=1$ if $h_\theta(x) \geqslant 0.5$  换句话说  $\theta^Tx \geqslant 0$
* predict 预测 $y=0$ if $h_\theta(x) < 0.5$  换句话说  $\theta^Tx < 0$

### Decision Boundary 决策边界
$h_\theta(x)=g(\theta_0+\theta_1x_1+\theta_2x_2)$ , 假设 $\theta = \begin{bmatrix}-3\\1\\1\end{bmatrix}$
预测:  $y=1$ 则 $-3 + x_1 + x_2 \geqslant 0$ 变换算式 : $x_1 +x_2 \geqslant 3$
其中 $x_1 + x_2 = 3$ 是 **决策边界** 
> 换句话说 **决策边界** 是 $h_\theta(x)=0.5$ 的情况
> **决策边界** 是 **假设函数** 的属性，由参数决定 (非数据集的属性)

### No-linear decision boundaries 非线性决策边界
$h_\theta(x) = g(\theta_0+\theta_1x_1+\theta_2x_2+\theta_3x^2_1+\theta_4x^2_2)$ 假设 $\theta = \begin{bmatrix}-1\\0\\0\\1\\1\end{bmatrix}$
预测: $y=1$ 则 $-1 + x^2_1 + x^2_2 \geqslant 0$ 变换算式 : $x^2_1 +x^2_2 \geqslant 1$
> **决策边界** 为一个圆形

## 代价函数
训练集: $\{(x^{(1)},y^{(1)}),(x^{(2)},y^{(2)}),...,(x^{(m)},y^{(m)})\}$

> </br>m 个 样本 $x \in \begin{bmatrix}x_0\\x_1\\...\\x_n\end{bmatrix}$ 其中 $x_0= 1$ , $y \in \{0,1\}$
> </br>

$h_\theta(x)=\dfrac{1}{1+e^{-\theta^Tx}}$

**思考** : 如果给定了训练集，如何才能确定参数 $\theta$ ?

### Cost function 代价函数

线性回归 Linear regression : 

$J(\theta) = \dfrac{1}{m}\displaystyle\sum^m_{i=1} \dfrac{1}{2}(h_\theta(x^{(i)})-y^{(i)})^2 = \dfrac{1}{m}\displaystyle\sum^m_{i=1} Cost(h_\theta(x^{(i)},y^{(i)})$

**定义** : $Cost(h_\theta(x,y) = \dfrac{1}{2}(h_\theta(x)-y)^2$ 

**convex and non-convex**  凸函数 与 非凸函数
* 凸函数 : 平滑的弓形函数，可以收敛到全剧最小 (想要的函数)
* 非凸函数 : 抖动的函数(类似波浪状)，不能保证收敛到全局最小

逻辑回归 Logistic regression : 

**定义** : $Cost(h_\theta(x,y) = \begin{cases}\ \ \ \ \ \ \ -log(h_\theta(x))\ \ \ if\ y = 1\\ - log(1-h_\theta(x))\ \ \ if\ y=0 \end{cases}$

$log(z)$ 相关函数
``` vega
{
  "$schema": "https://vega.github.io/schema/vega/v4.json",
  "width": 500,
  "height": 200,
  "padding": 5,

  "signals": [
    {
      "name": "interpolate",
      "value": "basis",
      "bind": {
        "input": "select",
        "options": [
          "basis",
          "cardinal",
          "catmull-rom",
          "linear",
          "monotone",
          "natural",
          "step",
          "step-after",
          "step-before"
        ]
      }
    }
  ],

  "data": [
    {
      "name": "table",
      "values": [
        {"x":0.1000,"y":-2.3026,"c":0},
        {"x":0.2000,"y":-1.6094,"c":0},
        {"x":0.3000,"y":-1.2040,"c":0},
        {"x":0.4000,"y":-0.9163,"c":0},
        {"x":0.5000,"y":-0.6931,"c":0},
        {"x":0.6000,"y":-0.5108,"c":0},
        {"x":0.7000,"y":-0.3567,"c":0},
        {"x":0.8000,"y":-0.2231,"c":0},
        {"x":0.9000,"y":-0.1054,"c":0},
        {"x":1.0000,"y":0.0000,"c":0},
        {"x":1.1000,"y":0.0953,"c":0},
        {"x":1.2000,"y":0.1823,"c":0},
        {"x":1.3000,"y":0.2624,"c":0},
        {"x":1.4000,"y":0.3365,"c":0},
        {"x":0.1000,"y":2.3026,"c":1},
        {"x":0.2000,"y":1.6094,"c":1},
        {"x":0.3000,"y":1.2040,"c":1},
        {"x":0.4000,"y":0.9163,"c":1},
        {"x":0.5000,"y":0.6931,"c":1},
        {"x":0.6000,"y":0.5108,"c":1},
        {"x":0.7000,"y":0.3567,"c":1},
        {"x":0.8000,"y":0.2231,"c":1},
        {"x":0.9000,"y":0.1054,"c":1},
        {"x":1.0000,"y":-0.0000,"c":1},
        {"x":1.1000,"y":-0.0953,"c":1},
        {"x":1.2000,"y":-0.1823,"c":1},
        {"x":1.3000,"y":-0.2624,"c":1},
        {"x":1.4000,"y":-0.3365,"c":1},
        {"x":0.1000,"y":0.1054,"c":2},
        {"x":0.2000,"y":0.2231,"c":2},
        {"x":0.3000,"y":0.3567,"c":2},
        {"x":0.4000,"y":0.5108,"c":2},
        {"x":0.5000,"y":0.6931,"c":2},
        {"x":0.6000,"y":0.9163,"c":2},
        {"x":0.7000,"y":1.2040,"c":2},
        {"x":0.8000,"y":1.6094,"c":2},
        {"x":0.9000,"y":2.3026,"c":2},
        {"x":0.0000,"y":0.0,"c":3},
        {"x":1.0000,"y":0.0,"c":3}
      ]
    }
  ],

  "scales": [
    {
      "name": "x",
      "type": "linear",
      "range": "width",
      "domain": {"data": "table", "field": "x"}
    },
    {
      "name": "y",
      "type": "linear",
      "range": "height",
      "nice": true,
      "zero": true,
      "domain": {"data": "table", "field": "y"}
    },
    {
      "name": "color",
      "type": "ordinal",
      "range": "category",
      "domain": {"data": "table", "field": "c"}
    }
  ],

  "axes": [
    {"orient": "bottom", "scale": "x"},
    {"orient": "left", "scale": "y"}
  ],

  "marks": [
    {
      "type": "group",
      "from": {
        "facet": {
          "name": "series",
          "data": "table",
          "groupby": "c"
        }
      },
      "marks": [
        {
          "type": "line",
          "from": {"data": "series"},
          "encode": {
            "enter": {
              "x": {"scale": "x", "field": "x"},
              "y": {"scale": "y", "field": "y"},
              "stroke": {"scale": "color", "field": "c"},
              "strokeWidth": {"value": 2}
            },
            "update": {
              "interpolate": {"signal": "interpolate"},
              "fillOpacity": {"value": 1}
            },
            "hover": {
              "fillOpacity": {"value": 0.5}
            }
          }
        }
      ]
    }
  ]
}
```
> </br>图表说明: 
> * **蓝色**  $\ \ \ \ log(z)$  函数 
> * **橙色**  $\ -log(z)$  函数 
> * **红色**  $\ -log(1-z)$  函数 
> </br>

## 简化代价函数与梯度下降函数
逻辑回归代价函数:

$J(\theta) = \dfrac{1}{m}\displaystyle\sum^m_{i=1} Cost(h_\theta(x^{(i)},y^{(i)})$

$Cost(h_\theta(x,y) = \begin{cases}\ \ \ \ \ \ \ -log(h_\theta(x))\ \ \ if\ y = 1\\ - log(1-h_\theta(x))\ \ \ if\ y=0 \end{cases}$

**注意** : 只有 $y=0$ 或者 $y=1$ 两种取值

合并并简化代价方程 : $Cost(h_\theta(x,y) = -y\times log(h_\theta(x)) - (1-y)\times log(1-h_\theta(x))$

> 如果 $y=1$ : $Cost(h_\theta(x,y) = -log(h_\theta(x))$
> 如果 $y=0$ : $Cost(h_\theta(x,y) = - log(1-h_\theta(x))$

$J(\theta) = \dfrac{1}{m}\displaystyle\sum^m_{i=1} Cost(h_\theta(x^{(i)},y^{(i)}) \\ \ \ \ \ \ \ \ \ \  = -\dfrac{1}{m}[\ \displaystyle\sum^m_{i=1} y^{(i)} \times log(h_\theta(x^{(i)})) + (1-y^{(i)})\times log(1-h_\theta(x^{(i)}))\ ]$

> 统计学 **极大似然函数** 得到的，而且这个函数是凸函数

如果要得到最佳参数 $\theta$ , 则需要求 $\underset{\theta}{min}\ J(\theta)$ 

一般求解 **最小** $J(\theta)$ 的方法：

**梯度下降** $J(\theta) =-\dfrac{1}{m}[\ \displaystyle\sum^m_{i=1} y^{(i)} \times log(h_\theta(x^{(i)})) + (1-y^{(i)})\times log(1-h_\theta(x^{(i)}))\ ]$

Repeat {
  $\ \ \ \ \theta_j :=\theta_j-\alpha \times \dfrac{\partial}{\partial \theta_j}J(\theta) =\theta_j-\alpha \times \displaystyle\sum^m_{i=1} (h_\theta(x^{(i)})-y^{(i)})x_j^{(i)}$
  } 同时更新所有 $\ \theta_j$

> </br>公式与之前线性回归一致，但是假设函数不同:
> * 线性回归 : $h_\theta(x) = \theta^tx$
> * 逻辑回归 : $h_\theta(x) = \dfrac{1}{1+e^{-\theta^tx}}$
> 
> **特征缩放** 一样适用于逻辑回归，可以使训练过程加速
> </br>

## 进一步优化

**优化算法** : 给出代价函数 $J(\theta)$ , 求解 $\underset{\theta}{min}\ J(\theta)$ , 我们需要编程计算 : 
$J(\theta)$   和   $\dfrac{\partial}{\partial\theta_j}J(\theta)$   ( for $j=0,1,...,n$ )

之后使用 **梯度下降** 算法:

Repeat {
  $\ \ \ \ \theta_j :=\theta_j-\alpha \times \dfrac{\partial}{\partial \theta_j}J(\theta)$
}

优化算法：
- Gradient descent 梯度下降
- Conjugate gradient 共轭梯度法
- BFGS 
- L-BFGS

|                               优势                                |   劣势   |
| :---------------------------------------------------------------: | :------: |
| 1. 不需要人工选择学习速率 $\alpha$<br>2. 通常情况下比梯度下降更快 | 非常复杂 |


**举例**:
$\theta = \begin{bmatrix}\theta_1\\\theta_2\end{bmatrix}$

$J(\theta) = (\theta_1-5)^2+(\theta_2-5)^2$

$\dfrac{\partial}{\partial\theta_1}J(\theta) = 2*(\theta_1-5)$

$\dfrac{\partial}{\partial\theta_2}J(\theta) = 2*(\theta_2-5)$

> 编程计算练习

## 多元分类 : 一对多
举例: 
* E-mail 分类: 工作(1)，朋友(2)，家庭(3)，爱好(4)
* 药物作用: 非病毒(1)，流感(2)，感冒(3)
* 天气: 晴天(1)，多云(2)，下雨(3)，下雪(4)
...

合成 **伪训练集** 将 **正类** 外全部假设为 **负类**

例如三分类问题:  $h_\theta^{(i)}=P(y=i|x;\theta) \ \ \ \ \ (i = 1,2,3)$

每个类别有一个单独的假设函数，且有对应的 **伪训练集**

最终得到的结果是  $\underset{i}{max}\ h_\theta^{(i)}(x)$ 预测值最大的类别便是预测结果
