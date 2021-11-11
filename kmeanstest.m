%%
clc;
clear all;
close all;


folder_name = uigetdir;
   str = input('Enter The leaf Name\n','s');
   strn = str2double(str);
   srcFiles = dir([folder_name,'\*.png']);  % the folder in which ur images exists
   
   
    for i = 1 : length(srcFiles)
        filename = strcat(folder_name,'\',srcFiles(i).name);
        B = imread(filename);  
        A=flip(B,2);
        s=strel('disk',2,0);  
        F=imerode(A,s);  
        bord=A-F;
        BW2=im2bw(bord,.05);
        BW2= imfill(BW2,'holes');
        seg=BW2;
        s=strel('disk',1,0);
        F=imerode(BW2,s);
        bord=BW2-F;
        I2= imcomplement(bord);
        I2 = flip(I2,1);
        bw = im2bw(I2);
        [m,n] = size(bw);
        b = 0;
        bw = imcomplement(bw);
        H = regionprops(bw, 'MajorAxisLength');
        V = regionprops(bw,'MinorAxisLength');

   % ELONGATION
        elong = max(H.MajorAxisLength)/max(V.MinorAxisLength);
        P = regionprops(bw,'Perimeter');
        C = vertcat(P.Perimeter);
        peri = max(C);
        PerShape =peri;
        AreaObj = regionprops(bw,'Area');
        C = vertcat(AreaObj.Area);
        AR = max(C);

   %COMPACTNESS
        compact = 1-(4*(max(P.Perimeter))*((AR/(max(P.Perimeter))^2)));

   % CONVEXITY 
        CH = bwconvhull(bw); % convexhull
        stats = regionprops(bw,'ConvexHull');
        convexHull = bwconvhull(bw);
        PerConvexHull = regionprops(convexHull, 'Perimeter');
        convex = PerConvexHull.Perimeter/PerShape;
    
 chk = exist('convexity.mat', 'file'); 
    if chk ~= 0   
        convexity = load('convexity.mat');
        convexity = convexity.convexity;
        convexity.features(end+1,:)=convex;
        convexity.label{end+1,1}=str;
        save('convexity.mat','convexity');
        
        
        
    else
        
        convexity = struct();
        convexity.features=[];
        convexity.label={};
        convexity.features=convex;
        convexity.label{end+1,1}=str;
        save('convexity.mat','convexity');
         
  end
    
    
    chk = exist('elongation.mat', 'file'); 
    if chk ~= 0 
        elongation = load('elongation.mat');
        elongation = elongation.elongation;
        elongation.features(end+1,:)=elong;
        elongation.label{end+1,1}=str;
        save('elongation.mat','elongation');
    else
        elongation = struct();
        elongation.features=[];
        elongation.label={};
        elongation.features=elong;
        elongation.label{end+1,1}=str;
        save('elongation.mat','elongation');
    end
    chk = exist('compactness.mat', 'file'); 
    if chk ~= 0       
        compactness = load('compactness.mat');
        compactness = compactness.compactness;
        compactness.features(end+1,:)=compact;
        compactness.label{end+1,1}=str;
        save('compactness.mat','compactness');
    else
        compactness = struct();
        compactness.features=[];
        compactness.label={};
        compactness.features=compact;
        compactness.label{end+1,1}=str;
        save('compactness.mat','compactness');
    end
      
   end
% K-means data clustering (kmeanscl(convex, elong,compact, numcl)
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
k=10;
[idx,C]= kmeans(X,k);
for i = 1:size(idx,1)
    
    if (idx(i,:)<=3)
        tracks(i,:) =64;
        sector(i,:) = 30;
       
    elseif(idx(i,:) <=5)
        tracks(i,:) =40;
        sector(i,:) = 128;
    elseif(idx(i,:) <=7)
         tracks(i,:) =30;
        sector(i,:) = 128;
    elseif(idx(i,:) <= 10)
         tracks(i,:) =60;
        sector(i,:) = 256;
    end
end