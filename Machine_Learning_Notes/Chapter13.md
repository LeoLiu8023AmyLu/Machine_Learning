# 支持向量机 SVM

## 优化目标
逻辑回归 中 激活函数 $h_\theta(x) = \dfrac{1}{1+e^{-\theta^Tx}}$

Sigmoid 函数 其中 $z=\theta^Tx$:
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
    {"orient": "bottom", "scale": "x","title": "z"},
    {"orient": "left", "scale": "y","title": "Cost"}
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

* 如果 $y=1$ 我们希望 $h_\theta(x) \approx 1$ , 则 $\theta^Tx \gg 0$
* 如果 $y=0$ 我们希望 $h_\theta(x) \approx 0$ , 则 $\theta^Tx \ll 0$

损失函数 $-\Bigl(y \times \log(h_\theta(x))+(1-y) \times \log(1-h_\theta(x))\Bigr)$

带入 $h_\theta(x) = \dfrac{1}{1+e^{-\theta^Tx}}$

损失函数为 $-\Biggl(y \times \log\Bigl(\dfrac{1}{1+e^{-\theta^Tx}}\Bigr)+(1-y) \times \log\Bigl(1-\dfrac{1}{1+e^{-\theta^Tx}}\Bigr)\Biggr)$

* 如果 $y=1$ 我们希望 $h_\theta(x) \approx 1$ , 则 $\theta^Tx \gg 0$
    **损失函数为**: $-\log\Bigl(\dfrac{1}{1+e^{-\theta^Tx}}\Bigr)$

    ``` vega
    {
    "$schema": "https://vega.github.io/schema/vega/v4.json",
    "width": 500,
    "height": 250,
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
            {"x":-3.000000,"y":3.048587,"c":0},{"x":-3.000000,"y":2.400000,"c":1},
            {"x":-2.500000,"y":2.578890,"c":0},{"x":-2.500000,"y":2.100000,"c":1},
            {"x":-2.000000,"y":2.126928,"c":0},{"x":-2.000000,"y":1.800000,"c":1},
            {"x":-1.500000,"y":1.701413,"c":0},{"x":-1.500000,"y":1.500000,"c":1},
            {"x":-1.000000,"y":1.313262,"c":0},{"x":-1.000000,"y":1.200000,"c":1},
            {"x":-0.500000,"y":0.974077,"c":0},{"x":-0.500000,"y":0.900000,"c":1},
            {"x":0.000000,"y":0.693147,"c":0},{"x":0.000000,"y":0.600000,"c":1},
            {"x":0.500000,"y":0.474077,"c":0},{"x":0.500000,"y":0.300000,"c":1},
            {"x":1.000000,"y":0.313262,"c":0},{"x":1.000000,"y":0.000000,"c":1},
            {"x":1.500000,"y":0.201413,"c":0},{"x":1.500000,"y":0.000000,"c":1},
            {"x":2.000000,"y":0.126928,"c":0},{"x":2.000000,"y":0.000000,"c":1},
            {"x":2.500000,"y":0.078890,"c":0},{"x":2.500000,"y":0.000000,"c":1},
            {"x":3.000000,"y":0.048587,"c":0},{"x":3.000000,"y":0.000000,"c":1}
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
        {"orient": "bottom", "scale": "x","title": "z"},
        {"orient": "left", "scale": "y","title": "Cost"}
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
    > 其中 $z=\theta^Tx$
    > <font color=RoyalBlue font-weight=bold >蓝色</font> 为损失函数，<font color=RoyalBlue font-weight=bold >橙色</font> 为假设的 $Cost_1(z)$ 函数
* 如果 $y=0$ 我们希望 $h_\theta(x) \approx 0$ , 则 $\theta^Tx \ll 0$
    **损失函数为**: $-\log\Bigl(1-\dfrac{1}{1+e^{-\theta^Tx}}\Bigr)$
    ``` vega
    {
    "$schema": "https://vega.github.io/schema/vega/v4.json",
    "width": 500,
    "height": 250,
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
            {"x":-3.000000,"y":0.048587,"c":0},{"x":-3.000000,"y":0.000000,"c":1},
            {"x":-2.500000,"y":0.078890,"c":0},{"x":-2.500000,"y":0.000000,"c":1},
            {"x":-2.000000,"y":0.126928,"c":0},{"x":-2.000000,"y":0.000000,"c":1},
            {"x":-1.500000,"y":0.201413,"c":0},{"x":-1.500000,"y":0.000000,"c":1},
            {"x":-1.000000,"y":0.313262,"c":0},{"x":-1.000000,"y":0.000000,"c":1},
            {"x":-0.500000,"y":0.474077,"c":0},{"x":-0.500000,"y":0.300000,"c":1},
            {"x":0.000000,"y":0.693147,"c":0},{"x":0.000000,"y":0.600000,"c":1},
            {"x":0.500000,"y":0.974077,"c":0},{"x":0.500000,"y":0.900000,"c":1},
            {"x":1.000000,"y":1.313262,"c":0},{"x":1.000000,"y":1.200000,"c":1},
            {"x":1.500000,"y":1.701413,"c":0},{"x":1.500000,"y":1.500000,"c":1},
            {"x":2.000000,"y":2.126928,"c":0},{"x":2.000000,"y":1.800000,"c":1},
            {"x":2.500000,"y":2.578890,"c":0},{"x":2.500000,"y":2.100000,"c":1},
            {"x":3.000000,"y":3.048587,"c":0},{"x":3.000000,"y":2.400000,"c":1}
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
        {"orient": "bottom", "scale": "x","title": "z"},
        {"orient": "left", "scale": "y","title": "Cost"}
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
    > 其中 $z=\theta^Tx$
    > <font color=RoyalBlue font-weight=bold >蓝色</font> 为损失函数，<font color=RoyalBlue font-weight=bold >橙色</font> 为假设的 $Cost_0(z)$ 函数

### 支持向量机 Support vector machine

* Logistic regression 逻辑回归:
  $\underset{\theta}{min} J(\theta) = \underset{\theta}{min} \ \dfrac{1}{m}\Bigl[ \sum^m_{i=1} y^{(i)} \times (-\log(h_\theta(x^{(i)}))) + (1-y^{(i)}) \times (-\log(1-h_\theta(x^{(i)})))\Bigr] + \dfrac{\lambda}{2m}\sum^n_{j=1}\theta^2_j$

* Support vector machine 支持向量机:
  $\underset{\theta}{min} J(\theta) = \underset{\theta}{min} \ C \sum^m_{i=1} \Bigl[ y^{(i)} \times (Cost_1(\theta^Tx^{(i)})) + (1-y^{(i)}) \times (Cost_0(\theta^Tx^{(i)}))\Bigr] + \dfrac{1}{2}\sum^n_{j=1}\theta^2_j$

> **提示:**
> 1. 逻辑回归是 $A+\lambda B$ 形式，支持向量机是 $CA+B$ 形式
> 2. 支持向量机中的 $C$ 相当于 $\dfrac{1}{\lambda}$,关系为$C=\dfrac{1}{\lambda}$

## 直观理解 大间隔

### 支持向量机回顾
对于支持向量机 $\underset{\theta}{min} \ C \sum^m_{i=1} \Bigl[ y^{(i)} \times (Cost_1(\theta^Tx^{(i)})) + (1-y^{(i)}) \times (Cost_0(\theta^Tx^{(i)}))\Bigr] + \dfrac{1}{2}\sum^n_{j=1}\theta^2_j$

* 如果 $y=1$ 我们希望 $\theta^Tx \geqslant 1$ ( 不仅是 $\geqslant 0$ )
* 如果 $y=0$ 我们希望 $\theta^Tx \leqslant -1$ ( 不仅是 $< 0$ )

> 支持向量机的安全间隔机制

### 支持向量机边界

支持向量机 也称之为 大间距分类器
> 因为算法在分类的时候 会采用最大 间距(margin) 的方案，所以将正负样本最大间距分开

* 假设 $C$ 非常大，那么需要将 $\Bigl[ y^{(i)} \times (Cost_1(\theta^Tx^{(i)})) + (1-y^{(i)}) \times (Cost_0(\theta^Tx^{(i)}))\Bigr]$ 逼近于零
此时，异常点对分类产生很大影响
* 假设 $C$ 没有很大，那么结果分类鲁棒性会较好，但是准确度会有所下降

> $C$ 较大时 容易理解大间距的概念

## 大间隔分类的数据原理

### 向量间的内积

假设 $u=\begin{bmatrix}u_1\\u_2\end{bmatrix}$ , $v=\begin{bmatrix}v_1\\v_2\end{bmatrix}$, 则 $u^Tv=u_1v_1+u_2v_2$
* $\lVert u \rVert = \sqrt{\smash[b]{u_1^2+u_2^2}} \in \R$ , 表示 $u$ 向量的长度 (范数)
* $\lVert v \rVert = \sqrt{\smash[b]{v_1^2+v_2^2}} \in \R$ , 表示 $v$ 向量的长度 (范数)
* $u^Tv= p \times \lVert u \rVert = u_1v_1+u_2v_2 = v^Tu$ 其中 $p$ 是 $v$ 在 $u$ 上的投影的长度
  > $v$ 与 $u$ 的角度小于 $90^\circ$ 时为 **正**，大于$90^\circ$ 时为 **负**


### SVM 决策边界

假设只有两个参数 : $\theta_1,\theta_2$ ，忽略 $\theta_0$ 定义 $\theta_0=0$
$\begin{cases} \theta^Tx^{(i)}\geq 1 &\text{if} \ y^{(i)}=1 \\ \theta^Tx^{(i)} \leq -1 &\text{if} \ y^{(i)}=0 \end{cases}$ 或者用内积的表示方式: $\begin{cases} p^{(i)} \lVert \theta \rVert \geq 1 &\text{if} \ y^{(i)}=1 \\p^{(i)} \lVert \theta \rVert \leq -1  &\text{if} \ y^{(i)}=0 \end{cases}$

$\underset{\theta}{min} \dfrac{1}{2} \sum^n_{j=1} \theta^2_j = \dfrac{1}{2}(\theta^2_1+\theta^2_2) = \dfrac{1}{2}(\sqrt{\smash[b]{\theta_1^2+\theta_2^2}})^2 = \dfrac{1}{2}(\lVert \theta \rVert)^2$

> 我们希望 $\lVert \theta \rVert$ 越小越好，换句话说 $p^{(i)}$ 越大越好
> 因为 $p^{(i)}$ 变大后，就会在样本空间形成一个间距(margin)
> $\theta_0 = 0$时，所有分割线经过 **原点**

## 核函数

### 核函数与相似函数
$f_1 = \text{similarity}(x,l^{1}) = \exp(-\dfrac{{\lVert x - l^{(1)} \rVert}^2}{2\sigma^2}) = \exp(-\dfrac{\sum^n_{j=1}(x_j -l^{(1)}_j )^2}{2\sigma^2})$
* 如果 $x \approx l^{(1)}$: 欧氏距离非常相近，分子项约为 0 ，因此 
  $f_1 \approx \exp(- \dfrac{0^2}{2\sigma^2})\approx1$
* 如果 $x$ 与 $l^{(1)}$ 的距离很远: 分子项为很大的数，因此 
  $f_1 = \exp(-\dfrac{(\text(large \ number)^2)}{2\sigma^2}) \approx 0$

![Kernel_func](/assets/Kernel_func.png)

> $\sigma^2$ 为范围调整参数
> * $\sigma^2$ 越小，区域越小，参数变化的趋势越快
> * $\sigma^2$ 越大，区域越大，参数变化的趋势越慢