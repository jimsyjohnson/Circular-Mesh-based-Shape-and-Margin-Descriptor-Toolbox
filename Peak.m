function[NormalizedValueNew,NumSplo,AvgNumEleAtPeak] = Peak(TrkPt,NormalizedValue,SecPt,cxxN,cyyN)
% with Normalization
 %function [outputArg1,outputArg2] = Peak(inputArg1,inputArg2)
 %1st column is Track value
 % 2nd column Sector Value
% TPeak is 3rd column in NormalizedValue (If TPeak exist then 3rd column is 1)
% TValley is 4th column in Normalized Value ( If TValley exist then 1)
% swt is the the 5th column of NormalizedValue.
% TopPeak is the column7
% BottomValley in column9
% Cartesian Cordinates on 7th and 8th column (X cordinate on 7th and y on 8th) 
% NormalizedVAlueNew =
% [Track,Sector,TPeak,TValley,swt,TopPeak,BottomValley]
%% TPeak

tc = 1; i = 1;
   maxSTrkPt  = size(TrkPt,1);
    TLabel = [];
    lTrkPtindex = TrkPt(size(TrkPt,1),2);
    lTrkindex = size(NormalizedValue,1);
   if(i == 1)  % for first value in the Trk
          CTrack = NormalizedValue(i,1);
          CTrkindex = TrkPt(tc,2);
          if(i==CTrkindex)
              if(TrkPt(tc,1)> TrkPt(tc+1,1) && TrkPt(tc,1)>TrkPt(size(TrkPt,1)))
                  NormalizedValue(i,3) = 1;
                  TLabel(i,1) = 1;
                  tc=tc+1;
              else
                  NormalizedValue(i,3) = 0;
                   TLabel(i,1) = 0;
                  tc=tc+1;
              end
          else
              if(NormalizedValue(i,1)>NormalizedValue(i+1,1) && NormalizedValue(i,1)>NormalizedValue(size(NormalizedValue,1)))
                NormalizedValue(i,3) = 1;
                TLabel(i,1) = 1;
                
              else
                  NormalizedValue(i,3) = 0;
                  TLabel(i,1) = 0;
              end
          end
   end
   maxSTrkPt  = size(TrkPt,1);
         for i = 2: lTrkPtindex-1 
       
             CTrack = NormalizedValue(i,1);
             CTrkindex = TrkPt(tc,2);
          if(i==CTrkindex)
              if(tc<maxSTrkPt)
              if(TrkPt(tc,1)> TrkPt(tc+1,1) && TrkPt(tc,1)>TrkPt(tc-1,1))
                  NormalizedValue(i,3) = 1;
                  TLabel(i,1) = 1;
                  tc=tc+1;
              else
                  NormalizedValue(i,3) = 0;
                   TLabel(i,1) = 0;
                  tc=tc+1;
              end
          else
               if(NormalizedValue(i,1)>NormalizedValue(i+1,1) && NormalizedValue(i,1)>NormalizedValue(i-1,1))
                NormalizedValue(i,3) = 1;
                TLabel(i,1) = 1;
              else
                  NormalizedValue(i,3) = 0;
                  TLabel(i,1) = 0;
               end
              end
          end
             
             
       
         end         
   
         i = i+1;
%          for i =  lTrkPtindex : lTrkindex
%              
%          end
         
         
         
         
   if(i == lTrkPtindex )  % For last vcalue in the TrkPt                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
       CTrack = NormalizedValue(i,1);
          CTrkindex = TrkPt(tc,2);
          if(i==CTrkindex)
              if(TrkPt(tc,1)> TrkPt(1,1) && TrkPt(tc,1)>TrkPt(tc-1,1))
                  NormalizedValue(i,3) = 1;
                  TLabel(i,1) = 1;
                  tc=tc+1;
              else
                  NormalizedValue(i,3) = 0;
                   TLabel(i,1) = 0;
                  tc=tc+1;
              end
          else
               if(NormalizedValue(i,1)>NormalizedValue(1,1) && NormalizedValue(i,1)>NormalizedValue(i-1,1))
                NormalizedValue(i,3) = 1;
                TLabel(i,1) = 1;
              else
                  NormalizedValue(i,3) = 0;
                  TLabel(i,1) = 0;
              end
          end
   end
   
  for i = 1:size(NormalizedValue,1)
      
      if(NormalizedValue(i,3) == 1)
          for j = 1:size(TrkPt,1)
              if(TrkPt(j,2) == i)
                 counter = TrkPt(j,3);
                 for k = i:(i+counter)-1
                    NormalizedValue(k,3) = 1; 
                 end
              end
          end
        
      end
  end
   
   %% TValley
   
   tc = 1; i = 1;
   maxSTrkPt  = size(TrkPt,1);
    TLabel = [];
    lTrkPtindex = TrkPt(size(TrkPt,1),2);
    lTrkindex = size(NormalizedValue,1);
   if(i == 1)  % for first value in the Trk
          CTrack = NormalizedValue(i,1);
          CTrkindex = TrkPt(tc,2);
          if(i==CTrkindex)
              if(TrkPt(tc,1)< TrkPt(tc+1,1) && TrkPt(tc,1)<TrkPt(size(TrkPt,1)))
                  NormalizedValue(i,4) = 1;
                  %TLabel(i,1) = 1;
                  tc=tc+1;
              else
                  NormalizedValue(i,4) = 0;
                   %TLabel(i,1) = 0;
                  tc=tc+1;
              end
          else
              if(NormalizedValue(i,1)<NormalizedValue(i+1,1) && NormalizedValue(i,1)<NormalizedValue(size(NormalizedValue,1)))
                NormalizedValue(i,4) = 1;
                %TLabel(i,1) = 1;
                
              else
                  NormalizedValue(i,4) = 0;
                  %TLabel(i,1) = 0;
              end
          end
   end
   maxSTrkPt  = size(TrkPt,1);
         for i = 2: lTrkPtindex-1 
       
             CTrack = NormalizedValue(i,1);
             CTrkindex = TrkPt(tc,2);
          if(i==CTrkindex)
              if(tc<maxSTrkPt)
              if(TrkPt(tc,1)< TrkPt(tc+1,1) && TrkPt(tc,1)<TrkPt(tc-1,1))
                  NormalizedValue(i,4) = 1;
                  %TLabel(i,1) = 1;
                  tc=tc+1;
              else
                  NormalizedValue(i,4) = 0;
                   %TLabel(i,1) = 0;
                  tc=tc+1;
              end
          else
               if(NormalizedValue(i,1)<NormalizedValue(i+1,1) && NormalizedValue(i,1)<NormalizedValue(i-1,1))
                NormalizedValue(i,4) = 1;
                %TLabel(i,1) = 1;
              else
                  NormalizedValue(i,4) = 0;
                 % TLabel(i,1) = 0;
               end
              end
          end
             
             
       
         end         
   
         i = i+1;
%          for i =  lTrkPtindex : lTrkindex
%              
%          end
         
         
         
         
   if(i == lTrkPtindex )  % For last vcalue in the TrkPt                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
       CTrack = NormalizedValue(i,1);
          CTrkindex = TrkPt(tc,2);
          if(i==CTrkindex)
              if(TrkPt(tc,1)< TrkPt(1,1) && TrkPt(tc,1)<TrkPt(tc-1,1))
                  NormalizedValue(i,4) = 1;
                 % TLabel(i,1) = 1;
                  tc=tc+1;
              else
                  NormalizedValue(i,4) = 0;
                  % TLabel(i,1) = 0;
                  tc=tc+1;
              end
          else
               if(NormalizedValue(i,1)<NormalizedValue(1,1) && NormalizedValue(i,1)<NormalizedValue(i-1,1))
                NormalizedValue(i,4) = 1;
                %TLabel(i,1) = 1;
              else
                  NormalizedValue(i,4) = 0;
                  %TLabel(i,1) = 0;
              end
          end
   end
   
  for i = 1:size(NormalizedValue,1)
      
      if(NormalizedValue(i,4) == 1)
          for j = 1:size(TrkPt,1)
              if(TrkPt(j,2) == i)
                 counter = TrkPt(j,3);
                 for k = i:(i+counter)-1
                    NormalizedValue(k,4) = 1; 
                 end
              end
          end
        
      end
  end
  
   %% swt
   
   sc = 1; i = 1;
   maxSecPt  = size(SecPt,1);
    %TLabel = [];
    lSecPtindex = SecPt(size(SecPt,1),2);
    lSecindex = size(NormalizedValue,1);
   if(i == 1)  % for first value in the Trk
          CSec = NormalizedValue(i,2);
          CSecindex = SecPt(sc,2);
          if(i==CSecindex)
              if((SecPt(sc,1)> SecPt(sc+1,1) && SecPt(sc,1)>SecPt(size(SecPt,1)))||(SecPt(sc,1)< SecPt(sc+1,1) && SecPt(sc,1)<SecPt(size(SecPt,1))))
                  NormalizedValue(i,5) = 1;
                  %TLabel(i,1) = 1;
                  sc=sc+1;
              else
                  NormalizedValue(i,5) = 0;
                   %TLabel(i,1) = 0;
                  sc=sc+1;
              end
          else
              if((NormalizedValue(i,2)>NormalizedValue(i+1,2) && NormalizedValue(i,2)>NormalizedValue(size(NormalizedValue,2)))||(NormalizedValue(i,2)<NormalizedValue(i+1,2) && NormalizedValue(i,2)<NormalizedValue(size(NormalizedValue,2))))
                NormalizedValue(i,5) = 1;
                %TLabel(i,1) = 1;
                
              else
                  NormalizedValue(i,5) = 0;
                  %TLabel(i,1) = 0;
              end
          end
   end
   maxSecPt  = size(SecPt,1);
         for i = 2: lSecPtindex-1 
       
             CSec = NormalizedValue(i,2);
             CSecindex = SecPt(sc,2);
          if(i==CSecindex)
              if(sc<maxSecPt)
              if((SecPt(sc,1)> SecPt(sc+1,1) && SecPt(sc,1)>SecPt(sc-1,1))||(SecPt(sc,1)< SecPt(sc+1,1) && SecPt(sc,1)<SecPt(sc-1,1)))
                  NormalizedValue(i,5) = 1;
                  %TLabel(i,1) = 1;
                  sc=sc+1;
              else
                  NormalizedValue(i,5) = 0;
                   %TLabel(i,1) = 0;
                  sc=sc+1;
              end
          else
               if((NormalizedValue(i,2)>NormalizedValue(i+1,2) && NormalizedValue(i,2)>NormalizedValue(i-1,2))||(NormalizedValue(i,2)<NormalizedValue(i+1,2) && NormalizedValue(i,2)<NormalizedValue(i-1,2)))
                NormalizedValue(i,5) = 1;
                %TLabel(i,1) = 1;
              else
                  NormalizedValue(i,5) = 0;
                  %TLabel(i,1) = 0;
               end
              end
          end
             
             
       
         end         
   
         i = i+1;
%          for i =  lTrkPtindex : lTrkindex
%              
%          end
         
         
         
         
   if(i == lSecPtindex )  % For last vcalue in the TrkPt                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
       CSec = NormalizedValue(i,2);
          CSecindex = SecPt(sc,2);
          if(i==CSecindex)
              if((SecPt(sc,1)> SecPt(1,1) && SecPt(sc,1)>SecPt(sc-1,1))||(SecPt(sc,1)< SecPt(1,1) && SecPt(sc,1)<SecPt(sc-1,1)))
                  NormalizedValue(i,5) = 1;
                 % TLabel(i,1) = 1;
                  sc=sc+1;
              else
                  NormalizedValue(i,5) = 0;
                   %TLabel(i,1) = 0;
                  sc=sc+1;
              end
          else
               if((NormalizedValue(i,2)>NormalizedValue(1,2) && NormalizedValue(i,2)>NormalizedValue(i-1,2))||(NormalizedValue(i,2)<NormalizedValue(1,2) && NormalizedValue(i,2)<NormalizedValue(i-1,2)))
                NormalizedValue(i,5) = 1;
                %TLabel(i,1) = 1;
              else
                  NormalizedValue(i,5) = 0;
                  %TLabel(i,1) = 0;
              end
          end
   end
   
  for i = 1:size(NormalizedValue,1)
      
      if(NormalizedValue(i,5) == 1)
          for j = 1:size(SecPt,1)
              if(SecPt(j,2) == i)
                 counter = SecPt(j,3);
                 for k = i:(i+counter)-1
                    NormalizedValue(k,5) = 1; 
                 end
              end
          end
        
      end
  end
   
  
  %% TopPeak and Bottom Valley
  
  % TopPeak
  for i = 1:size(NormalizedValue,1)
      if(NormalizedValue(i,3)== 1 && NormalizedValue(i,5) == 1)
          NormalizedValue(i,6) =1;
      elseif(NormalizedValue(i,3)==1 && NormalizedValue(i,5) == 0)
          NormalizedValue(i,6) =1;
     
%       elseif(NormalizedValue(i,3)==0 && NormalizedValue(i,5)==1)
%           NormalizedValue(i,6)=1;
      else
          NormalizedValue(i,6) =0;
     
          
      end
          
  end
    j = 1;
  for i = 1:size(NormalizedValue,1)
      
    if(NormalizedValue(i,6) == 1)
        TopPeakindex(j,:) = i;
        j= j+1;
    end
    if(i<size(NormalizedValue,1))
    if(NormalizedValue(i,6) == 1 && NormalizedValue(i+1,6)==0)
       M = ceil(median(TopPeakindex));
       NormalizedValue(M,7) =1;
       clear('TopPeakindex');
       j=1;
    end
    elseif(i >= lTrkindex)
        if(NormalizedValue(i,6) == 1)
        TopPeakindex(j,:) = i;
        j= j+1;
        M = ceil(median(TopPeakindex));
        NormalizedValue(M,7) =1;
        end
    end   
   
  end
      
     
  % BottomValley
  
  
  for i = 1:size(NormalizedValue,1)
      if(NormalizedValue(i,4)== 1 && NormalizedValue(i,5) == 1)
          NormalizedValue(i,8) =1;
      elseif(NormalizedValue(i,4)==1 && NormalizedValue(i,5)==0)
          NormalizedValue(i,8) = 1;
%       elseif(NormalizedValue(i,4)==0 && NormalizedValue(i,5)==1)
%           
%           NormalizedValue(i,8)=1;
      else 
          NormalizedValue(i,8) =0;
      end
          
  end
    j = 1;
  for i = 1:size(NormalizedValue,1)
      
    if(NormalizedValue(i,8) == 1)
        BottomValleyindex(j,:) = i;
        j= j+1;
    end
    if(i<size(NormalizedValue,1))
    if(NormalizedValue(i,8) == 1 && NormalizedValue(i+1,8)==0)
       M = ceil(median(BottomValleyindex));
       NormalizedValue(M,9) =1;
       clear('BottomValleyindex');
       j=1;
    end
    elseif(i >= lTrkindex)
        if(NormalizedValue(i,8) == 1)
        BottomValleyindex(j,:) = 1;
        j= j+1;
        M = ceil(median(BottomValleyindex));
        NormalizedValue(M,9) =1;
        end
    end   
  
  end
  
  
  j = 1; k = 1;
  for i = 1:size(NormalizedValue,1)
    if(NormalizedValue(i,3)==0 && NormalizedValue(i,4)==0 && NormalizedValue(i,5)==1)
        index(j,:) =i;
        j=j+1;
    else
        
         exist index;
         if(ans==1)
            M = ceil(median(index));
            Newindex(M,1)=1;
        	clear('index');
            j=1;
            Value(k,1) = M;
            k=k+1;
         end
    end
   
  end
  
  % Peak Valley indices
  j=1;
  k=1;
  
  for i = 1:size(NormalizedValue,1)
      if(NormalizedValue(i,7) == 1)
          PeakValley(j,1) = i;
          j=j+1;
      
      end
      if(NormalizedValue(i,9)==1)
          BottomValley(k,1) = i;
          k=k+1;
      end
  end
  SPeakValley = size(PeakValley,1);
  SBottomValley = size(BottomValley,1);
  
  %PeakValley = 2
for i=1:size(PeakValley)
    NormalizedValue(PeakValley(i),10) = 2;
end


% BottomValley = 3
for i=1:size(BottomValley)
    NormalizedValue(BottomValley(i),10) = 3;
end
 

for i = 1:size(Value,1)
     if(i==1)
         if(PeakValley(SPeakValley)>BottomValley(SBottomValley))
             NormalizedValue(Value(i),10)=3;
         elseif(PeakValley(SPeakValley)<BottomValley(SBottomValley))
             NormalizedValue(Value(i),10)=2;
         end
     else 
        
         NormalizedValue(Value(i),10)=1;
     end
     
      
end
k = 1;j = 1;
for i = 1:size(NormalizedValue,1)
    if(NormalizedValue(i,10)==1)
        for j = 1:size(NormalizedValue,1)
            if(NormalizedValue((i-j),10) ==2)
                NormalizedValue(i,10) = 3;
             break;
            elseif(NormalizedValue((i-j),10) ==3)
                NormalizedValue(i,10)=2;
                break;
            
             
            end
        end
        
    end
        
end

 %% Avoiding Unnecessary Columns
 
 NormalizedValueNew(:,1) = NormalizedValue(:,1);  % Track
 NormalizedValueNew(:,2) = NormalizedValue(:,2);  % Sector
 NormalizedValueNew(:,3) = NormalizedValue(:,3);   % TPeak
 NormalizedValueNew(:,4) = NormalizedValue(:,4);  %TValley
 NormalizedValueNew(:,5) = NormalizedValue(:,5);   % Switch(swt)
%  NormalizedValueNew(:,6) = NormalizedValue(:,7);
%  NormalizedValueNew(:,7) = NormalizedValue(:,9);
 NormalizedValueNew(:,6) = NormalizedValue(:,10); % TopPeak (2)/BottomValley (3)
  
 counter = 0;j=1;
 for i = 1:size(NormalizedValue,1)-1
    if(NormalizedValue(i,3)==1)
        counter = counter+1;
        if(NormalizedValue(i+1,3)==0)   
            
            NumEl(j,1) = counter;
            counter = 0;
            j = j+1;
        elseif(i==size(NormalizedValue,1)-1)
            counter = counter+1;
            NumEl(j,1) = counter;
            j=j+1;
        end
    end
 end
 
 counter = 0;
  for i = 1:size(NormalizedValue,1)-1
    if(NormalizedValue(i,5)==1)
        counter = counter+1;
        if(NormalizedValue(i+1,5)==0)   
            
            NumEl(j,1) = counter;
            counter = 0;
            j = j+1;
        elseif(i==size(NormalizedValue,1)-1)
            counter = counter+1;
            NumEl(j,1) = counter;
            j=j+1;
        end
    end
  end
 
%  NormalizedValueNew(:,7) = cxxN(:,1);
%  NormalizedValueNew(:,8) = cyyN(:,1);
 
 %% Feature Values generated from Peak and Valley
 
 % 1). Number of Spicules or Lobes: (NumSplo) by counting number of TopPeak
  counter = 0;
 for i = 1:size(NormalizedValueNew,1)
     if(NormalizedValueNew(i,6)==2)
        
         counter = counter+1;
     end
 end
 
 
 NumSplo = counter;
 
 % 2).Average number of elements in the convex region. (AvgNumEleAtPeak)
 %NumEleTip(x)
 
 TotalSum = sum(NumEl);
 AvgNumEleAtPeak = TotalSum/NumSplo;
 
 j=1;k=1;
 for i = 1:size(cxxN,1)
     if(NormalizedValueNew(i,6) == 2)
%          x=NormalizedValue(i,7);
%          y=NormalizedValue(i,8);
         %plot(x,y,'*','Color','g');
       PeakValleyAnchorx(j,1) = cxxN(i,1);
       PeakValleyAnchory(j,1) = cyyN(i,1);
        
         j = j+1;
         %plot(cxxN(i),cyyN(i),'r*','MarkerSize',8);
     elseif(NormalizedValueNew(i,6) == 3)
%          x=NormalizedValue(i,7);
%          y=NormalizedValue(i,8);
%          plot(x,y,'*','Color','b');
        BottomValleyAnchorx(k,1) = cxxN(i,1);
       BottomValleyAnchory(k,1) = cyyN(i,1);
        
    k= k+1;
    %  plot(cxxN(i),cyyN(i),'b*','MarkerSize',8);
     end
 end
 hold on;
 
 
   plot(PeakValleyAnchorx(:,1),PeakValleyAnchory(:,1),'k*','MarkerSize',8);
 
 plot(BottomValleyAnchorx(:,1),BottomValleyAnchory(:,1),'b*','MarkerSize',8);
 
% % %  NormalizedValue = NormalizedValueNew;
% % %  j=1;
% % %  for i = 1: size(NormalizedValueNew,1)
% % %      if(i==1)
% % %         if( NormalizedValueNew(i,1) ~= NormalizedValueNew(i+1,1)&& NormalizedValueNew(i,1) ~= NormalizedValueNew(size(NormalizedValueNew,1),1))
% % %         dele(j,1) = i;
% % %         j=j+1;
% % %         end
% % %      elseif(i==size(NormalizedValueNew,1))
% % %          if(NormalizedValueNew(i,1) ~= NormalizedValueNew(1,1) && NormalizedValueNew(i,1)~=NormalizedValueNew(i-1,1))
% % %             dele(j,1) = i;
% % %             j=j+1;
% % %          end
% % %      else
% % %          if( NormalizedValueNew(i,1) ~= NormalizedValueNew(i+1,1)&& NormalizedValueNew(i,1) ~= NormalizedValueNew(i-1,1))
% % %         dele(j,1) = i;
% % %         j=j+1;
% % %          end
% % %      end
% % %  end
% % %  for i = 1:size(dele,1)
% % %      NormalizedValueNew(dele(i),:) = [];
% % %  end
% % %  
% % %  NormalizedValueNew = NormalizedValue;
 %hold off;
end  
  

      
   
