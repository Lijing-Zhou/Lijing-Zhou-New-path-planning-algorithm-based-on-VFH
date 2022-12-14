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
degree=atan((destination(2)-Y(i))/(destination(1)-X(i)))*180/pi;
countsector=((all_possiblesector.*270/45)-135-270/45/2);
degreesector=theta(i,1)*180/pi+countsector;
degreesector(degreesector<-180)=degreesector(degreesector<-180)+360;
degreesector(degreesector>180)=degreesector(degreesector>180)-360;
final=abs(degreesector-degree);
final(final>180)=360-final(final>180);
marks=sum(final);
g=length(all_possiblesector);
for k=1:g
mark(k)=(2000*(marks-final(k))/marks)-1900;
end
mark=(mark/max(mark)).*100;
end