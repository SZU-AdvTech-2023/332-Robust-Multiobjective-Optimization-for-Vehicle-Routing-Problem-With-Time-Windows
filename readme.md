<h1>代码说明</h1>

<h2>problem部分</h2>

<h3>有原文给出的基于solomon benchmark更改的6类问题，规模从25~100都有，可以根据所需在matlab中调用不同的问题集进行测试。</h3>

<h2>code部分</h2>

<h3>RMOPSO：主程序，运行该程序来获得解，在该代码开头可以更改本次测试所用问题，改变变量distb的值可以改变本次测试中使用的最大扰动程度</h3>

<h3>calrob：计算解的鲁棒性</h3>

<h3>calobj：计算解的两个目标函数</h3>

<h3>greedydecoder：贪心解码器，相对问题的粒子建模将其解码成一条路径。</h3>

<h3>Localresearch1：基于粒子的局部搜索策略</h3>

<h3>Localresearch2：基于路径的局部搜索策略</h3>

<h3>montecarlo：蒙特卡洛测试法，测量解的鲁棒能力</h3>

<h3>updaterep：存档更新</h3>

<h3>judger：判断一条路径是否合法</h3>