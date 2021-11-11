

%%%% Convexity and Convavity Detection Algorithm

function [NumSplo,AvgNumEleAtPeak] = convexcavdet(TrkVar,SecVar,NormalizedValue,cxxN,cyyN)
% [TrkPt,SecPt,NormalizedTrkPt,indicesTrkPt,Trackindex] = convexcavdet(TrkVar,SecVar);    
% %%%% Convexity and Convavity Detection Algorithm
%   Detailed explanation goes here
b = 0; a= 1; 
TrkPt = 0;
for i  = 1:size(TrkVar,1)
    TrkPt(i,1) = TrkVar(i,1);
    if i == 1
        TrkPt(i,2) = i;
    else
        a= a+TrkVar(i-1,2);
        TrkPt(i,2) = a;
    end
    
    TrkPt(i,3) = TrkVar(i,2);

end

b = 0; a= 1; 
SecPt = 0;
for i  = 1:size(SecVar,1)
    SecPt(i,1) = SecVar(i,1);
    if i == 1
       SecPt(i,2) = i;
    else
        a= a+SecVar(i-1,2);
        SecPt(i,2) = a;
    end
    
    SecPt(i,3) = SecVar(i,2);

end
%% TPeak
%tc = 1;
counter =1;
 lTrkindex = size(NormalizedValue,1);
NormalizedValue(:,3) = 0;
for i = 2:size(NormalizedValue,1)-1
    
    if(NormalizedValue(i,1)>NormalizedValue(i+1,1)&& NormalizedValue(i,1)>NormalizedValue(i-1,1))
        NormalizedValue(i,3) = 1;
%     elseif(NormalizedValue(i,1)>NormalizedValue(i+1,1) && NormalizedValue(i,1)>NormalizedValue(size(NormalizedValue,1)))
%         NormalizedValue(i,3) = 1;
    elseif(NormalizedValue(i-1,1)<NormalizedValue(i,1) && NormalizedValue(i,1) == NormalizedValue(i+1,1))
        for k = i+1:size(NormalizedValue,1)-1
            if(NormalizedValue(i,1) ==NormalizedValue(k,1))
                counter = counter+1;
                
                NormalizedValue(i,3) = 1;
                counter = counter-1;
                if(counter ==0)
                    break;
                else
                    NormalizedValue(k,3)=1;
                end
            else
                break;  % need to change this break)
                
                
                
            end
        end
           
    else
        if(NormalizedValue(i,3)==1)
            NormalizedValue(i,3) = 1;
        else
            NormalizedValue(i,3) =0;
        end
        
    
    end
end

% TValley
NormalizedValue(:,4) =0;
for i = 2:size(NormalizedValue,1)-1
    if(NormalizedValue(i,1)<NormalizedValue(i+1,1)&& NormalizedValue(i,1)<NormalizedValue(i-1,1))
        NormalizedValue(i,4) = 1;
    elseif(NormalizedValue(i-1,1)>NormalizedValue(i,1) && NormalizedValue(i,1) == NormalizedValue(i+1,1)) 
        for k = i+1:size(NormalizedValue,1)-1
            if(NormalizedValue(i,1) ==NormalizedValue(k,1))
                counter = counter+1;
                NormalizedValue(i,4) = 1;
                counter = counter-1;
                if(counter ==0)
                    
                    break;
                else
                    NormalizedValue(k,4)=1;
                end
            else
                
                break;  % need to change this break)
                 
            end
        end
    else
         if(NormalizedValue(i,4)==1)
            NormalizedValue(i,4) = 1;
        else
            NormalizedValue(i,4) =0;
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
    else
        NormalizedValue(M,9) =0;
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
 
  if exist('Value','var')
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
%  hold on;
 
 
  
end

