function [xx,yy,rt,sectorcord] = CmGen(track,radius,nim,R_x,R_y,sector,yy1,xx1,num1)
[xx,yy,rt] = DrawTracks(track,radius,nim,R_x,R_y); % draw track
[sectorcord]  = PlotSector(sector,nim,yy1,xx1,track,rt,xx,yy,num1,R_x,R_y); % draw sectors
end

