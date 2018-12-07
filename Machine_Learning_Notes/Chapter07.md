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
      "type": "point",
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