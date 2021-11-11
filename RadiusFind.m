function [r,R_x,R_y,ym2,xm2] = RadiusFind(boundextra_img)
%% find number of ones in binary image
w = 1;[m,n] = size(boundextra_img);b = 0;
      for i = 1:m
        for j = 1:n
            if(boundextra_img(i,j)==1) 
                % boundary values are saved in variable r(i,j)
                r(w,1) =i;
                r(w,2) = j;
                w = w+1;  
                b = b+1;
            end            
        end
      end
         c = 1;
    [m] = size(r,1);   
    a = 1;
    mx = 0;
      for p = 1:m
        x1=r(p,1);
        y1= r(p,2);  
            for i =1:m
                x2 = r(i,1);
                y2 =r(i,2);
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
            else
            end
      end        
 diameter = mx;
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
end

