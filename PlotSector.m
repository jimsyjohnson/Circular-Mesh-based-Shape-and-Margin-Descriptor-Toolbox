function [sectorcord]  = PlotSector(sectors,nim,yy1,xx1,tracks,rt,xx,yy,num1,R_x,R_y)
        
for aa=1:size(nim,1)
    for bb=1:size(nim,2)
        if(nim(aa,bb)==1) 
             XX = [ yy1 xx1;bb aa];
             ds(num1) = pdist(XX,'euclidean');
             dx1(num1)=aa;
             dx2(num1)=bb;
             flag=0;
       for nt=1:tracks
        if(ds(num1)<rt(1))
            trackn(num1)=1;
            flag=1;
            break;
        end
        if(nt~=tracks && ds(num1)>rt(nt)&&ds(num1)<rt(nt+1))
            trackn(num1)=nt+1;
            flag=1;
            break;
        end
        if(flag==0)
            trackn(num1)=10;
        end  
       end
       num1=num1+1;
        end   
    end
end
A=[xx,xx+rt(tracks)];
B=[yy,yy];
angl=360/sectors;
%plot sector
for i=1:sectors
sectorcord(i,1)=R_x+(rt(tracks)*sind(angl*i));
sectorcord(i,2)=R_y+(rt(tracks)*cosd(angl*i));
end 
for i = 1:sectors
 line([R_x,sectorcord(i,1)],[R_y,sectorcord(i,2)],'Color','b');
end
end

