clear
close all
clc;
rosshutdown; %ends ros if it is already running
ipaddress='localhost';%if you are working with a VM, please put its ipaddress here
rosinit(ipaddress); %connects with the ROS_Master
robot = rospublisher('/mobile_base/commands/velocity');
odom_subs = rossubscriber('/odom');
velmsg = rosmessage(robot);
laser= rossubscriber('/scan');
i=0;
% position of destination
destination=[10 10];

for i=1:500
    % lidar_transfer: collect the data from lidar and select the suitable histogram
    h = lidar_transfer(laser);
    
    % smoothing: smooth the histogram to decrease the error
    [hm,avoid_po] = smoothing(h);
    
    % obstacle_avoid: select the suitable histogram
    % result : avoiding factor
    possibleSector = obstacle_avoid(hm);
    
    % according the safe distance make sure the histogram:
    % result: heading factor
  
    heading_po = heading();
    
    % calculate the path information( the angle from the (0 0) to
    % destination
    % result: path factor
    path_po = path(destination,i);

    
    % according to three factors to make sure the velocity
    % avoiding factor heading factor and path factor
    % result: finial histogram
    hchoose=choose(heading_po,path_po,avoid_po,possibleSector,hm);      
  
    
    % according the finial histogram to get the speed.
    [v,w]=speed(hchoose,hm);
     % send velocity  
    velmsg.Linear.X=v;
    velmsg.Angular.Z=w;
   
    scan = receive(laser);
    left_obj = min(scan.Ranges(280:360));
    right_obj = min(scan.Ranges(360:440));
    
     % If the robot run too fast. emergency avoidence
    if left_obj <= 0.5
        velmsg.Linear.X=0.2;
        velmsg.Angular.Z = -0.4;
    end
    if right_obj <= 0.5
        velmsg.Linear.X=0.2;
        velmsg.Angular.Z = 0.4;
    end
    
    odommessage=rosmessage(odom_subs);
    data_odom=receive(odom_subs);
    X(i)=data_odom.Pose.Pose.Position.X;
    Y(i)=data_odom.Pose.Pose.Position.Y; 
    
    % if the current distance of the destination is less than 1, quit
   if sqrt((X(i)-destination(1))^2 + (Y(i)-destination(2))^2) < 1
       break;
   end
    
 
    hchoose;
    
    send(robot,velmsg);
end



function h = lidar_transfer(laser)
%% lidar_transfer
scan = receive(laser);
m=scan.Ranges;
i=16;
disp("The robot is running at Lidar_transfer");
% VFH algorithm to transfer the lidar data
for k=1:45
    h(k)=sum(  m(  (1+i*(k-1)):i*k   )  );
    h(k)=160-h(k);
end
end

function [hm,avoid_po] = smoothing(h)
%l=1;
h_=h;
% smooth the 5 data
for k=3:43
    h(k)=(h_(k-2)+h_(k-1)+2*h_(k)+h_(k+1)+h_(k+2))/5;
end
avoid_po=zeros(1,45);
for i=1:45
    avoid_po(i)=160-h(k);
end
hm=h;
end

function possibleSector = obstacle_avoid(hm)
b=zeros(1,45);
impossibleSector=find(hm>120);
% consider the range of the robot, we need to less the range 
b(impossibleSector)=1;
b1=impossibleSector+1;
b2=impossibleSector-1;
b3=impossibleSector+2;
b4=impossibleSector-2;
b5=impossibleSector+3;
b6=impossibleSector-3;
b7=impossibleSector+4;
b8=impossibleSector-4;
b(min(b1,45))=1;
b(max(b2,1))=1;
b(min(b3,45))=1;
b(max(b4,1))=1;
b(min(b5,45))=1;
b(max(b6,1))=1;
b(min(b7,45))=1;
b(max(b8,1))=1;

possibleSector=find(b==0);
lengthp=length(possibleSector);
% consider the volume of robot, need enough space
if lengthp<3    
   hm1=hm;
   hm1(hm1<=120)=160;
   for l=1:3-lengthp
   minSector=min(hm1); 
   possible=find(hm==minSector);
   hm1(possible)=160;
   possibleSector(lengthp+l)=possible;
   end
end

end

function heading_po = heading()
%heading 
% the 46 replace the direction of the robot then I use it to choose the
% velocity
heading1=linspace(2,46,23);
heading2=linspace(44,2,22);
heading_po=[heading1 heading2];
end

function[mark]=path(destination,i)
all_possiblesector=[45:-1:1];
odom_subs=rossubscriber('/odom');
odommessage=rosmessage(odom_subs);
data_odom=receive(odom_subs);
X(i)=data_odom.Pose.Pose.Position.X;
Y(i)=data_odom.Pose.Pose.Position.Y;
a(i)=data_odom.Pose.Pose.Orientation.W;
d(i)=data_odom.Pose.Pose.Orientation.Z;
theta(i,:)=quat2eul([a(i),0,0,d(i)]);

% angle transfer
degree=atan((destination(2)-Y(i))/(destination(1)-X(i)))*180/pi;
countsector=((all_possiblesector.*270/45)-135-270/45/2);
degreesector=theta(i,1)*180/pi+countsector;
degreesector(degreesector<-180)=degreesector(degreesector<-180)+360;
degreesector(degreesector>180)=degreesector(degreesector>180)-360;
final=abs(degreesector-degree);
final(final>180)=360-final(final>180);
marks=sum(final);
g=length(all_possiblesector);
% mark all the possible direction
for k=1:g
mark(k)=(2000*(marks-final(k))/marks)-1900;
end
mark=(mark/max(mark)).*100;
end

function hchoose=choose(heading_po,path_po,avoid_po,possibleSector,hm)

    
a=6;
b=1;
c=5;
l=length(hm);
% there are three factors  and we get the final max valve from the three
% factors

for i=1:l
    choice(i)=a*avoid_po(i)+b*heading_po(i)+c*path_po(i);
end

hpossibleSector=choice(possibleSector);
hmax=max(hpossibleSector);
hchoose=find(choice==hmax);
% hchoose=possibleSector(hitem);
end

function [v,w]=speed(hchoose,hm)
% h_current=hm(23);
% h_min=2;
% vmax=0.4;
% wmax=0.4;
% hc= min(h_current,h_min);
% vmin=0.2;
% v=vmax*(1-hc/h_min)+vmin;
% w=wmax*abs(23-hchoose)/22;

% according the histogram to get the speed.
v=max(min(0.3*(23-abs(23-hchoose)),0.6),-0.6)
w=max(min(0.1*(23-hchoose),0.5),-0.5)
end

