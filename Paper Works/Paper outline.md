# 低小慢雷达流水线式实时数据处理系统的研究与实现

## 绪论
1. 研究背景
2. 国内外现状
3. 本文创新与改进

## 雷达原理
1. 雷达目标检测原理 (信号处理)
2. 雷达系统框架
3. 雷达数据处理流程 Pipeline

## 航迹预测 与 航迹相关
1. 目标特征分析
2. 数据过滤方案 (杂波图等 噪声、异常数据抑制方法)
3. 航迹预测方案 (卡尔曼 、$\alpha - \beta - \gamma$、本项目采用的有效方法)
4. 航迹相关方案 (近邻、联合密度估计JPDA、本项目采用的有效方法)

## 设计与实现
1. 软件设计框架
   1. MVC 结构
   2. 数据提取 (网口报文转换数据结构)
   3. 扇区循环存放结构
   4. 多进程+多线程+队列 数据处理模块
   5. 航迹显示 (P显、A显、B显等)
   6. 数据输出 (数据库，UDP网络广播)
   
2. 实现方案
   Python + PyQt5 + SQLite + WinpCap
   
3. 优化方法
   * 利用队列通行 组成的流水线式并发 处理机制
   * 分组优化方案
   * 矩阵代替循环运算提升效率
   * 数据通信稳定响应机制
   * 鲁棒性设计

## 实现结果
1. 雷达数据处理效果
2. 满负荷性能测试
3. 数据处理准确度测试
4. 数据处理鲁棒性测试

## 总结与展望

## 感谢

## 目前需要考虑的问题
1. 航迹容易断，是由于预测模型不准确造成的
   * JPDA 联合概率密度
   * 卡尔曼滤波
2. 目标识别算法
   * RCS 截面积估计
   * 融合点模型估算
3. 点迹融合需要考虑两种方式
   * 多点阈值内加权平均平滑 方位 与 俯仰
   * 和差通道自动修正角度偏移
4. 电子罗盘经纬度修正
   * 无电子罗盘的码盘矫正方式
   * 有电子罗盘与真北的矫正方式


## 参考文献

### 刘裕

[1] 陆晓明. 基于神经网络的雷达杂波抑制[D].南京航空航天大学,2018.
[2] 吴聪,李海飞,王红,李剑斌.PD雷达探测低慢小目标性能分析[J].科学技术与工程,2013,13(28):8492-8496+8519.
[3] 任清安,吕春燕.雷达光电智能协同探测技术研究[J].雷达科学与技术,2016,14(02):173-177+183.
[4] 许道明,张宏伟.雷达低慢小目标检测技术综述[J].现代防御技术,2018,46(01):148-155.
[5] 王伟. 基于形状特征辅助的低慢小目标检测与跟踪算法[A]. 中国高科技产业化研究会智能信息处理产业化分会.第十二届全国信号和智能信息处理与应用学术会议论文集[C].中国高科技产业化研究会智能信息处理产业化分会:中国高科技产业化研究会,2018:8.
[6] Ritchie M, Fioranelli F, Borrion H. Micro UAV Crime Prevention: Can We Help Princess Leia?[J]. 2017. 
[6] Wit J J M D, Harmanny R I A, Prémel Cabic G. Micro-Doppler Analysis of Small UAVs[J]. 2012. 
[7]  Hanssen A G, Girard Y, Olovsson L, et al. A numerical model for bird strike of aluminium foam-based sandwich panels[J]. International Journal of Impact Engineering, 2006, 32(7): 1127-1144. 
[8]  王忠, 马妍, 王莲荣. 防空作战中低慢小目标威胁度评估[J]. 舰船电子对抗, 2013, 36(6): 103-105. 
[9]  秦清, 徐毓. 低慢小目标多装备协同探测分配问题研究[J]. 空军雷达学院学报, 2012, 26(1): 28-31. 
[10]  魏耀, 张靖, 叶杰. 低慢小目标探测时的气象干扰抑制方法研究[J]. 现代雷达, 2016, 38(7): 36-39. 
[11] Japkowicz N, Stephen S. The class imbalance problem: A systematic study[J]. Intelligent data analysis, 2002, 6(5): 429-449. 
[12] Haykin S, Deng C. Classification of radar clutter using neural networks[J]. IEEE Transactions on Neural Networks, 1991, 2(6): 589-600. 
[13] Tsatsanis M K, Giannakis G B. Object and texture classification using higher order statistics[J]. IEEE Transactions on Pattern Analysis and Machine Intelligence, 1992, 14(7): 733-750. 
[14]  窦泽华, 张仕元, 李明. 基于雷达回波识别的杂波抑制[J]. 信号处理, 2009(8): 1193-1197.[17] 韩伟, 汤子跃, 朱振波. 利用道路信息的机载预警雷达空地目标分类[J]. 电光与控制, 2013, 20(6): 45-49. 
[15]  Nagel  D,  Smith  S.  Creating  a  likelihood  vector  for  ground  moving  targets  in  the  exo-clutter region of airborne radar signals[C]//Sensor Data Fusion: Trends, Solutions, Applications (SDF), 2012 Workshop on. IEEE, 2012: 49-54. 
[16] Nagel D, Neumann C, Smith S. Classification of ground moving targets in the exo-clutter region of airborne radar signals[C]//Radar Symposium, 2008 International. IEEE, 2008: 1-5. 
[17]  Zhang  X  B,  Li  M.  Discrimination  of  low-flying  vehicle  from  ground  moving  targets  using multi-path[C]//Microwave,  Antenna,  Propagation  and  EMC  Technologies  for  Wireless Communications, 2009 3rd IEEE International Symposium on. IEEE, 2009: 721-725. 
[18]  王福友,  罗钉,  刘宏伟.  低分辨机载雷达空地运动目标的分类识别算法[J].  雷达学报, 2014, 3(5): 497-504. 
[19]  Wang  S,  Li  J,  Wang  Y,  et  al.  Radar  HRRP  target  recognition  based  on  Gradient  Boosting Decision  Tree[C]//Image  and  Signal  Processing,  BioMedical  Engineering  and  Informatics (CISP-BMEI), International Congress on. IEEE, 2016: 1013-1017. 
[20] 任子元,李强.基于排列法的低空慢速小目标威胁评估[J].微计算机信息,2009,25(22):238-240.
[21] 张承志,任清安.一种利用TBD自动检测低慢小目标的方法[J].空军预警学院学报,2013,27(02):118-121.
[22] 吕宽,张玉,唐波.基于多先验谱模型的低慢小目标子空间检测器[J].火力与指挥控制,2018,43(09):182-185.
[23] 宋喜玉,郑娜娥,孙扬.多目标跟踪的分布式MIMO雷达最少阵元选取算法[J].系统工程与电子技术,2017,39(10):2228-2233.
[24] 李菠,孟立凡,李晶,刘春美,黄广炎.低空慢速小目标探测与定位技术研究[J].中国测试,2016,42(12):64-69.
[25] 奚玉鼎,张永帅,于涌,唐正宏.基于OpenCV的低慢小目标追踪系统软件设计[J].工业控制计算机,2018,31(07):103-104.
[26] 杨建军,卞磊,路彬彬.探测低慢小目标的新体制雷达技术[J].电子技术与软件工程,2018(17):101.
[27] 王兰云,赵拥军.相控阵雷达多目标跟踪原理及数据关联算法研究[J].电光与控制,2007(01):30-33.
[28] 吴聪,王红,李剑斌.多径效应对低慢小目标探测影响分析[J].雷达与对抗,2013,33(03):15-17+21. 
[29] 奚玉鼎,于涌,丁媛媛,李岩,曾令晖,唐正宏.一种快速搜索空中低慢小目标的光电系统[J].光电工程,2018,45(04):58-67.
[30] 李菠,孟立凡,李晶,刘春美,黄广炎.探测低慢小目标的高精度时间间隔测量方法[J].科学技术与工程,2017,17(16):248-253.

### 陆晓明
[1] Ritchie M, Fioranelli F, Borrion H. Micro UAV Crime Prevention: Can We Help Princess Leia?[J]. 2017. 
[2] Wit J J M D, Harmanny R I A, Prémel Cabic G. Micro-Doppler Analysis of Small UAVs[J]. 2012. 
[3]  Hanssen A G, Girard Y, Olovsson L, et al. A numerical model for bird strike of aluminium foam-based sandwich panels[J]. International Journal of Impact Engineering, 2006, 32(7): 1127-1144. 
[4]  王忠, 马妍, 王莲荣. 防空作战中低慢小目标威胁度评估[J]. 舰船电子对抗, 2013, 36(6): 103-105. 
[5]  秦清, 徐毓. 低慢小目标多装备协同探测分配问题研究[J]. 空军雷达学院学报, 2012, 26(1): 28-31. 
[6]  魏耀, 张靖, 叶杰. 低慢小目标探测时的气象干扰抑制方法研究[J]. 现代雷达, 2016, 38(7): 36-39. 
@[7] Mitchell T M. Machine learning. WCB[J]. 1997. 
@[8]  于化龙.  类别不平衡学习理论与算法.  清华大学出版社, 2017. 
[9] Japkowicz N, Stephen S. The class imbalance problem: A systematic study[J]. Intelligent data analysis, 2002, 6(5): 429-449. 
@[10] Chawla N V, Japkowicz N, Kotcz A. Editorial: special issue on learning from imbalanced data sets, SIGKDD Explor. Newsl. 6 (1)(2004) 1–6[J]. 
@[11] Weiss G M, Zadrozny B, Saar-Tsechansky M. Guest editorial: special issue on utility-based data mining[J]. Data Mining and Knowledge Discovery, 2008, 17(2): 129-135. 
@[12] Turney P D. Cost-sensitive classification: Empirical evaluation of a hybrid genetic decision tree induction algorithm[J]. Journal of artificial intelligence research, 1995, 2: 369-409. 
@[13] Chawla N V, Japkowicz N, Kotcz A. Special issue on learning from imbalanced data sets[J]. ACM Sigkdd Explorations Newsletter, 2004, 6(1): 1-6. 
[14] Haykin S, Deng C. Classification of radar clutter using neural networks[J]. IEEE Transactions on Neural Networks, 1991, 2(6): 589-600. 
[15] Tsatsanis M K, Giannakis G B. Object and texture classification using higher order statistics[J]. IEEE Transactions on Pattern Analysis and Machine Intelligence, 1992, 14(7): 733-750. 
[16]  窦泽华,  张仕元,  李明.  基于雷达回波识别的杂波抑制[J].  信号处理, 2009 (8): 1193-1197. [17]  韩伟,  汤子跃,  朱振波.  利用道路信息的机载预警雷达空地目标分类[J].  电光与控制, 2013, 20(6): 45-49. 
[18]  Nagel  D,  Smith  S.  Creating  a  likelihood  vector  for  ground  moving  targets  in  the  exo-clutter region of airborne radar signals[C]//Sensor Data Fusion: Trends, Solutions, Applications (SDF), 2012 Workshop on. IEEE, 2012: 49-54. 
[19] Nagel D, Neumann C, Smith S. Classification of ground moving targets in the exo-clutter region of airborne radar signals[C]//Radar Symposium, 2008 International. IEEE, 2008: 1-5. 
[20]  Zhang  X  B,  Li  M.  Discrimination  of  low-flying  vehicle  from  ground  moving  targets  using multi-path[C]//Microwave,  Antenna,  Propagation  and  EMC  Technologies  for  Wireless Communications, 2009 3rd IEEE International Symposium on. IEEE, 2009: 721-725. 
[21]  王福友,  罗钉,  刘宏伟.  低分辨机载雷达空地运动目标的分类识别算法[J].  雷达学报, 2014, 3(5): 497-504. 
@[22]  王福友,  罗钉,  刘宏伟.  低分辨机载雷达飞机目标分类识别技术研究[J].  雷达学报,  2014, 3(4): 444-449. 
@[23]  周志华.  机器学习  : = Machine learning[M].  清华大学出版社, 2016. 
@[24] Kohonen T. An introduction to neural computing[J]. Neural networks, 1988, 1(1): 3-16. 
@[25] Abu-Mostafa Y S, Magdon-Ismail M, Lin H T. Learning from data[M]. New York, NY, USA:: AMLBook, 2012. 
@[26] Vapnik V N, Vapnik V. Statistical learning theory[M]. New York: Wiley, 1998. 
@[27]  Hinton  G  E,  Osindero  S,  Teh  Y  W.  A  fast  learning  algorithm  for  deep  belief  nets[J].  Neural computation, 2006, 18(7): 1527-1554. 
@[28]  Bengio  Y,  Lamblin  P,  Popovici  D,  et  al.  Greedy  layer-wise  training  of  deep  networks[C] //Advances in neural information processing systems. 2007: 153-160. 
@[29]  Vincent  P,  Larochelle  H,  Bengio  Y,  et  al.  Extracting  and  composing  robust  features  with denoising  autoencoders[C]//Proceedings  of  the  25th  international  conference  on  Machine  learning. ACM, 2008: 1096-1103. 
@[30]  Larochelle  H,  Bengio  Y,  Louradour  J,  et  al.  Exploring  strategies  for  training  deep  neural networks[J]. Journal of Machine Learning Research, 2009, 10(Jan): 1-40. 
@[31] Salakhutdinov R, Hinton G. Deep boltzmann machines[C]//Artificial  Intelligence and Statistics. 2009: 448-455. 
@[32]  Lee  H,  Grosse  R,  Ranganath  R,  et  al.  Convolutional  deep  belief  networks  for  scalable unsupervised learning of hierarchical representations[C]//Proceedings of the 26th annual international conference on machine learning. ACM, 2009: 609-616. 
@[33] Poultney C, Chopra S, Cun Y L. Efficient learning of sparse representations with an energy-based model[C]//Advances in neural information processing systems. 2007: 1137-1144. 
@[34]  Boureau  Y,  Cun  Y  L.  Sparse  feature  learning  for  deep  belief  networks[C]//Advances  in  neural information processing systems. 2008: 1185-1192. 
@[35]  Lee  H,  Pham  P,  Largman  Y,  et  al.  Unsupervised  feature  learning  for  audio  classification  using convolutional  deep  belief  networks[C]//Advances  in  neural  information  processing  systems.  2009: 1096-1104. 
@[36] Haykin S, Deng C. Classification of radar clutter using neural networks[J]. IEEE Transactions on Neural Networks, 1991, 2(6): 589-600. 
@[37]  Haykin  S,  Stehwien  W,  Deng  C,  et  al.  Classification  of  radar  clutter  in  an  air  traffic  control environment[J]. Proceedings of the IEEE, 1991, 79(6): 742-772. 
@[38]  Shi  L,  Wang  P,  Liu  H,  et  al.  Radar  HRRP  statistical  recognition  with  local  factor  analysis  by automatic Bayesian Ying-Yang harmony learning[J]. IEEE Transactions on Signal Processing, 2011, 59(2): 610-617. 
@[39]  Du  L,  Wang P,  Liu  H,  et al.  Bayesian  spatiotemporal  multitask  learning  for  radar HRRP  target recognition[J]. IEEE Transactions on Signal Processing, 2011, 59(7): 3182-3196. 
@[40]  Lundén  J,  Koivunen  V.  Deep  learning  for  HRRP-based  target  recognition  in  multistatic  radar systems[C]//Radar Conference (RadarConf), 2016 IEEE. IEEE, 2016: 1-6. 
@[41] Pan M, Jiang J, Kong Q, et al. Radar HRRP Target Recognition Based on t-SNE Segmentation and Discriminant Deep Belief Network[J]. IEEE Geoscience and Remote Sensing Letters, 2017, 14(9): 1609-1613. 
[42]  Wang  S,  Li  J,  Wang  Y,  et  al.  Radar  HRRP  target  recognition  based  on  Gradient  Boosting Decision  Tree[C]//Image  and  Signal  Processing,  BioMedical  Engineering  and  Informatics (CISP-BMEI), International Congress on. IEEE, 2016: 1013-1017. 
@[43] Ling C X, Li C. Data mining for direct marketing: Problems and solutions[C]//KDD. 1998, 98: 73-79. 
@[44] Chawla N V, Bowyer K W, Hall L O, et al. SMOTE: synthetic minority over-sampling technique[J]. Journal of artificial intelligence research, 2002, 16: 321-357. 
@[45]  唐明珠.  类别不平衡和误分类代价不等的数据集分类方法及应用[D]. , 2011. 
@[46] Drummond C, Holte R C. C4. 5, class imbalance, and cost sensitivity: why under-sampling beats over-sampling[C]//Workshop on learning from imbalanced datasets II. Washington DC: Citeseer, 2003, 