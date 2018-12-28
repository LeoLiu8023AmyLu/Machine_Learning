# PaperReading
* 论文题目： **Localized Traffic Sign Detection with Multi-scale Deconvolution Networks** 
* 论文链接：[PDF 下载地址](https://arxiv.org/ftp/arxiv/papers/1804/1804.10428.pdf) 

## 论文简介
* 本论文提出一种 MDN (Multi-scale Deconvolution Networks) 的方法，灵活的结合multi-scale convolutional neural network with deconvolution sub-network。
* 交通牌检测需要用到**颜色**与**形状**属性
* MDN框架下，有三个阶段：
    * classification stage
    使用 (GTSRB) 数据集 训练 传统 CNN 网络分类器 与 advanced residual network
    * recognition stage
    使用精炼与挑选后的本地数据 (CTSD) 用于训练冗余的去卷积网络(redundant deconvolution networks)
    * integrate stage
    集成多路检测器

* 文章贡献
    1. a unified framework MDN combining classical convolutional neural network with deconvolution network can effectively train multi-scale images of traffic sign; 
    2. two different traffic sign datasets collecting German and Chinese sign images are trained and compared; 
    3. a relatively small amount of traffic sign images from long distance taken are involved to be detected; 
    4. especially, some of traffic sign covered by environmental objects, such as trees, leaves, and others are also been labeled and detected.

因此提出：
we propose a multi-scale deep neural networks framework by fusing convolutional neural network with residual network and modifying feature pyramid networks.
> 将残差网络与金字塔特征修正网络融合的多尺寸深度神经网络框架

## 网络结构
![MDN网络结构](/assets/MDN网络结构.PNG)
MDN mainly consists of Convolutional Residual Network (CRN), modified Feature Pyramid Network (MFPN), and the multiscale classifier and detector.

MDN 网络主要由 CRN (Convolutional Residual Network) ，MFPN (modified Feature Pyramid Network) 和多个分类器与检测器组成。

## 损失函数

* 置信度损失 confidence loss(conf) and 局部损失 localization loss(loc)
$L(x,c,l,g) =\dfrac{1}{N} \Bigl(L_{conf}(x,c)+\alpha L_{loc}(x,l,g)\Bigr)$
> $N$ 默认框数
> $\alpha$ 调节参数，用于平衡 置信度损失与局部损失
* 置信度损失函数
$L_{conf}(x,c) = - \sum^n_{i=Pos}(x^p_{ij} log(\hat{c}^p_i)) - \sum^n_{i \in Neg}(x^p_{ij} log(\hat{c}^0_i))  $ , 其中 $c^p_i = \dfrac{exp(c^p_i)}{\sum_p(exp(c^p_i))}$
* 局部损失函数
$L_{loc}(x,l,g) = \sum^N_{i in Pos} \sum_{m in \{xc,cy,w,h\}} x^k_{ij} smooth_{L1}(l^m_i-\hat{g}^m_j)$ 
其中: 
* $\hat{g}^{cx}_j = (g^{cx}_j - d^{cx}_i) / d^w_i$
* $\hat{g}^{cy}_j = (g^{cy}_j - d^{cy}_i) / d^h_i$
* $\hat{g}^{w}_j = log(\dfrac{g^w_j}{d^w_i})$
* $\hat{g}^{h}_j = log(\dfrac{g^h_j}{d^h_i})$

### Convolutional Residual Network 卷积网络
![CRN网络结构](/assets/CRN网络结构.PNG)
### Modified Feature Pyramid Network 改进的特征金字塔网络
![MFPN网络结构](/assets/MFPN网络结构.PNG)
### Multi-scale Classifier 多尺寸分类器

## 对比
* 分类
![MDN分类对比](/assets/MDN分类对比.PNG)
* 检测
![MDN检测对比](/assets/MDN检测对比.PNG)
## 结论 
MDN 模型性能 优于 SSD300