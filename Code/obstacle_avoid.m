
function possibleSector = obstacle_avoid(hm)
b=zeros(1,45);
impossibleSector=find(hm>120);
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