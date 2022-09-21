clear all

close all

clc;

rosshutdown; %ends ros if it is already running

ipaddress='localhost';%if you are working with a VM, please put its ipaddress here

rosinit(ipaddress); %connects with the ROS_Master
% odom_subs = rossubscriber('/odom');
odom_subs = rossubscriber('/jackal_velocity_controller/odom');
odom_msg = rosmessage(odom_subs);

time_load=1;
j=0;
%the first ball
while 1
j=j+1;
destposition=[5 5];   %srt the stop point
data_odom(j)= receive(odom_subs);
x1(j)=data_odom(j).Pose.Pose.Position.X;
y1(j)=data_odom(j).Pose.Pose.Position.Y;
dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
jiavfhzz(destposition,time_load); 
if dis<0.2
    target_sit=1;
    break
end

end

j=0;
target_sit;

while 1
j=j+1;
destposition=[0 0];   %srt the stop point
data_odom(j)= receive(odom_subs);
x1(j)=data_odom(j).Pose.Pose.Position.X;
y1(j)=data_odom(j).Pose.Pose.Position.Y;
dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
jiavfhzz(destposition,time_load); 
if dis<0.2
    target_sit=1;
    break
end

end

j=0;
target_sit;

%the second ball
while 1
j=j+1;
destposition=[5 3];   %srt the stop point
data_odom(j)= receive(odom_subs);
x1(j)=data_odom(j).Pose.Pose.Position.X;
y1(j)=data_odom(j).Pose.Pose.Position.Y;
dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
jiavfhzz(destposition,time_load); 
if dis<0.2
    target_sit=1;
    break
end

end

j=0;
target_sit;


while 1
j=j+1;
destposition=[0 0];   %srt the stop point
data_odom(j)= receive(odom_subs);
x1(j)=data_odom(j).Pose.Pose.Position.X;
y1(j)=data_odom(j).Pose.Pose.Position.Y;
dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
jiavfhzz(destposition,time_load); 
if dis<0.2
    target_sit=1;
    break
end

end

j=0;
target_sit;

%the third ball
while 1
j=j+1;
destposition=[-5 -5 ];   %srt the stop point
data_odom(j)= receive(odom_subs);
x1(j)=data_odom(j).Pose.Pose.Position.X;
y1(j)=data_odom(j).Pose.Pose.Position.Y;
dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
jiavfhzz(destposition,time_load); 
if dis<0.2
    target_sit=1;
    break
end

end

j=0
target_sit;

while 1
j=j+1;
destposition=[0 0];   %srt the stop point
data_odom(j)= receive(odom_subs);
x1(j)=data_odom(j).Pose.Pose.Position.X;
y1(j)=data_odom(j).Pose.Pose.Position.Y;
dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
jiavfhzz(destposition,time_load); 
if dis<0.2
    target_sit=1;
    break
end

end

j=0;
target_sit;
% clear all
% 
% close all
% 
% clc;
% 
% rosshutdown; %ends ros if it is already running
% 
% ipaddress='localhost';%if you are working with a VM, please put its ipaddress here
% 
% rosinit(ipaddress); %connects with the ROS_Master
% % odom_subs = rossubscriber('/odom');
% odom_subs = rossubscriber('/jackal_velocity_controller/odom');
% odom_msg = rosmessage(odom_subs);
% 
% time_load=1;
% j=0;
% %the first ball
% while 1
% j=j+1;
% destposition=[5 5];   %srt the stop point
% data_odom(j)= receive(odom_subs);
% x1(j)=data_odom(j).Pose.Pose.Position.X;
% y1(j)=data_odom(j).Pose.Pose.Position.Y;
% dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
% gazebojiavfhzz(destposition,time_load); 
% if dis<0.2
%     target_sit=1;
%     break
% end
% 
% end
% 
% j=0;
% target_sit;
% 
% while 1
% j=j+1;
% destposition=[0 0];   %srt the stop point
% data_odom(j)= receive(odom_subs);
% x1(j)=data_odom(j).Pose.Pose.Position.X;
% y1(j)=data_odom(j).Pose.Pose.Position.Y;
% dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
% gazebojiavfhzz(destposition,time_load); 
% if dis<0.2
%     target_sit=1;
%     break
% end
% 
% end
% 
% j=0;
% target_sit;
% 
% %the second ball
% while 1
% j=j+1;
% destposition=[5 3];   %srt the stop point
% data_odom(j)= receive(odom_subs);
% x1(j)=data_odom(j).Pose.Pose.Position.X;
% y1(j)=data_odom(j).Pose.Pose.Position.Y;
% dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
% gazebojiavfhzz(destposition,time_load); 
% if dis<0.2
%     target_sit=1;
%     break
% end
% 
% end
% 
% j=0;
% target_sit;
% 
% 
% while 1
% j=j+1;
% destposition=[0 0];   %srt the stop point
% data_odom(j)= receive(odom_subs);
% x1(j)=data_odom(j).Pose.Pose.Position.X;
% y1(j)=data_odom(j).Pose.Pose.Position.Y;
% dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
% gazebojiavfhzz(destposition,time_load); 
% if dis<0.2
%     target_sit=1;
%     break
% end
% 
% end
% 
% j=0;
% target_sit;
% 
% %the third ball
% while 1
% j=j+1;
% destposition=[-5 -5 ];   %srt the stop point
% data_odom(j)= receive(odom_subs);
% x1(j)=data_odom(j).Pose.Pose.Position.X;
% y1(j)=data_odom(j).Pose.Pose.Position.Y;
% dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
% gazebojiavfhzz(destposition,time_load); 
% if dis<0.2
%     target_sit=1;
%     break
% end
% 
% end
% 
% j=0
% target_sit;
% 
% while 1
% j=j+1;
% destposition=[0 0];   %srt the stop point
% data_odom(j)= receive(odom_subs);
% x1(j)=data_odom(j).Pose.Pose.Position.X;
% y1(j)=data_odom(j).Pose.Pose.Position.Y;
% dis=sqrt((x1(j)-destposition(1))^2+(y1(j)-destposition(2))^2)
% gazebojiavfhzz(destposition,time_load); 
% if dis<0.2
%     target_sit=1;
%     break
% end
% 
% end
% 
% j=0;
% target_sit;
