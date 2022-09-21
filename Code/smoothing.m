%Duan Ran
%T02145080
function [hm,avoid_po] = smoothing(h)
%l=1;
h_=h;
for k=3:43
    h(k)=(h_(k-2)+h_(k-1)+2*h_(k)+h_(k+1)+h_(k+2))/5;
end
avoid_po=zeros(1,45);
for i=1:45
    avoid_po(i)=160-h(k);
end
hm=h;
