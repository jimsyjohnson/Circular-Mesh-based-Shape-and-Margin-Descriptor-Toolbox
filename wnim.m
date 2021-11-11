


function [r,r1,mx,xm1,ym1,xm2,ym2,R_x,R_y] = wnim(nim,b)
%Finding the white pixels of rotated image
w =1;

 for i = 1:size(nim,1)
        for j = 1:size(nim,2)
            if(nim(i,j)==1) 
               
                r(w,1) =i;
                r(w,2) = j;
                                
                w = w+1;
                b = b+1;

            end
            
        end
 end
      c = 1;
   [m,n] = size(r);   
    p=1;
    a = 1;
    
    mx = 0;
  for p = 1:m
     x1=r(p,1);
     y1= r(p,2);
  
     for i =1:m
        x2 = r(i,1);
        y2 = r(i,2);
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
     end
     exist r1;
       if(ans == 1)
     
        c = 1;
        a = a+1;
   
       end
  end
  
  
  diameter = mx;
 radius = diameter/2;
 % checking for greater radius
 
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 %plot(xm,ym,'r*','MarkerSize',25)
  %plot(ym1,xm1,'b*','MarkerSize',1);
  hold on;
  %plot(ym2,xm2,'b*','MarkerSize',1);
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 
for i =1:m
    
     x1=R_x;
     y1= R_y;
        
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>radius)
                radius=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
end
 
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 %plot(xm,ym,'r*','MarkerSize',25)
  %plot(ym1,xm1,'b*','MarkerSize',1);
  hold on;
 % plot(ym2,xm2,'b*','MarkerSize',1);
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 
 
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 %plot(xm,ym,'r*','MarkerSize',25)
  %plot(ym1,xm1,'b*','MarkerSize',1);
  hold on;
  %plot(ym2,xm2,'b*','MarkerSize',1);
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 plot(R_x,R_y,'r*','MarkerSize',25) % centre of tracks
  
  
  
end

