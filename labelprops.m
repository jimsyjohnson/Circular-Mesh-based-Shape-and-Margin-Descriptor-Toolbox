function [AvgNegSeci,NumNegSeci,AvgZeroTrki,NumTrkZero,RatioSTrkVarSTrk,STrkOcc,RatioMTrkOccSTrkVar,RatioSSecVarSSec,RatioSTrkVarSSecVar,OneSeci,OneSecSSec] = labelprops(TrkVar,Trk,sec,SecVar,TrkOcc,SecOcc)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
%%% Ratio between size of TrkVar to size of Trk  (RatioSTrkVarSTrk)
       
       RatioSTrkVarSTrk = size(TrkVar,1)/size(Trk,2);

%%% Ratio of average TrkOcc to the size of TrkVar   (RatioMTrkOccSTrkVar)    

          m = size(TrkOcc,1);     
          STrkOcc = sum(TrkOcc);
          RatioMTrkOccSTrkVar = STrkOcc/(m*size(TrkVar,1));          
          
 %%% Ratio of the size of SecVar to the size of Sec  (RatioSSecVarSSec)
          
            RatioSSecVarSSec = size(SecVar,1)/size(sec,2);
 
%%% Ratio of the size of TrkVar to the size of SecVar (RatioSTrkVarSSecVar)
               
            RatioSTrkVarSSecVar = size(TrkVar,1)/size(SecVar,1);

%%%% Ratio of the occurrence of 1s in Sec(i+1)-sec(i) to the size of sec.
        k =0; 
           for i = 1:size(sec,2)-1
               if(sec(i+1)-sec(i) == 1)
                   k=k+1;
                   OneSeci = k;
               end
           end
        OneSecSSec = OneSeci/size(sec,2);

%%%% Ratio of number of zeros in Trk(i+1)-Trk(i) to the size of TrkOcc
    k=0;
        for i = 1:size(Trk,2)-1
            if(Trk(i+1)-Trk(i) == 0)
                k=k+1;
                NumTrkZero =k;
            end
            
        end
        AvgZeroTrki = NumTrkZero/size(TrkOcc,1);
%%%% Number of negative values in Sec(i+1)-Sec(i) to size(SecOcc)

        j=0;
        for i= 1:size(sec,2)-1
            if(sec(i+1)-sec(i) < 0)
                j=j+1;
                NumNegSeci = j;
            end
        end
        AvgNegSeci = NumNegSeci/size(SecOcc,1);
        pause(1);
end

