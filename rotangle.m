function [nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw)
%% Calculating the angle between line1 and line2 (angle for rotation)
    % line1 = (R_x,R_y) to (ym2,R_y)
    % line2 = (R_x,R_y) to (ym2,xm2)
            v1 = [ym2,R_y]-[R_x,R_y];
            v2 = [R_x,R_y]-[ym2,xm2];
     op = R_y-xm2;
     ad = ym2-R_x;
     tantheta = op/ad;
     theta = atand(tantheta);
     vc = cross([v1,0], [v2,0]);
     aclock = vc(3) > 0;
     % nim = rotated image with theta angle
        if(aclock)
          nim=imrotate(bw,-theta);                                                                                                                                                                                                                                                                                                                                       
        else
          nim=imrotate(bw,-theta);
        end

[m,n] = size(nim);

end




