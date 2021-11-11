


function [SDT_0_360,SDT_40_140,SDT_320_40,SDT_140_220,CoeffVarT_0_360,CoeffVarT_40_140,CoeffVarT_220_320,CoeffVarT_320_40,CoeffVarT_140_220,Deviation_Symmetry_0_90,Deviation_Symmetry_0_180]= symmetrydevi(Trk,secangle)
         % [SDT_0_360,SDT_40_140,SDT_320_40,SDT_140_220,CoeffVarT_0_360,CoeffVarT_40_140,CoeffVarT_220_320,CoeffVarT_320_40,CoeffVarT_140_220,Deviation_Symmetry_0_90,Deviation_Symmetry_0_180]= symmetrydevi(Trk,secangle);
%%%%%%%  STATISTICAL METHODS %%%%%%%%%%
 
%%%%% Standard Deviation and Coefficient of Variation of Tracks angles between 0 to 360
        
            mu = mean(Trk);
            mu = round(mu);
            c = 1;
        for i = 1:size(Trk,2)
            ITrk(c) = (Trk(i)-mu)^2;
            c=c+1;
        end
         
            SDT_0_360 = sqrt( sum(ITrk)/size(Trk,2));
       
            CoeffVarT_0_360 = SDT_0_360/mu;
%%%%%% Standard Deviation and Coefficient of Variation of Track angles between 40 to 140

    I = find(secangle > 40 & secangle < 140);
     TF =isempty(I);   
    if(TF == 0)
           
        for i = 1:size(I,2)
            Trk_40_140(i) = Trk(I(i));
        end
            mu = mean(Trk_40_140);
            mu = round(mu);
        for i = 1:size(Trk_40_140,2)
            ITrk(c) = (Trk_40_140(i)-mu)^2;
            c=c+1;
        end
            SDT_40_140 = sqrt( sum(ITrk)/size(Trk_40_140,2));
            CoeffVarT_40_140 = SDT_40_140/mu;
    end
%%%%%% Standard Deviation and Coefficient of Variation of Track angles between 220 to 320  
    
    I = find(secangle > 220 & secangle < 320);
     TF =isempty(I);   
    if(TF == 0)
           
        for i = 1:size(I,2)
            Trk_220_320(i) = Trk(I(i));
        end
            mu = mean(Trk_220_320);
            mu = round(mu);
        for i = 1:size(Trk_220_320,2)
            ITrk(c) = (Trk_220_320(i)-mu)^2;
            c=c+1;
        end
            SDT_220_320 = sqrt( sum(ITrk)/size(Trk_220_320,2));
            CoeffVarT_220_320 = SDT_220_320/mu;
            
    end
%%%%%% Standard Deviation and Coefficient of Variation of Track angles between 320 to 40  
    I = find(secangle > 40 & secangle < 320);
     TF =isempty(I);   
    if(TF == 0)
           
        for i = 1:size(I,2)
            Trk_320_40(i) = Trk(I(i));
        end
            mu = mean(Trk_320_40);  
            mu = round(mu);
        for i = 1:size(Trk_320_40,2)
            ITrk(c) = (Trk_320_40(i)-mu)^2;
            c=c+1;
        end
            SDT_320_40 = sqrt( sum(ITrk)/size(Trk_320_40,2));
            CoeffVarT_320_40 = SDT_320_40/mu;
            
    end
%%%%%% Standard Deviation and Coefficient of Variation of Track angles between 140 to 220  
    
    I = find(secangle > 140 & secangle <220);
    TF =isempty(I);   
    if(TF == 0)
           
      
        for i = 1:size(I,2)
            Trk_140_220(i) = Trk(I(i));
        end
            mu = mean(Trk_140_220);
            mu = round(mu);
        for i = 1:size(Trk_140_220,2)
            ITrk(c) = (Trk_140_220(i)-mu)^2;
            c=c+1;
        end
            SDT_140_220 = sqrt( sum(ITrk)/size(Trk_140_220,2));
            CoeffVarT_140_220 = SDT_140_220/mu;
    else
    end    
%%%%% Deviation from Symmetry 

%%%  between 0 and 90


  I = find(secangle==180);
  [k l] = size(I);
  
  
  phi = round(median(I));
  if(l ~=0)
     I = find(secangle > 0 & secangle < 90);
     n = size(I,2);
     Deviation_Symmetry= 0;
     for i =1 : round(n/4)
                     SD =(Trk(phi+i) - Trk(phi-i))/n;
             Deviation_Symmetry_0_90 = Deviation_Symmetry +SD;
         
     end
  else
      Deviation_Symmetry_0_90 = 0;
  end
     
     %%%  between 0 and 180


  I = find(secangle==180);
  [k l] = size(I);
  if(l~=0)
  phi = round(median(I));
  
     I = find(secangle > 0 & secangle < 180);
     n = size(I,2);
     Deviation_Symmetry= 0;
     for i =1 : round(n/4)
                     SD =(Trk(phi+i) - Trk(phi-i))/n;
             Deviation_Symmetry_0_180 = Deviation_Symmetry +SD;
         
     end
  else
      
     Deviation_Symmetry_0_180 = 0;
  end
end
    
    
    

