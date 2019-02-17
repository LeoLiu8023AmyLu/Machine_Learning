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

* 如果 $y=1$ 我们希望 $\theta^Tx \geqslant 1$ 不仅是 $\geqslant 0$
* 如果 $y=0$ 我们希望 $\theta^Tx \leqslant -1$ 不仅是 $< 0$

> 支持向量机的安全间隔机制

### 支持向量机边界