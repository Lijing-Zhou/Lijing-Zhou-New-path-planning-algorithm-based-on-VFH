function []=jiavfhz(destposition)
robot = rospublisher('/cmd_vel');

odom_subs = rossubscriber('/jackal_velocity_controller/odom');

laser = rossubscriber('/front/scan');

velmsg = rosmessage(robot);

odom_msg = rosmessage(odom_subs);

laser_msg = rosmessage(laser);


forwardVelocity = 0;

angularVelocity = 0;

velmsg.Linear.X = forwardVelocity;

velmsg.Angular.Z=angularVelocity;

% data_odom = receive(odom_subs);
% 
% xs=data_odom.Pose.Pose.Position.X;
% 
% ys=data_odom.Pose.Pose.Position.Y;


%  the first circle
i=0;
tic;
t=toc;
while 1
    
        i=i+1;
        if toc-t>3
            time_load=time_load+3;
            toc
            break
        end
% for i=1:50

        data_odom(i)= receive(odom_subs);

        x1(i)=data_odom(i).Pose.Pose.Position.X;

        y1(i)=data_odom(i).Pose.Pose.Position.Y;

        W(i)=data_odom(i).Pose.Pose.Orientation.W; %choose the orientation of W

        Z(i)=data_odom(i).Pose.Pose.Orientation.Z; %choose the orientation of Z

        X(i)=data_odom(i).Pose.Pose.Orientation.X; %choose the orientation of X

        Y(i)=data_odom(i).Pose.Pose.Orientation.Y; %choose the orientation of Y

        c(i,:) = [W(i) X(i) Y(i) Z(i)];

        ang(i,:) = quat2eul(c(i,:));
        
        if i>2
            if ang(i,1)<0
                ang(i,1)=ang(i,1)+2*pi;
            end
        end
        
        slope(i) = atan2((destposition(2)-y1(i)),(destposition(1)-x1(i)));
        
        if slope(i)<0;
            slope(i)=slope(i)+pi*2;
        end
            
        theta(i)=ang(i,1)-slope(i);
      
  
         if sqrt((x1(i)-destposition(1))^2+(y1(i)-destposition(2))^2)>=0.4
             
           if abs(theta(i))<pi
           
               if abs(theta(i))<0.2
               
               velmsg.Angular.Z = 0;
               
               velmsg.Linear.X = 0.2;
               
               send(robot,velmsg);
           end
           
           if theta(i)<-0.2
               
               velmsg.Angular.Z = min(0.3*abs(theta(i)),0.3);
               
               velmsg.Linear.X = 0.2;
               
               send(robot,velmsg);
           end
           
           if theta(i)>0.2
               
               velmsg.Angular.Z = -min(0.3*abs(theta(i)),0.3);
               
               velmsg.Linear.X = 0.2;
               
               send(robot,velmsg);
           end
           
         end
         end
         
            if sqrt((x1(i)-destposition(1))^2+(y1(i)-destposition(2))^2)>=0.4
             
           if abs(theta(i))>pi
           
               if abs(theta(i))<0.2
               
               velmsg.Angular.Z = 0;
               
               velmsg.Linear.X = 0.2;
               
               send(robot,velmsg);
           end
           
           if theta(i)<-0.2
               
               velmsg.Angular.Z = -min(0.3*abs(theta(i)),0.3);
               
               velmsg.Linear.X = 0.2;
               
               send(robot,velmsg);
           end
           
           if theta(i)>0.2
               
               velmsg.Angular.Z = min(0.3*abs(theta(i)),0.3);
               
               velmsg.Linear.X = 0.2;
               
               send(robot,velmsg);
           end
           
         end
         end
         
         if sqrt((x1(i)-destposition(1))^2+(y1(i)-destposition(2))^2)<=0.4
             
             velmsg.Angular.Z = 0;
             
             velmsg.Linear.X = 0;
             
             send(robot,velmsg);
             
             break
             
         end
         send(robot,velmsg);
        theta(i);
       
end