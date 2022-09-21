function [v,w]=speed(hchoose,hm)
% h_current=hm(23);
% h_min=2;
% vmax=0.4;
% wmax=0.4;
% hc= min(h_current,h_min);
% vmin=0.2;
% v=vmax*(1-hc/h_min)+vmin;
% w=wmax*abs(23-hchoose)/22;
v=max(min(0.3*(23-abs(23-hchoose)),0.6),-0.6)
w=max(min(0.1*(23-hchoose),0.5),-0.5)
end