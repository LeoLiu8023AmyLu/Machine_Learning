# 多变量逻辑回归
## 引言 
### Multiple features(variables) 多特征
| Size($feet^2$) | Number of bedrooms | Number of floors | Age of home(years) | Price($1000) |
| :------------: | :----------------: | :--------------: | :----------------: | :----------: |
| $x_1$          | $x_2$              | $x_3$            | $x_4$              | $y$          |
> </br>**Notation**:
> $n$ = number of features 特征数
> $x^{(i)}$ = input (features) of $i^{th}$ training example. 第$i^{th}$个训练样本 (引索)
> $x_j^{(i)}$ = value of features $j$ in $i^{th}$ training example.第$i^{th}$个训练样本中的第$j$个特征
> </br>

### 假设形式
$h_\theta(x)=\theta_0+\theta_1 x_1+\theta_2 x_2+\theta_3 x_3+ ... + \theta_n x_n$
For convenience of notation,define $x_0=1$ ，方便运算 将 $x_0 = 1$ 
> </br>特别注意 : $x_0^{(i)}=1$
>
> $x=\begin{bmatrix}x_0\\x_1\\x_2\\.\\.\\.\\x_n\end{bmatrix} \in \Re^{n+1} \ \ \ \ \ \theta = \begin{bmatrix}\theta_0\\\theta_1\\\theta_2\\.\\.\\.\\\theta_n\end{bmatrix} \in \Re^{n+1}$
> </br>
 
则 $h_{\theta}(x) = \theta_0 x_0 +\theta_1 x_1+\theta_2 x_2+\theta_3 x_3+ ... + \theta_n x_n$ 其中 $x_0 =1$ 
> </br>$h_{\theta}(x) = \theta^T x = \begin{bmatrix}\theta_0\\\theta_1\\\theta_2\\.\\.\\.\\\theta_n\end{bmatrix}^T \times \begin{bmatrix}x_0\\x_1\\x_2\\.\\.\\.\\x_n\end{bmatrix}$
> </br>

## 多元梯度下降法
Hypothesis 假设 : $h_{\theta}(x) = \theta^T x = \theta_0+\theta_1 x_1+\theta_2 x_2+\theta_3 x_3+ ... + \theta_n x_n$ 其中 $x_0 = 1$
Parameters 参数 : $\theta_0,\theta_1,...,\theta_n = \theta$
Cost function : $J(\theta_0,\theta_1,...,\theta_n) = J(\theta) = \dfrac{1}{2m} \sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)})^2$

Gradient descent :
Repeat {
    $\ \ \ \ \theta_j := \theta_j - \alpha \dfrac{\partial}{\partial\theta_j}J(\theta)$ 
} (simultaneously update for every $j =0,...,n$)
> **需要同时更新** $j =0,...,n$

* Previously(n=1) 单变量线性回归:
Repeat {
    $\ \ \ \ \theta_0 := \theta_0 - \alpha \dfrac{\partial}{\partial\theta_j}J(\theta) = \theta_0 - \alpha \dfrac{1}{m} \sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)})$ 
    $\ \ \ \ \theta_1 := \theta_1 - \alpha \dfrac{1}{m} \sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)}) \textcolor{red}{x^{(i)}}$ 
} (simultaneously update $\theta_0 ,\theta_1$)
</br>

* New algorithm 多元线性回归:
Repeat {
    $\ \ \ \ \theta_j := \theta_j - \alpha \dfrac{\partial}{\partial\theta_j}J(\theta) = \theta_j - \alpha \dfrac{1}{m}\sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)}) \textcolor{red}{x_j^{(i)}}$ 
} (simultaneously update $\theta_j$ for $j =0,...,n$)
$\textcolor{red}{\theta_0}:=\textcolor{red}{\theta_0}-\alpha\dfrac{1}{m}\sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)}) \textcolor{red}{x_0^{(i)}} \ \ \textcolor{blue}{x_0^{(i)}=0}$
$\textcolor{red}{\theta_1}:=\textcolor{red}{\theta_1}-\alpha\dfrac{1}{m}\sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)}) \textcolor{red}{x_1^{(i)}}$
$\textcolor{red}{\theta_2}:=\textcolor{red}{\theta_2}-\alpha\dfrac{1}{m}\sum^m_{i=1}(h_{\theta}(x^{(i)})-y^{(i)}) \textcolor{red}{x_2^{(i)}}$
...

## 多元梯度下降法处理技巧-特征缩放
1. Feature Scaling 特征缩放 
    * Idea: Make sure feature are on a similar scale. 确保每个特征的取值范围接近
    > </br>**举例**: 
    > * $x_1$ = size ( 0 ~ 2000 $feet^2$ ); $x_2$ = number of bedrooms ( 1 ~ 5 )
    这样损失函数会非常的狭长，收敛速度会非常慢
    > * 应用特城缩放 $x_1 = \dfrac{size(feet^2)}{2000}$ , $x_2 = \dfrac{number of bedrooms}{5}$
    这样损失函数是个圆，梯度下降会更加快，收敛速度也会很快
    </br>

    * Get every feature into approximately a $-1 \leqslant x_i \leqslant 1$ range. 
    将每个特征的取值转化到与 $-1 \leqslant x_i \leqslant 1$ 相近的范围。
    > </br>**举例**:
    > * 可接受：$0 \leqslant x_1 \leqslant 3$ , $-1 \leqslant x_2 \leqslant 0.5$
    > * 不可接受: $-100 \leqslant x_3 \leqslant 100$ , $-0.0001 \leqslant x_4 \leqslant 0.0001$
    > 吴恩达个人经验认为 $-3 \leqslant x \leqslant 3$ and $-\dfrac{1}{3} \leqslant x \leqslant \dfrac{1}{3}$ 是合适的 
    > (足够接近梯度下降法就可以很好的工作)
    > </br>

2. Mean normalization 均值标准化
    * Replace $x_i$ with $x_i-\mu_i$ to make features have approximately zero mean (Do not apply to $x_0 = 1$).
    使用 $x_i-\mu_i$ 取代 $x_i$ 使训练集均值约为 **0**。
    (此方法不适用于 $x_0 = 1$ )
    > </br>**举例**：
    > *  $x_1 = \dfrac{size - 1000}{2000}$ , $x_2 = \dfrac{\#bedrooms-2}{5}$
    得到的均值归一化范围为 : $-0.5 \leqslant x_1 \leqslant 0.5 \ , \ -0.5 \leqslant x_2 \leqslant 0.5$
    > </br>

3. 综上 
    $x = \dfrac{x-\mu}{s_1}$ 此方法是一种接近取值的方法，目的是让**梯度下降法可以更高效的运行**
    > * $\mu$ 是 x 训练集的平均数 (avg value of x in training set)
    > * $s_1$ 取值范围 (range : $max-min$ ) 或者 标准差 ( standard deviation )

## 多元梯度下降法处理技巧-学习率
$\ \ \ \ \theta_j := \theta_j - \alpha\dfrac{\partial}{\partial\theta_j}J(\theta)$
- "Debugging" : How to make sure grandient descent is working correctly.
    > “调试” 如何确保梯度下降法正确运行
- How to choose learning rate $\alpha$.
    > 如何选择合适的学习率 $\alpha$

1. 确保梯度下降运算正确
    * 观察迭代次数增加的同时 $\underset{\theta}{min}J(\theta)$是否呈下降趋势。
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
                    {"x": 0, "y": 180, "c":0}, {"x": 0, "y": 200, "c":1},
                    {"x": 100, "y": 75, "c":0}, {"x": 100, "y": 120, "c":1},
                    {"x": 200, "y": 40, "c":0}, {"x": 200, "y": 50, "c":1},
                    {"x": 300, "y": 30, "c":0}, {"x": 300, "y": 20, "c":1},
                    {"x": 400, "y": 15, "c":0}, {"x": 400, "y": 16, "c":1},
                    {"x": 500, "y": 10, "c":0}, {"x": 500, "y": 10, "c":1}
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
        > </br>纵轴 ：$\underset{\theta}{min}J(\theta)$ 
        > 横轴 : No. of iterations 迭代次数
        > 在很多迭代次数后 $\underset{\theta}{min}J(\theta)$ 不再变化，表示进入局部最优解，收敛状态
        > </br>
    
    * Convergence test 收敛测试
        > </br>Declare convergence if $J(\theta)$ decreases by less than $10^{-3}$ in one iteration.
        > 如果在下一次迭代中 $J(\theta)$ 下降 $\epsilon$ 少于 $10^{-3}$ 则认为收敛。
        </br>

2. 如何选择合适的学习率
    
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
                {"x": 0, "y": 20, "c":0},{"x": 0, "y": 15, "c":1},
                {"x": 50, "y": 150, "c":0},{"x": 50, "y": 30, "c":1},
                {"x": 100, "y": 10, "c":0},{"x": 100, "y": 50, "c":1},
                {"x": 150, "y": 160, "c":0},{"x": 150, "y": 90, "c":1},
                {"x": 200, "y": 30, "c":0},{"x": 200, "y": 120, "c":1},
                {"x": 250, "y": 145, "c":0}, {"x": 250, "y": 150, "c":1},
                {"x": 300, "y": 18, "c":0},{"x": 300, "y": 180, "c":1},
                {"x": 350, "y": 170, "c":0}, {"x": 350, "y": 190, "c":1},
                {"x": 400, "y": 40, "c":0},{"x": 400, "y": 200, "c":1}
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
    * 如果 $\underset{\theta}{min}J(\theta)$ 随着迭代次数不断 **上升** (橘黄色线)，则说明需要减小学习率 $\textcolor{red}{\alpha}$
    
    * 如果 $\underset{\theta}{min}J(\theta)$ 随着迭代次数不断 **上升下降反复抖动** (蓝色线) ，则说明需要减小学习率 $\textcolor{red}{\alpha}$
    
    * 如果学习率 $\alpha$ 过小，训练收敛速度会很慢

### 总结
- If $\alpha$ is too small : slow convergence.
    > 如果学习率 $\alpha$ 太小，收敛会很慢。
- If $\alpha$ is too larget : $J(\theta)$ may not decrease on every iteration; may not converge.
    > 如果学习率 $\alpha$ 太大，$J(\theta)$ 在每次迭代不会下降，甚至不会收敛。
    > (也有可能出现收敛缓慢的问题)
- $\alpha$ 可以尝试 $...,0.001,0.01,0.1,1,...$ (一般 **10** 倍增长,可采用二分法逐步找到合适的学习率$\alpha$)
  
## 特征 与 多项式回归
1. 特征选取
    举例: Housing prices prediction
    $h_\theta(x)=\theta_0 + \theta_1 \times frontage + \theta_2 \times depth$
    定义新的特征 $area = frontage \times depth$ 则假设变为：
    $h_\theta(x)=\theta_0 + \theta_1 \times area$
    > 选取可是的特征可以更好的训练模型

2. 多项式回归 Polynomial regression
    为了更好的拟合(曲线)
    $h_\theta(x)=\theta_0 + \theta_1 x_1 + \theta_2 x_2 + \theta_3 x_3$
    定义：
    * $x_1 = (size) $
    * $x_2 = (size)^2 $
    * $x_3 = (size)^3 $
    则：
    $h_\theta(x)=\theta_0 + \theta_1 x_1 + \theta_2 x_2 + \theta_3 x_3 = \theta_0 + \theta_1 (size) + \theta_2 (size)^2 + \theta_3 (size)^3$
    > 如果采用这种方式，特征缩放将不需要考虑

## 正规方程(理论方法，一般不使用)
Normal equation : Method to solve for $\theta$ analytically.
> 正规方程 : 一种自动的方法求解参数 $\theta$

* Intuition 直观来看 : If 1D ( $\theta \in \Re$ )  若只有一个参数
    $J(\theta) = a\theta^2 + b\theta +c$ ，求解 $\dfrac{\partial}{\partial\theta}J(\theta)$ 导数为零时 $\theta$ 的值
    </br>
* Normally 实际中 : $\theta \in \Re^{n+1}$
    $J(\theta_0,\theta_1,...,\theta_n) = \dfrac{1}{2m} \sum^m_{i=1}(h_\theta(x^{(i)})-y^{(i)})^2$
    $\dfrac{\partial}{\partial\theta}J(\theta) = ... = 0$ ( for every $j$ )
    求出 $\theta_0,\theta_1,...,\theta_n$
    </br>

> </br>**举例**: $m=4$
> 
> | $\\x_0$ | Size($feet^2$)$\\x_1$ | Number of bedrooms $\\x_2$ | Number of floors $\\x_3$ | Age of home(years) $\\x_4$ | Price($\$$1000) $\\y$ |
> | :-----: | :-------------------: | :------------------------: | :----------------------: | :------------------------: | :-------------------: |
> | 1       | 2104                  | 5                          | 1                        | 45                         | 460                   |
> | 1       | 1416                  | 3                          | 2                        | 40                         | 232                   |
> | 1       | 1534                  | 3                          | 2                        | 30                         | 315                   |
> | 1       | 852                   | 2                          | 1                        | 36                         | 178                   |
> 转化为矩阵：</br>
> $X = \begin{bmatrix}1&2104&5&1&45\\1&1416&3&2&40\\1&1534&3&2&30\\1&852&2&1&36\end{bmatrix}$ , $y=\begin{bmatrix}460\\232\\315\\178\end{bmatrix}$ , 参数为: $\theta = (X^TX)^{-1}X^Ty$  
> </br>

* General Case 通常情况下：
    </br>$m$ examples $(x^{(1)},y^{(1)}),...,(x^{(m)},y^{(m)})$; $n$ features.  $m$ 个样本 $(x^{(1)},y^{(1)}),...,(x^{(m)},y^{(m)})$ ; $n$ 个特征。
    </br>
    $x^{(i)} = \begin{bmatrix}x_0^{(i)}\\x_1^{(i)}\\x_2^{(i)}\\.\\.\\.\\x_n^{(i)}\end{bmatrix} \in \Re^{n+1}$
    </br>
* Design Matrix 设计矩阵
    </br>$X = \begin{bmatrix}-(x^{(1)})^T-\\-(x^{(2)})^T-\\-(x^{(3)})^T-\\.\\.\\.\\-(x^{(m)})^T-\end{bmatrix}$ 这个矩阵维度为 $m \times (n+1)$
    </br>
    > </br>**举例**: 如果 $x^{(i)} = \begin{bmatrix}1\\x_1^{(i)}\end{bmatrix}$ ， 设计矩阵为 : $X=\begin{bmatrix}1&x_1^{(1)}\\1&x_2^{(1)}\\1&x_3^{(1)}\\.&.\\.&.\\.&.\\1&x_m^{(1)}\end{bmatrix}$ ， $y=\begin{bmatrix}y^{(1)}\\y^{(2)}\\y^{(3)}\\.\\.\\.\\y^{(m)}\end{bmatrix}$ ， 因此 $\theta = (X^TX)^{-1}X^Ty$ 
    > </br>
* 说明
    > </br>$\theta = (X^TX)^{-1}X^Ty$ , $(X^TX)^{-1}$ is inverse of matrix $X^TX$ ，$(X^TX)^{-1}$ 矩阵是 $X^TX$ 矩阵的逆。
    > </br>

### 对比总结

$m$ training examples, $n$ features. $m$ 个训练样本 $n$ 个特征
| Gradient Descent                                                        | Normal Equation                                                                                                                           |
| :---------------------------------------------------------------------: | :---------------------------------------------------------------------------------------------------------------------------------------: |
| Need to choose $\alpha$</br>需要选择学习率 $\alpha$                     | No need to choose $\alpha$</br>不需要选择学习率 $\alpha$                                                                                  |
| Needs many iterations</br>需要很多次迭代                                | Don't need to iterate</br>不需要迭代                                                                                                      |
| Works well even when $n$ is large</br>即使特征 $n$ 很多也可以很好的工作 | Need to compute $(X^TX)^{-1}$, Slow if $n$ is very large</br>需要计算 $(X^TX)^{-1}$, 如果特征 $n$ 很大，计算将会很慢</br>复杂度为$O(n^3)$ |

> $n < 10000$ 建议使用 **正规方程** (线性回归)
> $n \geqslant 10000$ 建议使用 **梯度下降法**

## 正规方程 (矩阵不可逆的解法)
正规方程  $\theta = (X^TX)^{-1}X^Ty$ ， 如果 $X^TX$ 不可逆
1. Redundant features 多余的特征  (linearly dependent)
E.g. $x_1$ = size in $feet^2$ , $x_2$ = size in $m^2$ (第二个是多余的)
2. Too many features 过多的特征 (e.g. $m \leqslant n$).
    - Delete some features,or use regularization.删除一些特征，或者使用 **正则化**。