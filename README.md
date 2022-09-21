# Lijing-Zhou-New-path-planning-algorithm-based-on-VFH
Lijing-Zhou/New-path-planning-algorithm-based-on-VFH



这是我2018年在底特律大学做的在Gazebo环境下用Matlab语言编写的基于VFH的改进动态路径规划算法。
This is my bachelor project of University of Detroit Mercy(2018)
//
//
如今，越来越多的移动机器人已经成为我们日常生活中常见的工具。
在我们的日常生活中变得很普遍。越来越多的人
认识到移动机器人在完成
复杂任务的重要性。此外，工程师们开始关注以下问题
物体的颜色和形状识别以及在未知环境中的机动性。
未知环境中的机动性。该任务的目标是进行
正确的导航，并找到合适的路径计划，在避开障碍物的情况下到达目的地。
在避开障碍物时到达目的地。我们的算法
我们创建的算法是基于VFH的，它可以提供精确的
在凉亭世界环境和真实世界中避开障碍物。
世界。VFH算法创建了直方图来划分机器人可以运行的部分，以引导机器人到达目的地。
形成直方图来划分机器人可以运行的部分，以引导机器人到达目标。我们
使用类似的理论来划分基于激光雷达的部分。
激光雷达就像一个雷达，发射光线并接受反馈，以识别障碍物并返回。
反馈来识别障碍物并返回距离。障碍物
起点和终点之间的不同角度也
可以影响我们想要的线速度和角速度。
给予机器人的线速度和角速度
在该部分，将介绍项目期间的模型。它主要包括主要的软件和硬件
部分。控制真正的机器人的理论将很快被介绍
介绍。
A. GAZEBO软件建模
本节介绍了本文所使用的模型和环境
本文中使用的模型和环境。环境 我们的模型是在Gazebo中建立的
并由MATLAB控制。Gazebo提供了机器人
模型（Turtlebot）、激光雷达（Hokuyo）、地面和不同大小和形状的障碍物。
具有不同的尺寸和形状。MATLAB被用来获取数据
从测距仪和激光雷达中获取数据，然后计算出所需的移动方向。
方向。最后将其转换为角速度和
线性速度，然后发送给机器人模型。
B. 激光雷达硬件建模
Hokuyo传感器可以检测到障碍物并给出
距离的反馈。Gazebo可以下载激光雷达的主题
角度范围为-135度至135度
当我们假设前面的方向是相对0度时。角度范围
距离范围是0到10米。激光雷达产生的720个数据点
由激光雷达产生的720个数据点被划分为每个区域的0.375个数据点。在
真正的机器人建模中，我们使用Hokuyo UST-10LX扫描
激光器来返回必要的数据。扫描角度为270，角度分辨率为0.25
角度分辨率为0.25。探测距离为
0.06米到10米。不同的是，Hokuyo UST-10LX
扫描激光器将角度范围分为1080个数据点。
基于其角度分辨率。
C. 哈斯基
Husky是由Clearpath公司设计的一个机器人。
通过提供速度，机器人可以被引导以特殊的速度移动。
通过提供速度，可以引导机器人以特殊的速度移动。该机器人可由ROS系统和开放源代码支持。
和开放源代码的支持。赫斯基有非常高的分辨率
编码器，可以提供更好的状态估计并返回
精确的测距数据。事实上，凭借所提供的速度，机器人本身可以令人难以置信地提供平滑的运动。
机器人本身可以令人难以置信地提供平滑的运动曲线。
低于1米/秒的不同速度，并拒绝一些
相当大的干扰
                           
Nowadays, the increasing numbers of mobile robots have
become common in our daily life. More and more people
realize the importance of the mobile robots in completing
complex tasks. Furthermore, engineers starts to focus on the
objects color and shape recognition and maneuvering in an
unknown environment. The objective of the task is to do
the correct navigation and find a suitable path plan to get
the destination when avoiding obstacles. The algorithm we
created is based on the VFH and it can give the precise
obstacle avoiding in the gazebo world environment and really
world. The VFH algorithm created histogram to divide the
part that the robot can run to guide the robot to the goal. We
use the similar theory to divide the parts based on the lidar.
The lidar is like a radar to launch the light and accept the
feedback to identity the obstacles and return the distance. The
different angle between the start point and the end point also
can influence the linear and angular speeds that we want to
give the robot
