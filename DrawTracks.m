function [xx,yy,rt] = DrawTracks(tracks,radius,nim,R_x,R_y)
        
  %Drawing Tracks
centers = [R_x,R_y];
hold on;
axis on;
hold on;
nm1=1;
[l11,l22]=size(nim);
s = regionprops(nim,'centroid');
xx=round(s(1).Centroid(1));
yy=round(s(1).Centroid(2));
for ii=1:l11
    for jj=1:l22
        if(nim(ii,jj)==1) 
            cy2(nm1)=jj;
            cx1(nm1)=ii;
            nm1=nm1+1;
        end   
    end
end
pi=3.14;
area=pi*radius*radius;
Area_Ring=area/tracks; 
for i=1:tracks
rt(i)=(Area_Ring*i)/pi;
rt(i)=sqrt(rt(i));
rt = round(rt);
rt = rt'; % transpose
  viscircles(centers,rt(i));
end
end

