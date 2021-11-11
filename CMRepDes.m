function [Trk,sec,secangle] = CMRepDes(cxx,cyy,R_x,R_y,rt,sectors)    
% LABELLING OF CIRCULAR MESH AND BORDER %%%%
%finding eucledian distance from centre to all boundary points.    
 for i =1:size(cxx,2)
       % Calculating the Eucledian Distance from the centre to each boundary pixel
        DP = [R_x R_y;cxx(1,i) cyy(1,i)];
         bp(i) = pdist(DP,'euclidean');
 end 
          %%% Checking for in which track the given boundary point lie     
          % bp = boundary points, rt = radius of tracks
            for j = 1:size(bp,2)
                for k = 1:size(rt,1)
                     if(bp(j)<=rt(k))
                         Trk(j) = k;
                         break;
                     else
                         Trk(j) = size(rt,1);
                     end
                end
            end 
% finding angles for getting sectors   
    % ANGLE BETWEEN 90 AND 180
b=1;
for i = 1:size(cxx,2)
    if(cxx(1,i)<R_x && cyy(1,i) > R_y )
       v1 = [R_x,R_y]-[cxx(1,i),R_y];
       v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
       clamp = @(val, low, high) min(max(val,low), high);
       angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));
       angle = 90- rad2deg(angle); 
       secangle(b) =angle+90;
       b=b+1;      
            
    elseif(cxx(1,i)==R_x &&cyy(1,i)>R_y)
         v1 = [R_x,R_y]-[cxx(1,i),R_y];
       v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
       clamp = @(val, low, high) min(max(val,low), high);
       angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));
       angle = rad2deg(angle); 
       secangle(b) =angle-90;
       b=b+1;       
       % ANGLE BETWEEN 0 AND 90
    elseif (cxx(1,i)>=R_x && cyy(1,i)>=R_y)
        v1 = [R_x,R_y]-[cxx(1,i),R_y];
        v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
        clamp = @(val, low, high) min(max(val,low), high);
        angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));
        angle =  rad2deg(angle); 
        secangle(b) =angle;
        b=b+1; 
       % ANGLE BETWEEN 270 AND 360
     elseif (cxx(1,i)>R_x &&cyy(1,i)<R_y)
         v1 = [R_x,R_y]-[cxx(1,i),R_y];
         v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
         clamp = @(val, low, high) min(max(val,low), high);
         angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));            
         angle = 90- rad2deg(angle); 
         secangle(b) =angle+270;       
         b=b+1;                
  elseif (cxx(1,i)>R_x && cyy(1,i)== R_y)
         v1 = [R_x,R_y]-[cxx(1,i),R_y];
         v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
         clamp = @(val, low, high) min(max(val,low), high);
         angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));         
         angle =  rad2deg(angle); 
         secangle(b) =angle+360; 
          b=b+1;                
         % ANGLE BERTWEEN 180 AND 270         
     elseif (cxx(1,i)<R_x && cyy(1,i)<=R_y)
         v1 = [R_x,R_y]-[cxx(1,i),R_y];
         v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
         clamp = @(val, low, high) min(max(val,low), high);
         angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));            
         angle = rad2deg(angle);
         secangle(b) =angle+180;
         b=b+1;
    elseif(cxx(1,i)==R_x && cyy(1,i)<=R_y)
        v1 = [R_x,R_y]-[cxx(1,i),R_y];
         v2 = [R_x,R_y]-[cxx(1,i),cyy(1,i)];
         clamp = @(val, low, high) min(max(val,low), high);
         angle = acos( clamp(dot(v1,v2) / norm(v1) / norm(v2), -1, 1));            
         angle = rad2deg(angle);
         secangle(b) =angle+90;
         b=b+1;
     end
end
sec = [];
theta = 360/sectors;
m = 1;
for i = 1:sectors
    sa(:,i) = m*theta;
    m=m+1;
end
% sa =  angle of each sector
%secangle = angle of each boundary points
for i = 1:size(secangle,2)
    for j= 1:size(sa,2)
        if(secangle(i)<=sa(j))
            sec(i) =j;
            break
        end
    end
end
end

