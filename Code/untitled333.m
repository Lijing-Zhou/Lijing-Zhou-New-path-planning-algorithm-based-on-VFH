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
 lg=0;
 lr=0
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

rfigure=(((RGB(:,:,2)>130 & RGB(:,:,2)<158 )& (RGB(:,:,1)>60 & RGB(:,:,1)<80) & (RGB(:,:,3)>100  & RGB(:,:,3)<121)) | ((RGB(:,:,1)>90 & RGB(:,:,1)<200 )& (RGB(:,:,2)>10 & RGB(:,:,2)<35) & (RGB(:,:,3)>10  & RGB(:,:,3)<35)))  ;
rfigure2=~rfigure;
R(rfigure2)=255;
G(rfigure2)=255;
B(rfigure2)=255;
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
           if v(i)*STATS(i).Area>150 && ((RGB(round(centroid(2)),round(centroid(1)),2)>130 && RGB(round(centroid(2)),round(centroid(1)),2)<158 )&& (RGB(round(centroid(2)),round(centroid(1)),1)>60 && RGB(round(centroid(2)),round(centroid(1)),1)<80) && (RGB(round(centroid(2)),round(centroid(1)),3)>100  && RGB(round(centroid(2)),round(centroid(1)),3)<121))
               plot(centroid(1),centroid(2),'kO');
         
          lg=lg+v(i)*STATS(i).Area;
           elseif v(i)*STATS(i).Area>150 && ((RGB(round(centroid(2)),round(centroid(1)),2)>10 && RGB(round(centroid(2)),round(centroid(1)),2)<35 )&& (RGB(round(centroid(2)),round(centroid(1)),1)>90 && RGB(round(centroid(2)),round(centroid(1)),1)<200) && (RGB(round(centroid(2)),round(centroid(1)),3)>10  && RGB(round(centroid(2)),round(centroid(1)),3)<35))
               plot(centroid(1),centroid(2),'wO');
               lr=lr+v(i)*STATS(i).Area;
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
if lg>lr 
    fprintf('It is a green circle, turn left.\n')
     velmsg.Linear.X=0.3;
 velmsg.Angular.Z=0.3;
elseif lg<lr
    fprintf('It is a red circle, turn right.\n')
    velmsg.Linear.X=0.3;
 velmsg.Angular.Z=-0.3;
else
     velmsg.Linear.X=0.5;
 velmsg.Angular.Z=0;
end
lg=0;
lr=0;
  send(robot,velmsg);
end
hold on