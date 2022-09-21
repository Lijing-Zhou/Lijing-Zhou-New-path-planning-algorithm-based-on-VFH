%function[xvalue yvalue]=hsvdetect()
%ends ros if it is already running
rosshutdown;
%if you are working with a VM, please put its ipaddress here
 ipaddress='localhost'
%connects with the ROS_Master
rosinit(ipaddress);
robot = rospublisher('/cmd_vel');
velmsg = rosmessage(robot);
odom_subs = rossubscriber('/jackal_velocity_controller/odom');
laser = rossubscriber('/front/scan');

for n=1:3
%zhao qiu
while 1
%     disp("zhao qiu")
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);

t=receive(camera);
velmsg.Linear.X=0;
velmsg.Angular.Z = 0.2;
send(robot,velmsg);
s=[]; 
centroid=[0 0];
cent=[0 0];

m=0;
R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
%  imshow(H);
H1=H;
S1=S;
V1=V;
% 
% area=(H>0.54 & H<0.64)&(S>0.5 &S<0.9);
area=(H>0.96 & H<1)&(S>0.4 &S<1);%red
H(area)=1;
H(~area)=0;
% H(1:340,:)=1;
b=imfill(H,'holes');
i=~b;
% b=b(340:540,:);
% ball=im2bw(H,0.3);

imshow(i);
hold on
[V,L] = bwboundaries(b, 'noholes');
STATS = regionprops(L, 'all'); 
[a z]=size(STATS);
for i = 1 : a
%      v(i)=STATS(i).ConvexArea/(STATS(i).Area/STATS(i).Extent);
    v(i)=(STATS(i).Extent);
%     v(i)=(STATS(i).Solidity);
  
    are(i)=com(v(i));
  centroid(i,:) = STATS(i).Centroid;
   
    switch are(i)
%       case 0.7854
        case 1
 if STATS(i).Area>400 
     
               plot(centroid(i,1),centroid(i,2),'rO');
               
         m=m+1;
         s(m)=STATS(i).Area;
         cent(m,:)=centroid(i,:);
         di=find(s==max(s));
         

 end
   
    end

end
% sum(sum(b(300:450,350:550)))+sum(sum(b(451:540,200:800)))
if  m~=0
if cent(di,1)<530 && cent(di,1)>385
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break
end


end
 

end
%% jian qiu
while 1
    disp("jianqiu")
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);

t=receive(camera);
velmsg.Linear.X=0.3;
velmsg.Angular.Z = -0.03;
send(robot,velmsg);


% qu 3 ge
R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';

RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;

rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
%  imshow(H);

%
% area=(H>0.57 & H<0.62)&(S>0.4 &S<0.8);
area=(H>0.96 & H<1)&(S>0.4 &S<1);
% area=(H>0.96 & H<1)&(S>0.4 &S<1);
H(area)=1;
H(~area)=0;
b=imfill(H,'holes');
i=~b;

% ball=im2bw(H,0.3);
imshow(i);
hold on
sum(sum(b(300:450,320:580)))+sum(sum(b(451:540,200:800)))
% the ball dispar
if sum(sum(b(300:450,320:580)))+sum(sum(b(451:540,200:800)))<300
    velmsg.Linear.X=0;
velmsg.Angular.Z = 0;
send(robot,velmsg);


% tic;
% while toc<0.1
% velmsg.Linear.X=0.3;
% velmsg.Angular.Z = -0.03;
% send(robot,velmsg);
% end

    break
end

end

% zhao qiang
while 1
    disp("zhaoqiang")
   camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);

t=receive(camera);
velmsg.Linear.X=0;
velmsg.Angular.Z = 0.2;
send(robot,velmsg);
s=[]; 
centroid=[0 0];
cent=[0 0];
m=0;


R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);


area=(H>0.52 & H<0.6)&(S>0.7 &S<0.9);
H(area)=1;
H(~area)=0;
% H(340:540,:)=1;

b=imfill(H,'holes');
i=~b;
ball=im2bw(H,0.3);
imshow(i);
hold on

[V,L] = bwboundaries(b, 'noholes');
STATS = regionprops(L, 'all'); 
[a b]=size(STATS);
for i = 1 : a
%      v(i)=STATS(i).ConvexArea/(STATS(i).Area/STATS(i).Extent);
    v(i)=(STATS(i).Solidity);
  v(i)=com(v(i));
  
  
  centroid(i,:) = STATS(i).Centroid;
   
    switch v(i)
      case 1
 if STATS(i).Area>5000 
     
               plot(centroid(i,1),centroid(i,2),'rS');
               
         m=m+1;
         s(m)=STATS(i).Area;
         cent(m,:)=centroid(i,:);
         di=find(s==max(s));
         

 end
   
    end

end
if  m~=0
if cent(di,1)<530 && cent(di,1)>405
    velmsg.Angular.Z = 0;
    
    send(robot,velmsg);
    break
end
end
end

% dao qiang
while 1
    disp("dao qiang")
  
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);
 scan=receive(laser,3);
t=receive(camera);
R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
area=(H>0.52 & H<0.6)&(S>0.7 &S<0.9);
H(area)=1;
H(~area)=0;
% H(340:540,:)=1;

b=imfill(H,'holes');
i=~b;
ball=im2bw(H,0.3);
imshow(i);
hold on
velmsg.Linear.X=0.3;
velmsg.Angular.Z = -0.03;
sum(sum(b(:,1:30)))
send(robot,velmsg);
if sum(sum(b(:,1:70)))>1000 && min(scan.Ranges(480:600))<0.9
d=0;
    velmsg.Linear.X=0;
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break

elseif min(scan.Ranges(450:540))<0.45 && sum(sum(b(:,1:70)))<300
    tic
  while  toc<3

    velmsg.Linear.X=0.2;
    velmsg.Angular.Z = 0.4;
    d=1;
    send(robot,velmsg);
   
  end
  break
elseif min(scan.Ranges(540:630))<0.45 && sum(sum(b(:,1:70)))<300
    tic
  while  toc<3

    velmsg.Linear.X=0.2;
    velmsg.Angular.Z = -0.4;
    d=2;
    send(robot,velmsg);
  end
  break

end
end







while d
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);
 scan=receive(laser,3);
t=receive(camera);
if d==1
    disp("zuo daoqiang");
    velmsg.Linear.X=0;
velmsg.Angular.Z = -0.2;
% you obstacle
elseif d==2
    disp("you daoqiang");
    velmsg.Linear.X=0;
velmsg.Angular.Z = 0.2;
%zuo obstacle
end
 send(robot,velmsg);
s=[]; 
centroid=[0 0];
cent=[0 0];
m=0;
R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);


area=(H>0.52 & H<0.6)&(S>0.7 &S<0.9);
H(area)=1;
H(~area)=0;
% H(340:540,:)=1;

b=imfill(H,'holes');
i=~b;
ball=im2bw(H,0.3);
imshow(i);
hold on

[V,L] = bwboundaries(b, 'noholes');
STATS = regionprops(L, 'all'); 
[a b]=size(STATS);
for i = 1 : a
%      v(i)=STATS(i).ConvexArea/(STATS(i).Area/STATS(i).Extent);
    v(i)=(STATS(i).Solidity);
  v(i)=com(v(i));
  
  
  centroid(i,:) = STATS(i).Centroid;
   
    switch v(i)
      case 1
 if STATS(i).Area>5000 
     
               plot(centroid(i,1),centroid(i,2),'rS');
               
         m=m+1;
         s(m)=STATS(i).Area;
         cent(m,:)=centroid(i,:);
         di=find(s==max(s));
         

 end
   
    end

end
if  m~=0
if cent(di,1)<530 && cent(di,1)>405
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break
end


end

end

%zhangaiwu daoqiang
while d
    disp("zhangaiwu daoqiang");
    camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);
 scan=receive(laser,3);
t=receive(camera);
velmsg.Linear.X=0.5;
velmsg.Angular.Z = -0.03;

send(robot,velmsg);
if min(scan.Ranges(480:600))<1

    velmsg.Linear.X=0;
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break
end
end
tic
 while toc<2.5
     velmsg.Linear.X=-0.3;
    velmsg.Angular.Z = 0.2;
    send(robot,velmsg);
 end
d=0;
end

for n=1:3
%zhao qiu
while 1
%     disp("zhao qiu")
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);

t=receive(camera);
velmsg.Linear.X=0;
velmsg.Angular.Z = 0.2;
send(robot,velmsg);
s=[]; 
centroid=[0 0];
cent=[0 0];

m=0;
R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';
RGB(:,:,1)=R;
RGB(:,:,2)=G;

RGB(:,:,3)=B;
rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
%  imshow(H);
H1=H;
S1=S;
V1=V;
% 
area=(H>0.54 & H<0.64)&(S>0.5 &S<0.9);
% area=(H>0.96 & H<1)&(S>0.4 &S<1);%red
H(area)=1;
H(~area)=0;
% H(1:340,:)=1;
b=imfill(H,'holes');
i=~b;
% b=b(340:540,:);
% ball=im2bw(H,0.3);

imshow(i);
hold on
[V,L] = bwboundaries(b, 'noholes');
STATS = regionprops(L, 'all'); 
[a b]=size(STATS);
for i = 1 : a
%      v(i)=STATS(i).ConvexArea/(STATS(i).Area/STATS(i).Extent);
    v(i)=(STATS(i).Extent);
%     v(i)=(STATS(i).Solidity);
  
    are(i)=com(v(i));
  centroid(i,:) = STATS(i).Centroid;
   
    switch are(i)
      case 0.7854
%         case 1
 if STATS(i).Area>400 
     
               plot(centroid(i,1),centroid(i,2),'rO');
               
         m=m+1;
         s(m)=STATS(i).Area;
         cent(m,:)=centroid(i,:);
         di=find(s==max(s));
         

 end
   
    end

end
if  m~=0
if cent(di,1)<530 && cent(di,1)>405
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break
end


end
 
velmsg.Linear.X
velmsg.Angular.Z 
end
%% jian qiu

while 1
    disp("jianqiu")
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);

t=receive(camera);
velmsg.Linear.X=0.3;
velmsg.Angular.Z = -0.03;
send(robot,velmsg);


% qu 3 ge
R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';

RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;

rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);
%  imshow(H);

%
area=(H>0.57 & H<0.62)&(S>0.4 &S<0.8);
% area=(H>0.96 & H<1)&(S>0.4 &S<1);

H(area)=1;
H(~area)=0;
b=imfill(H,'holes');
i=~b;

% ball=im2bw(H,0.3);
imshow(i);
hold on
% the ball dispar
if sum(sum(b(300:450,320:580)))+sum(sum(b(451:540,200:800)))<200
    velmsg.Linear.X=0;
velmsg.Angular.Z = 0;
send(robot,velmsg);


tic;
while toc<0.4
velmsg.Linear.X=0.3;
velmsg.Angular.Z = -0.03;
send(robot,velmsg);
end

    break
end

end


% zhao qiang
while 1
    disp("zhaoqiang")
   camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);

t=receive(camera);
velmsg.Linear.X=0;
velmsg.Angular.Z = 0.2;
send(robot,velmsg);
s=[]; 
centroid=[0 0];
cent=[0 0];
m=0;


R=t.Data(3:3:end);
R=reshape(R,[960,540]);
R=R';
G=t.Data(2:3:end);
G=reshape(G,[960,540]);
G=G';
B=t.Data(1:3:end);
B=reshape(B,[960,540]);
B=B';
RGB(:,:,1)=R;
RGB(:,:,2)=G;
RGB(:,:,3)=B;
rgb=uint8(RGB);
HSV=rgb2hsv(rgb);
H=HSV(:,:,1);
S=HSV(:,:,2);
V=HSV(:,:,3);


area=(H>0.52 & H<0.6)&(S>0.7 &S<0.9);
H(area)=1;
H(~area)=0;
% H(340:540,:)=1;

b=imfill(H,'holes');
i=~b;
ball=im2bw(H,0.3);
imshow(i);
hold on

[V,L] = bwboundaries(b, 'noholes');
STATS = regionprops(L, 'all'); 
[a b]=size(STATS);
for i = 1 : a
     v(i)=STATS(i).ConvexArea/(STATS(i).Area/STATS(i).Extent);
    v(i)=(STATS(i).Solidity);
  v(i)=com(v(i));
  
  centroid(i,:) = STATS(i).Centroid;
   
    switch v(i)
      case 1
 if STATS(i).Area>5000 
     
               plot(centroid(i,1),centroid(i,2),'rS');
               
         m=m+1;
         s(m)=STATS(i).Area;
         cent(m,:)=centroid(i,:);
         di=find(s==max(s));
         

 end
   
    end

end
if  m~=0
if cent(di,1)<530 && cent(di,1)>400
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break
end


end
end

% dao qiang
while 1
    disp("dao qiang")
camera = rossubscriber('/kinect2/qhd/image_color/');
lasermsg=receive(laser);
 scan=receive(laser,3);
t=receive(camera);
velmsg.Linear.X=0.5;
velmsg.Angular.Z = -0.03;
send(robot,velmsg);

if min(scan.Ranges(480:600))<1

    velmsg.Linear.X=0;
    velmsg.Angular.Z = 0;
    send(robot,velmsg);
    break
end
end
% hou tui
tic
 while toc<2.5
     velmsg.Linear.X=-0.3;
    velmsg.Angular.Z = 0.2;
    send(robot,velmsg);
 end
end