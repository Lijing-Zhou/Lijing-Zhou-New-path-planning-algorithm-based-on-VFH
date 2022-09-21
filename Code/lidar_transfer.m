%Duan Ran
%T02145080
function h = lidar_transfer(laser)
%% lidar_transfer
scan = receive(laser);
m=scan.Ranges;
i=16;
disp("The robot is running at Lidar_transfer");
for k=1:45
    h(k)=sum(  m(  (1+i*(k-1)):i*k   )  );
    h(k)=160-h(k);
end