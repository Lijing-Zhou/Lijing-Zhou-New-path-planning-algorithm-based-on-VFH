clc;
clear all;
close all;
%ends ros if it is already running
rosshutdown;
%if you are working with a VM, please put its ipaddress here
 ipaddress='localhost'
%connects with the ROS_Master
rosinit(ipaddress);
robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);
forwardVelocity = 0;
angularVelocity = 0;
velmsg.Linear.X = forwardVelocity;
velmsg.Angular.Z = angularVelocity;
% odom_subs = rossubscriber('/odom');
%laser = rossubscriber('/front/scan');

while 1
camera = rossubscriber('/kinect2/qhd/image_depth_rect');
t=receive(camera);
R=t.Data(1:2:end);
R=reshape(R,[960,540]);
R=R';
R1=t.Data(2:2:end);
R1=reshape(R1,[960,540]);
R1=R1';
RGB(:,:,1)=R;
RGB(:,:,2)=R1;
rgb=uint8(RGB);
end
