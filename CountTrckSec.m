
%%% Counting the number of Tracks and Sectors

function [TrkVar,TrkOcc,SecVar,SecOcc,Trkin,Secin,PeakValley,NormalizedValue,indices,cxxN,cyyN] = CountTrckSec(Trk,sec,cxx,cyy)




Trkin = Trk';
 Secin = sec';
 
 
 PeakValley(:,1)  = Trkin;
   PeakValley(:,2)  = Secin;
 cxx(2,:) = Trk(1,:);
 cyy(2,:) = sec(1,:);
 
   %%% Normalization 
   
   
   mf = 15 ; %%% Multiplication factor = 5
   c = 1;
   for i = 1:size(cxx,2)
       if(c<size(cxx,2)/mf)
           M = mf *i;
         cxxN(:,c) = cxx(:,M);
         cyyN(:,c) = cyy(:,M);
       c=c+1;
         
       end
   end
   
   
   
   
   
   mf = 15 ; %%% Multiplication factor = 5
   c = 1;
   for i = 1:size(Trkin)
         if(c < size(Trkin,1)/mf)
          
             M =  mf *i ;
             NormalizedValue(c,:) =  PeakValley(M,:)  ;
             indices(c,:) =M;
             c= c+1;
     
    
        end
       
   end
   cxxN = cxxN';
   cyyN = cyyN';
 
 k = 1; j = 1;
 
  for i = 1:size(NormalizedValue,1)-1
      
    TrkVar(j) = NormalizedValue(i,1);
     if(NormalizedValue(i,1) ==NormalizedValue(i+1,1))
         k = k+1;
         TrkVar(j,2) = k;
         
     else
         %TrkVar(j,2) = k;
         k=1;
         j = j+1;
         TrkVar(j,1) = NormalizedValue(i+1,1);
         TrkVar(j,2) = k;
         %k = k+1;
     end
       
 
  end
  
  TrkOcc = TrkVar(:,2);
  
     
   
   




% % %  k = 1; j = 1;
% % %   for i = 1:size(Trk,2)-1
% % %       
% % %     TrkVar(j) = Trk(i);
% % %      if(Trk(i) ==Trk(i+1))
% % %          k = k+1;
% % %          TrkVar(j,2) = k;
% % %          
% % %      else
% % %          %TrkVar(j,2) = k;
% % %          k=1;
% % %          j = j+1;
% % %          TrkVar(j,1) = Trk(i+1);
% % %          TrkVar(j,2) = k;
% % %          %k = k+1;
% % %      end
% % %        
% % %  
% % %   end
% % %   
% % %   TrkOcc = TrkVar(:,2);
  
  
  
  
  
  %%% Counting Sector Values
  
  
   SecVar =[];
           
       k = 1; j=1;
  for i = 1:size(NormalizedValue,1)-1
      
   SecVar(j,1) = NormalizedValue(i,2);
   if(NormalizedValue(i,2)==NormalizedValue(i+1,2))
       k=k+1
       SecVar(j,2) = k;
      
   else
       k=1;
       j = j+1;
       SecVar(j,1) = NormalizedValue(i,2);
       SecVar(j,2) = k;
   end
 SecOcc = SecVar(:,2); 
 
 
  end

