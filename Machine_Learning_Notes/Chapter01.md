# 绪论:初识机器学习
## 机器学习应用领域
举例：
1. Database mining 数据挖掘 (网页点击量，医疗记录，生物)
2. Application can't program by hand 不能编写的程序 (手写字体识别，NLP，计算机视觉，无人驾驶)
3. Self-customizing programs 自适应程序 (推荐系统)
4. Understanding human learning 辅助理解人类学习机制

## 机器学习的定义
* Arthur Samuel (1959) 定义:
    > Field of study that gives computers the ability to learn without being explicitly programmed.  
    >   
    > 机器学习: 在没有明确设置的情况下使计算机具有学习能力的研究领域。

* Tom Mitchell (1988) 定义:
    > A computer program is said to learn from experience **E** with respect to some task **T** and some performance measured by **P**, if its performance on **T**, as measured by **P**, improves with experience **E**.
    >    
    > 计算机程序从经验 **E** 中学习, 解决某一任务 **T** ,进行某一性能度量 **P** ,通过 **P** 测定在 **T** 上的表现因经验 **E** 而提高。

* 机器学习主要算法
    * Supervised learning 监督学习
    * Unsupervised learning 无监督学习

* 其他学习类型：
    * Reinforcement learning 强化学习
    * recommender systems 推荐系统

 Ps : 算法就是工具，而学习使用工具更为重要 (了解工具的使用场景，工具的优缺点)

## 监督学习
房价预测问题，房间面积与价格；肿瘤问题，肿瘤大小与是否为有害。

### 定义
* Supervised Learning : "right answers" given. 
    > 监督学习训练数据集均带有答案 ( **label** )。
* Regression : Predict continuous valued output (value).
    > 回归 : 预测结果是连续的
* Classification : Discrete valued output ( 0 or 1 ).
    > 分类 : 预测结果是离散的

## 无监督学习
没有标签(答案)的数据集，需要算法自己去发现簇 ( **clusters** )  
> 例如 Google 的新闻内容聚类 

### 无监督(聚类算法)应用
* Organize computing clusters 计算集群
* Social network analysis 社交网络分析
* Market segmentation 市场细分
* Astronomical data analysis 天文数据分析

### 鸡尾酒会问题(鸡尾酒算法)
两个人同时讲话，如何分离两个讲话人的声音内容。将两个不同麦克风收到的信息进行处理后提取完整的分离的信息。
``` matlab
[W,s,v] = svd((repmat(sum(x.*x,1),size(x,1),1).x*)*x') 
```
> svd 奇异值分解

