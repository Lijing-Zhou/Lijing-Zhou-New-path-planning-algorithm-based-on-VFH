%Lijing Zhou
%T02145121
function hchoose=choose(heading_po,path_po,avoid_po,possibleSector,hm)

a=6;
b=1;
c=5;
l=length(hm);
for i=1:l
    choice(i)=a*avoid_po(i)+b*heading_po(i)+c*path_po(i);
end

hpossibleSector=choice(possibleSector);
hmax=max(hpossibleSector);
hchoose=find(choice==hmax);
% hchoose=possibleSector(hitem);
end