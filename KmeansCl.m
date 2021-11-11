function [tracks,sectors] = KmeansCl(elong,compact,convex,str)
%UNTITLED3 Summary of this function goes here
str = 'x';
 elongation = load('elongation.mat');
                elongation = elongation.elongation;
                elongation.features(end+1,:)=elong;
                elongation.label{end+1,1}=str;
                save('elongation.mat','elongation');
                
       
            
                compactness = load('compactness.mat');
                compactness = compactness.compactness;
                compactness.features(end+1,:)=compact;
                compactness.label{end+1,1}=str;
                save('compactness.mat','compactness');
            
      
                convexity = load('convexity.mat');
                convexity = convexity.convexity;
                convexity.features(end+1,:)=convex;
                convexity.label{end+1,1}=str;
                save('convexity.mat','convexity');             
            
                
for i = 1:size(convexity.features,1)
    X(i,1) = convexity.features(i,1);
end
k=i+1;
for i = 1:size(elongation.features,1)
    X(k,1) = elongation.features(i,1);
    k=k+1;
end
j=k;
for i = 1:size(compactness.features,1)
    X(j,1) = compactness.features(i,1);
    j = j+1;
end
[idx]= kmeans(X,10);
v = size(idx,1);
    if (idx(v,:)<=3)
        tracks =64;
        sectors = 30;
    elseif(idx(v,:) <=5)
        tracks =40;
        sectors = 128;
    elseif(idx(v,:) <=7)
         tracks =30;
        sectors = 128;
    elseif(idx(v,:) <= 10)
         tracks =60;
        sectors = 256;
    end
end

