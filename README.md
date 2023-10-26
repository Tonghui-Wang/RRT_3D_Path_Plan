在笛卡尔三维空间中，通过RRT算法进行避障路径的离线规划，借助Matlab工具进行编程仿真。  
  
测试：  
- Main1 单RRT对两点做路径规划，最终将可达节点串联，输出为规划结果。  
- Main2 双RRT对两点做路径规划，获得可达节点后再进行节点简化，输出为规划结果。  
- Main3 双RRT对三点做路径规划，获得可达节点后再进行节点简化，然后对简化后的节点进行B样条平滑处理，输出为规划结果。  

流程图：  
- 轨迹规划：  
![3](https://github.com/Tonghui-Wang/RRT_3D_Path_Plan/assets/23735485/c75457e8-acb4-49d2-acae-d2af5a7b83d8)  

- Main1：  
![1](https://github.com/Tonghui-Wang/RRT_3D_Path_Plan/assets/23735485/b0da55df-8f00-4f11-a6f5-511ddd379bd9)  

- Main2：  
![2](https://github.com/Tonghui-Wang/RRT_3D_Path_Plan/assets/23735485/cf7d1e9d-dc78-493e-ba62-b6e2de3c3c1e)  

效果：  
![rrt](https://github.com/Tonghui-Wang/RRT_3D_Path_Plan/assets/23735485/b146f5ca-1909-43d0-ad73-285ac351406e)  
该图为Main3规划结果，黄/绿/青绿线皆为有效避障路径：  
- 黄线-自然节点的直线串联  
- 绿线-简化节点的直线串联  
- 青绿线-简化节点的平滑串联  
  
展望：  
- 针对Main3，还可拓展至更多点的规划，或者拓展使用三RRT同时迭代。  

不足：  
- 在三维空间下，收敛速度有点慢，不适用于在线规划，暂时只能做离线规划。  
- 理论上一段时间后，RRT一定会收敛。但实践中，给定的迭代步数约束下，最终不一定能收敛。  
- RRT的结果没有一致性或重复性，也即每次规划结果都是随机的，几乎不存在完全相同的结果。  
  
参考文献：  
- [1]陈志勇黄泽麟曾德财于潇雁.复杂环境下六自由度机械臂路径规划的Biased-RRT修正算法[J].福州大学学报:自然科学版, 2022, 50(5):658-666.  
- [2]王雨,刘延俊,贾华,等.基于强化RRT算法的机械臂路径规划[J].山东大学学报（工学版）, 2022.  
