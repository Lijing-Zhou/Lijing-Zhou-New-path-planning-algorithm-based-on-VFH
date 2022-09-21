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
% odom_subs = rossubscriber('/odom');
%laser = rossubscriber('/front/scan');
 l=0;
 r=0;  
while 1
camera = rossubscriber('/kinect2/qhd/image_color/');
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
% imshow(rgb);

% R(find((R<250 & G>10) & B>10))=255;
% G(find((R<250 & G>10) & B>10))=255;
% B(find((R<250 & G>10) & B>10))=255;

rfigure= (RGB(:,:,2)<130 | RGB(:,:,2)>158 )| (RGB(:,:,1)<60 | RGB(:,:,1)>80) | (RGB(:,:,3)<100  | RGB(:,:,3)>121)  ;
R(rfigure)=255;
G(rfigure)=255;
B(rfigure)=255;
RGB2(:,:,1)=R;
RGB2(:,:,2)=G;
RGB2(:,:,3)=B;
rgb2=uint8(RGB2);
% 
imshow(rgb2);
GRAY = rgb2gray(RGB2);
% figure,
% imshow(GRAY),
% title('Gray Image');


threshold = graythresh(GRAY);
BW = im2bw(GRAY, threshold);
% figure,
% imshow(BW),
% title('Binary Image');


BW = ~ BW;
% figure,
% imshow(BW),
% title('Inverted Binary Image');


[V,L] = bwboundaries(BW, 'noholes');


STATS = regionprops(L, 'all'); 


% figure,
% imshow(RGB),
% title('Results');
hold on
for i = 1 : length(STATS)
     v(i)=STATS(i).ConvexArea/(STATS(i).Area/STATS(i).Extent);
%     v(i)=(STATS(i).Extent);
  v(i)=com(v(i));
  centroid = STATS(i).Centroid;
  switch v(i)
      case 0.7854
           if v(i)*STATS(i).Area>150
               plot(centroid(1),centroid(2),'wO');
         
          l=l+v(i)*STATS(i).Area;
          end
      case 0.5
          plot(centroid(1),centroid(2),'wX');
      case 1
         if v(i)*STATS(i).Area>150
             plot(centroid(1),centroid(2),'wS');
         
          r=r+v(i)*STATS(i).Area;
          end
  end
end
if l>r
    fprintf('It is a circle, turn left.\n')
     velmsg.Linear.X=0.5;
 velmsg.Angular.Z=0.25;
elseif l<r
    fprintf('It is a square, turn right.\n')
    velmsg.Linear.X=0.5;
 velmsg.Angular.Z=-0.25;
else
     velmsg.Linear.X=0.5;
 velmsg.Angular.Z=0;
end
l=0;
r=0;
  send(robot,velmsg);
end
hold on