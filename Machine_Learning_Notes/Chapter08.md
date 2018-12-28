# 正则化
## 过拟合问题
### 拟合中出现的问题
举例：房屋价格 线性回归
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
        {"x":1,"y":15,"c":0},{"x":1,"y":15,"c":1},
        {"x":2,"y":90,"c":0},{"x":2,"y":34,"c":1},
        {"x":3,"y":100,"c":0},{"x":3,"y":57,"c":1},
        {"x":4,"y":110,"c":0},{"x":4,"y":80,"c":1},
        {"x":5,"y":115,"c":0},{"x":5,"y":103,"c":1},
        {"x":6,"y":117,"c":0},{"x":6,"y":120,"c":1},
        {"x":0.5,"y":35,"c":2},
        {"x":1,"y":15,"c":2},
        {"x":1.5,"y":5,"c":2},
        {"x":2,"y":90,"c":2},
        {"x":2.5,"y":148,"c":2},
        {"x":3,"y":100,"c":2},
        {"x":3.5,"y":80,"c":2},
        {"x":4,"y":110,"c":2},
        {"x":4.5,"y":150,"c":2},
        {"x":5,"y":115,"c":2},
        {"x":6,"y":117,"c":2},
        {"x":6.5,"y":60,"c":2}
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
* 橙色 **欠拟合**  : $\theta_0 + \theta_1x$  ( 高偏差 high bias )
* 蓝色 **正合适**  : $\theta_0 + \theta_1x+\theta_2x^2$
* 红色 **过拟合**  : $\theta_0 + \theta_1x+\theta_2x^2+\theta_3x^3++\theta_4x^4$  ( 高方差 high variance )

> 随着 **特征** 的增加，越容易出现 **过拟合** 

### 解决过拟合
例如目前有很多特征，目前解决的方法:
1. Reduce number of features. 减少特征数量:
   * 人工选取重要的特征；
   * 模型选择算法；
2. Regularization. 正则化:
   * 保留所有特征，但是为每个参数 $\theta_j$ 增加权重；
   * 在存在大量特征的任务中表现不错，每一个特征都可以对预测 $y$ 有所帮助；

## 代价函数

观察上一章房屋价格预测曲线图：
* 蓝色 **正合适**  : $\theta_0 + \theta_1x+\theta_2x^2$
* 红色 **过拟合**  : $\theta_0 + \theta_1x+\theta_2x^2+\theta_3x^3+\theta_4x^4$ 

如果想解决过拟合(过多的抖动)，需要 **惩罚** 参数 $\theta_3,\theta_4$ (控制高阶的系数), 让他们足够 **小**。 

那么代价函数将改写为: $\underset{\theta}{min} \ \ \dfrac{1}{2m} \sum^m_{i=1}(h_\theta(x^{(i)})-y^{(i)})^2 \color{blue}{+1000\times \theta_3^2+1000\times \theta_4^2}$
> 由于 $\theta_3,\theta_4$ 前面加了很大的系数，所以为了最小化代价函数，$\theta_3,\theta_4$ 只能接近于 $0$
> 多项式  $\theta_0 + \theta_1x+\theta_2x^2+\theta_3x^3+\theta_4x^4$  将会接近  $\theta_0 + \theta_1x+\theta_2x^2$
> 这样会得到一个更好的假设，从而可以更好的拟合

### 正则化
将参数 $\theta_0,\theta_1,...,\theta_n$ 尽可能的缩小
* 可以得到更为简化的假设
* 减少过拟合 

改写代价函数的方程:  $\underset{\theta}{min} \ \ J(\theta) = \dfrac{1}{2m}\Bigl[ \sum^m_{i=1}(h_\theta(x^{(i)})-y^{(i)})^2 + \lambda \sum^n_{j=1}\theta^2_j \Bigr]$
* 第一项 $\sum^m_{i=1}(h_\theta(x^{(i)})-y^{(i)})^2$ 是为了让假设方程更加 **拟合数据**
* 第二项 $\sum^n_{j=1}\theta^2_j$ 是为了让参数尽可能的 **小**
* $\lambda$ 是调节两个部分的平衡参数 (regularization parameter 正则化参数)

> 如果 $\lambda$ 设置过大，则将会忽略所有参数 $\theta_j,j=1,2,...,n$ , 假设将变为 **欠拟合** 状态

## 线性回归的正则化
代价方程:$\underset{\theta}{min} \ \ J(\theta) = \dfrac{1}{2m}\Bigl[ \sum^m_{i=1}(h_\theta(x^{(i)})-y^{(i)})^2 + \lambda \sum^n_{j=1}\theta^2_j \Bigr]$

### 梯度下降:
Repeat{
* $\theta_0 := \theta_0 - \alpha \dfrac{1}{m} \ \sum^m_{i=1} (h_\theta(x^{(i)})-y^{(i)})x_0^{(i)}$
* $\theta_j := \theta_j - \alpha \Bigl[ \dfrac{1}{m} \ \sum^m_{i=1} (h_\theta(x^{(i)})-y^{(i)})x_j^{(i)} + \dfrac{\lambda}{m}\theta_j \Bigr]$   ($j=1,2,3,...,n$)
  简化方程: $\theta_j := \theta_j(1-\alpha \dfrac{\lambda}{m}) - \alpha \dfrac{1}{m} \ \sum^m_{i=1} (h_\theta(x^{(i)})-y^{(i)})x_j^{(i)}$
}
> 其中 $\theta_0$ 是需要区别对待的
> 其中 $1-\alpha\dfrac{\lambda}{m} < 1$

### 正规方程
$X=\begin{bmatrix}(x^{(1)})^T\\.\\.\\.\\(x^{(m)})^T\end{bmatrix}$ , $y=\begin{bmatrix}y^{(1)}\\.\\.\\.\\y^{(m)}\end{bmatrix}$

