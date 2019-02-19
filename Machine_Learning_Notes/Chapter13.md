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
$f_i = \text{similarity}(x,l^{(i)}) = \exp(-\dfrac{{\lVert x - l^{(i)} \rVert}^2}{2\sigma^2}) = \exp(-\dfrac{\sum^n_{j=1}(x_j -l^{(i)}_j )^2}{2\sigma^2})$

* 如果 $x \approx l^{(i)}$: 欧氏距离非常相近，分子项约为 0 ，因此 
  $f_i \approx \exp(- \dfrac{0^2}{2\sigma^2})\approx1$
* 如果 $x$ 与 $l^{(i)}$ 的距离很远: 分子项为很大的数，因此 
  $f_i = \exp(-\dfrac{(\text(large \ number)^2)}{2\sigma^2}) \approx 0$

![Kernel_func](/assets/Kernel_func.png)

> $\sigma^2$ 为范围调整参数
> * $\sigma^2$ 越小，区域越小，参数变化的趋势越快
> * $\sigma^2$ 越大，区域越大，参数变化的趋势越慢

利用标记点与核函数可以辅助找到高纬度非线性假设

### 选择标记点

将 **训练样本** 作为 **标记点**
训练集: $(x^{(1)},y^{(1)}),(x^{(2)},y^{(2)}),...,(x^{(m)},y^{(m)})$
标记点: $l^{(1)}=x^{(1)},l^{(2)}=x^{(2)},...,l^{(m)}=x^{(m)}$
得到一个样本 $x$ :$f_1 = \text{similarity}(x,l^{(1)})$ , $f_2 = \text{similarity}(x,l^{(2)})$ ... $f_m = \text{similarity}(x,l^{(m)})$ 
向量形式为: $f = \begin{bmatrix}f_0\\f_1\\f_2\\ \vdots\\f_m\end{bmatrix}$ , 其中 $f_0=1$

### SVM 使用 核函数

假设：给一个 $x$ ，计算特征 $f \in \R^{m+1}$ ($m$个训练数据，还要加上一个 $f_0$)
$\begin{cases} y=1 &\text{if} \ \theta^Tf \geq 0 \\y=0 &\text{if} \ \theta^Tf \leq 0 \end{cases}$

训练:  $\underset{\theta}{min} \ C \sum^m_{i=1} y^{(i)} cost_1(\theta^Tf^{(i)})+(1-y^{(i)})cost_0(\theta^Tf^{(i)}) \ + \ \dfrac{1}{2}\sum^n_{j=1} \theta^2_j$  (如果训练数据与标记点是相同的，则 $n=m$)

### SVM 参数

正则化参数 : $C=\dfrac{1}{\lambda}$ 
* $C$ **较大**时: 低偏差，高方差 ($\lambda$ 较小) 过拟合
* $C$ **较小**时: 高偏差，低方差 ($\lambda$ 较大) 欠拟合

$\sigma^2$ 为 高斯核 $f_i = \exp(-\dfrac{{\lVert x - l^{(i)} \rVert}^2}{2\sigma^2})$ 的参数
* $\sigma^2$ 较**大**: 特征 $f_i$ 变化越平滑，训练结果为: **高偏差**，**低方差**
* $\sigma^2$ 较**小**: 特征 $f_i$ 变化越剧烈，训练结果为: **低偏差**，**高方差**

## 使用 SVM
利用当今研究者封装好的库来使用 SVM 解出最优参数 $\theta$
需要注意的是:
* 选择合适的 正则化参数 $C$
* 选择合适的 核函数(Kernel - similarity function) :
  * 无核函数 (线性核函数 Linear Kernel) 预测 $y=1 \ \text{if} \ \theta^Tx \geq 0$
  * 高斯核 (Gaussian kernel) $f_i = \exp(-\dfrac{{\lVert x - l^{(i)} \rVert}^2}{2\sigma^2})$ 其中 $l^{(i)}=x^{(i)}$, 需要选择参数 $\sigma^2$
    > 适用于 小特征 $n$, 大数据量 $m$
    > 建议在特征尺度不一致的情况下 使用 **特征归一化** 后再使用高斯核
  > 选择的核函数需要满足 **"Mercer's Theorem"** 理论，来确保 SVM 优化过程正确
  * 其他核函数 (**不建议使用**) :
    * 多项式核函数(Polynomial kernel) :  $k(x,l) = (x^Tl+canstant)^{degree}$, 其中 $canstant,degree$ 为自由数字
    * 字符串核函数(String kernel)
    * chi-square kernel
    * histogram intersection kernel
    * ...

### 逻辑回归 对比 支持向量机
假设: $n$ 为特征数量， $m$ 为训练样本数量
* 如果 $n$ 相对于 $m$ 很大 ($n \geq m$ , $n=10,000$ , $m=10,...,1000$)
  建议使用: 逻辑回归 或者 使用线性核函数的支持向量机 (无核函数的 SVM)
* 如果 $n$ 很小 , $m$ 比较居中: ($n=1,...,1000$ , $m=10,...,10,000$)
  建议使用: 使用高斯核函数的支持向量机
* 如果 $n$ 很小 , $m$ 很大 : ($n=1,...,1000$ , $m=50,000^+$) 
  建议使用: 增加或者创造更多的 **特征** 后，使用 **逻辑回归** 或者 **使用线性核函数的支持向量机** (无核函数的 SVM)