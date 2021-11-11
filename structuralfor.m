function [RatioCirPerObjPer] = structuralfor(peri,AR,cxx,cyy,R_x,R_y)


%STRUCTURAL FORMULAE

%   Feature values can be derived using the circular mesh characteristics
%   and structural formulae

%%% Ratio of the circumference of the circle to the perimeter of the object
CirPer = 2*(sqrt((3.14 * AR)));

ObjPer = peri;
RatioCirPerObjPer = CirPer/ObjPer; 

%%%% Ratio of the circumference of the circle formed in the nearest border
%%%% to the object perimeter.


%%% rper is the circumference of the circle falls in the nearest border
%%% point from the orgin 
c=1;
for i = 1 :size(cxx,2)
in = inpolygon(cxx(i),cyy(i),R_x,R_y);
if(in==1)
              Radius = [cxx(i),cyy(i);R_x,R_y]; 
              radius(c) =pdist(Radius);
              c=c+1;
end
end
%%%%%%%%%%%%RatioCirNearBorObjPer = rPer/PerBorder;

end

