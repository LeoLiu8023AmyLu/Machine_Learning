# 应用机器学习的建议

优化模型性能的一些途径(并非全部有效，需要根据项目特点进行选择):
* 获取更多的训练数据 (有时候无效)
* 调整特征数量 (增大/减少 特征数量)
* 增加多项式特征 (例如: $x_1^2 , x_2^2 , x_1x_2 , $ etc.)
* 调整正则化参数 $\lambda$

**机器学习诊断** 工作比较重要，可以协助找到模型 **优化的方向**  

## 评估假设

### 生成训练集与测试集
将一组数据集 `data set` 按照 **7:3** 的比例分成 **训练集** `training set` 与 **测试集** `test set`.

| 数据集名称 |    英文名称    | 占比  |
| :--------: | :------------: | :---: |
|   训练集   | `training set` |  70%  |
|   测试集   |   `test set`   |  30%  |

> 数据集排序 最好是 **无序** 、 **随机** 的

### 线性回归

1. 利用训练集训练模型参数 $\theta$
2. 计算测试集误差: $J_{test}(\theta) = \dfrac{1}{2m_{test}} \ \sum^{m_{test}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{test}) - y^{(i)}_{test} \Bigr)^2$

### 逻辑回归

1. 利用训练集训练模型参数 $\theta$
2. 计算测试集误差: $J_{test}(\theta) = - \dfrac{1}{m_{test}} \ \sum^{m_{test}}_{i=1}\Bigl( y^{(i)}_{test} \times \log(h_{\theta}(x^{(i)}_{test})) + (1 - y^{(i)}_{test}) \times \log(1 - h_{\theta}(x^{(i)}_{test})) \Bigr)^2$
3. Misclassification error 误分类错误 (0/1 misclassification error)
    > $err(h_\theta(x),y)=\begin{cases} 1 &\text{if } h_\theta(x) \geqslant 0.5,y=0 \ \ or \ if \ h_\theta(x) < 0.5,y=1 \\0 &\text{otherwise} \end{cases}$
    > 
    > Test Error  $= \dfrac{1}{m_{test}} \ \sum^{m_{test}}_{i=1} \ err(h_\theta(x^{(i)}_{test}),y^{(i)}_{test})$

## 模型选择 与 数据集划分

> 1. 训练集误差不能当做模型的性能评价指标(不能对实际泛化能力做出很好的判断)
> 2. 如果使用 **测试集** 作为假设函数的验证数据的话，也存在 **实际泛化能力** 判断的缺陷，不能很好的反应实施情况。

解决方案：增加 交叉验证集 `cross validation set` 简称 `cv`

| 数据集名称 |        英文名称        | 占比  |
| :--------: | :--------------------: | :---: |
|   训练集   |     `training set`     |  60%  |
| 交叉验证集 | `cross validation set` |  20%  |
|   测试集   |       `test set`       |  20%  |

可得到各个集的误差:
* 训练集误差:
    $J_{train}(\theta) = \dfrac{1}{2m_{train}} \ \sum^{m_{train}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{train}) - y^{(i)}_{train} \Bigr)^2$

* 交叉验证集误差: 
    $J_{cv}(\theta) = \dfrac{1}{2m_{cv}} \ \sum^{m_{cv}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{cv}) - y^{(i)}_{cv} \Bigr)^2$

* 测试集误差: 
    $J_{test}(\theta) = \dfrac{1}{2m_{test}} \ \sum^{m_{test}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{test}) - y^{(i)}_{test} \Bigr)^2$

利用交叉验证集选择模型假设，可以节省测试集，这样就可以利用测试集来评测模型的泛化能力了

## 诊断偏差与方差

|  描述  |   英文名称    |  状态  |
| :----: | :-----------: | :----: |
| 高偏差 |  Hight bias   | 欠拟合 |
|  正常  |  Just right   |  合适  |
| 高方差 | High variance | 过拟合 |

如果是多项式拟合的话 ($d$ 代表最高阶数 )
![误差函数](/assets/误差函数.jpg)

判断方法：
* 左侧是 **高偏差** 欠拟合状态
    > $J_{train}(\theta)$ 较大，同时 $J_{cv}(\theta) \approx J_{train}(\theta)$ 
* 右侧是 **高方差** 过拟合状态
    > $J_{train}(\theta)$ 较小，同时 $J_{cv}(\theta) >> J_{train}(\theta)$

## 正则化 偏差 与 方差

正则化参数 $\lambda$ 对训练的影响
|  描述  |   英文名称    |  状态  |                                                    正则化参数                                                     |
| :----: | :-----------: | :----: | :---------------------------------------------------------------------------------------------------------------: |
| 高偏差 |  Hight bias   | 欠拟合 | $\lambda$ 非常大 ($\lambda = 10000$)，$\\ \theta_1 \approx 0,\theta_2 \approx 0,...,h_\theta(x) \approx \theta_0$ |
|  正常  |  Just right   |  合适  |                                       $\lambda$ 适中才能得到较好的拟合结果                                        |
| 高方差 | High variance | 过拟合 |                                $\lambda$ 非常小  ($\lambda = 0$)， 正则化不起作用                                 |

### 选择合适的正则化参数 $\lambda$

正则化只用于训练时的误差函数，评测使用的误差函数不加正则化
* 训练时使用的带有正则化的误差函数:
    $J(\theta) = \dfrac{1}{2m} \ \sum^{m}_{i=1}\Bigl(h_{\theta}(x^{(i)}) - y^{(i)} \Bigr)^2 + \dfrac{\lambda}{2m} \ \sum^m_{j=1} \theta^2_j$

* 训练集误差:
    $J_{train}(\theta) = \dfrac{1}{2m_{train}} \ \sum^{m_{train}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{train}) - y^{(i)}_{train} \Bigr)^2$

* 交叉验证集误差: 
    $J_{cv}(\theta) = \dfrac{1}{2m_{cv}} \ \sum^{m_{cv}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{cv}) - y^{(i)}_{cv} \Bigr)^2$

* 测试集误差: 
    $J_{test}(\theta) = \dfrac{1}{2m_{test}} \ \sum^{m_{test}}_{i=1}\Bigl(h_{\theta}(x^{(i)}_{test}) - y^{(i)}_{test} \Bigr)^2$

判断方法:
* $\lambda$ 越小:  **高方差** 模型处于 **过拟合** 状态
* $\lambda$ 越大:  **高偏差** 模型处于 **欠拟合** 状态

## 学习曲线 Learning curves

* 训练集越小，训练集误差越小；训练集越大，训练集误差越大。
* 训练集越小，交叉训练集误差越大；训练集越大，交叉训练集误差越小。

### 高偏差情况 High bias 

交叉训练集与训练集会随着训练数据的增加变得越来越接近
> $J_{cv}(\theta)$ 与 $J_{train}(\theta)$ 特点是 $m$ 增大到一定程度后，相对较大

### 高方差情况 High vairenc 