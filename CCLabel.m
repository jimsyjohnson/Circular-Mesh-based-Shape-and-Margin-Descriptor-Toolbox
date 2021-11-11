function [cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y)
v1=[xx yy]-[ sectorcord(1,1) sectorcord(1,2)];
v2=[xx yy]-[xx+mx yy];
%clamp = @(val, low, high) min(max(val,low), high);
angle = mod(atan2( det([v1;v2]) , dot(v1,v2) ), 2*pi );
%angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));
angle=rad2deg(angle);
sang=0;
for sc=1:sectors
    sang=sang+angle;
    sctang(sc)=sang;
end
nm1 = 1;
for ii=1:size(nim,1)
    for jj=1:size(nim,2)
        if(nim(ii,jj)==1) 
            cy2(nm1)=jj;
            cx1(nm1)=ii;
            nm1=nm1+1;
        end   
    end
end
%%% Sorting the boundary pixel points based on the increasing x value.
[cx,I] = sort(cy2,'descend');
    for j = 1:size(I,2)
       cy(j) = cx1(I(j));
    end
    v=1;w=1;
    cyr = [];
    for i =1:size(cy,2)
        if(cy(i)> R_y)
            cyy(v) = cy(i);
            cxx(v) = cx(i);
            v=v+1;
        else
            cyr(w) = cy(i);
            cxr(w) = cx(i);            
            w=w+1;
        end
    end
  TF = isempty(cyr);
  if(TF ==0)
    cyr = flip(cyr);  
    cxr = flip(cxr);  
   cxx = [cxx,cxr]; 
   cyy = [cyy,cyr];
  end
end

