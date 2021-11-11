function [xx,yy,rt,sectorcord] = CmGen(tracks,radius,nim,R_x,R_y,sectors,yy1,xx1,num1)
[xx,yy,rt] = DrawTracks(tracks,radius,nim,R_x,R_y); % draw track
[sectorcord]  = PlotSector(sectors,nim,yy1,xx1,tracks,rt,xx,yy,num1,R_x,R_y); % draw sectors
end

