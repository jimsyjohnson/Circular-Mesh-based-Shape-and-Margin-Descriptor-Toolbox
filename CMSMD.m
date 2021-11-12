function varargout = CMSMD(varargin)
% CMSMD MATLAB code for CMSMD.fig
%      CMSMD, by itself, creates a new CMSMD or raises the existing
%      singleton*.
%
%      H = CMSMD returns the handle to a new CMSMD or the handle to
%      the existing singleton*.
% 
%      CMSMD('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CMSMD.M with the given input arguments.
%
%      CMSMD('Property','Value',...) creates a new CMSMD or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CMSD_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property
%      application/
%      stop.  All inputs are passed to CMSD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CMSMD

% Last Modified by GUIDE v2.5 02-Nov-2021 17:00:01

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CMSMD_OpeningFcn, ...
                   'gui_OutputFcn',  @CMSMD_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CMSMD is made visible.
function CMSMD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CMSD (see VARARGIN)

% Choose default command line output for CMSD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
set(handles.pushbutton26,'visible','off')
set(handles.browse_pbtn,'visible','off')
set(handles.cmg_pbtn,'visible','off')
set(handles.embg_bound,'visible','off')
set(handles.cbl_pbtn,'visible','off')
set(handles.feaureextr_btn,'visible','off')
set(handles.pushbutton16,'visible','off')
set(handles.pushbutton35,'visible','off')
set(handles.axes1,'visible','off')
set(handles.txt_output,'visible','off')
set(handles.text5,'visible','off')
set(handles.edit7,'visible','off')
set(handles.ER_btn,'visible','off')
set(handles.btn_selectfolder,'visible','off')
set(handles.btn_accuracy,'visible','off')
set(handles.edit11,'visible','off')
set(handles.edit12,'visible','off')
set(handles.edit13,'visible','off')
set(handles.edit14,'visible','off')
set(handles.button_sens,'visible','off')
set(handles.button_speci,'visible','off')
set(handles.uitable2,'visible','off')
set(handles.uitable3,'visible','off')

% UIWAIT makes CMSD wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CMSMD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
% function edit1_CreateFcn(hObject, eventdata, handles)
% % hObject    handle to edit1 (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    empty - handles not created until after all CreateFcns called
% 
% % Hint: edit controls usually have a white background on Windows.
% %       See ISPC and COMPUTER.
% if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
%     set(hObject,'BackgroundColor','white');
% end
function browse_pbtn_Callback(hObject, eventdata, handles)
%Browse Input Image
cla reset;

[fileName,pathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
                      '*.*','All Files' },'Select Input Image',...
                      'DataSet\Image1.jpg');
       I2 = imread([pathName,fileName]);  
       imshow(I2);
 handles.I2 = I2;
guidata(hObject, handles);      
  



% --- Executes on button press in cmg_pbtn.
function cmg_pbtn_Callback(hObject, eventdata, handles)
% hObject    handle to cmg_pbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% --- Executes on button press in cbl_pbtn.

cla reset;
B = handles.I2;

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
    %bw = im2bw(I2);
    bw = im2bw(I2);
    [m,n] = size(bw);
    b = 0;
    bw = imcomplement(bw);
    str ='x';        
    

    [elong,compact,convex] = NumCir(bw);

    [tracks,sectors] = KmeansCl(elong,compact,convex);                  
               
    [r,R_x,R_y,ym2,xm2] = RadiusFind(bw);
 
  [nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw); % rotating the image to theta angle

 w = 1;
 
 
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1) 
               
                r(w,1) =i;
                r(w,2) = j;
                          % took all 1's in r      
                w = w+1;  
                b = b+1;
 
            end
            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);
  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;
    
    else
    end
  end      
  
 diameter = mx;
 radius = diameter/2;
 
 
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 
xx1=R_x;
yy1=R_y;
num1=1; 
[xx,yy,rt,sectorcord] = CmGen(tracks,radius,nim,R_x,R_y,sectors,yy1,xx1,num1);

[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh

function cbl_pbtn_Callback(hObject, eventdata, handles)
% hObject    handle to cbl_pbtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;

clc;
set(handles.axes1,'visible','off')
set(handles.uitable2,'visible','on')
set(handles.uitable3,'visible','off')
B = handles.I2;
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
    %bw = im2bw(I2);
    bw = im2bw(I2);
    [m,n] = size(bw);
    b = 0;
    bw = imcomplement(bw);
    P = regionprops(bw,'Perimeter');
    C = vertcat(P.Perimeter);
    peri = max(C);
    AreaObj = regionprops(bw,'Area');
    C = vertcat(AreaObj.Area);
    AR = max(C);
    boundextra_img = bw;    
    [elong,compact,convex] = NumCir(bw);
    [tracks,sectors] = KmeansCl(elong,compact,convex);              
    [r,R_x,R_y,ym2,xm2] = RadiusFind(boundextra_img);
    [nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw);
    w = 1;
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1)                
                r(w,1) =i;
                r(w,2) = j;                       
                w = w+1;  
                b = b+1; 
            end            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;        
        else            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;           
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;    
    else
    end
  end      
 diameter = mx;
 radius = diameter/2;
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 xx1=R_x;
 yy1=R_y;
 num1=1; 
% drawtracks 
%========================
centers = [R_x,R_y];
hold on;
axis on;
hold on;
nm1=1;
[l11,l22]=size(nim);
s = regionprops(nim,'centroid');
xx=round(s(1).Centroid(1));
yy=round(s(1).Centroid(2));
for ii=1:l11
    for jj=1:l22
        if(nim(ii,jj)==1) 
            cy2(nm1)=jj;
            cx1(nm1)=ii;
            nm1=nm1+1;
        end   
    end
end
pi=3.14;
area=pi*radius*radius;
Area_Ring=area/tracks; 
for i=1:tracks
rt(i)=(Area_Ring*i)/pi;
rt(i)=sqrt(rt(i));
rt = round(rt);
rt = rt'; % transpose
end
%================================
% plot sector
%==============================
for aa=1:size(nim,1)
    for bb=1:size(nim,2)
        if(nim(aa,bb)==1) 
             XX = [ yy1 xx1;bb aa];
             ds(num1) = pdist(XX,'euclidean');
             dx1(num1)=aa;
             dx2(num1)=bb;
             flag=0;
       for nt=1:tracks
        if(ds(num1)<rt(1))
            trackn(num1)=1;
            flag=1;
            break;
        end
        if(nt~=tracks && ds(num1)>rt(nt)&&ds(num1)<rt(nt+1))
            trackn(num1)=nt+1;
            flag=1;
            break;
        end
        if(flag==0)
            trackn(num1)=10;
        end  
       end
       num1=num1+1;
        end   
    end
end
A=[xx,xx+rt(tracks)];
B=[yy,yy];
angl=360/sectors;
%plot sector
for i=1:sectors
sectorcord(i,1)=R_x+(rt(tracks)*sind(angl*i));
sectorcord(i,2)=R_y+(rt(tracks)*cosd(angl*i));
end 
%=====================================================
[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh
[Trk,sec,secangle] = CMRepDes(cxx,cyy,R_x,R_y,rt,sectors);
Trk = Trk';
sec= sec';
Tvalue(:,1) =Trk;
Tvalue(:,2) =sec;
set( handles.uitable2, 'data', num2cell(Tvalue) )

% --- Executes on button press in embg_bound.
function embg_bound_Callback(hObject, eventdata, handles)
% hObject    handle to embg_bound (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
    cla reset;
    B = handles.I2;
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
    P = regionprops(bw,'Perimeter');
C = vertcat(P.Perimeter);
peri = max(C);
str ='x';    
    
    [elong,compact,convex] = NumCir(bw);
    [tracks,sectors] = KmeansCl(elong,compact,convex);               
    [r,R_x,R_y,ym2,xm2] = RadiusFind(bw);
    [nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw);
 w = 1;
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1)               
                r(w,1) =i;
                r(w,2) = j;
                          % took all 1's in r      
                w = w+1;  
                b = b+1; 
            end            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;        
        else            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;            
                
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;
    
    else
    end
  end      
 diameter = mx;
 radius = diameter/2;
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 plot(R_x,R_y,'r*','MarkerSize',25);
 xx1=R_x;
 yy1=R_y;
 num1=1; 
  [xx,yy,rt,sectorcord] = CmGen(tracks,radius,nim,R_x,R_y,sectors,yy1,xx1,num1);
[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh
[cxx,cyy] = BoundEmbd(cxx,cyy);



% --- Executes on button press in feaureextr_btn.
function feaureextr_btn_Callback(hObject, eventdata, handles)
% hObject    handle to feaureextr_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;
set(handles.axes1,'visible','off')
set(handles.uitable2,'visible','off')
set(handles.uitable3,'visible','on')
     B = handles.I2;
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
    %bw = im2bw(I2);
    bw = im2bw(I2);
    [m,n] = size(bw);
    b = 0;
    bw = imcomplement(bw);
    P = regionprops(bw,'Perimeter');
C = vertcat(P.Perimeter);
peri = max(C);

AreaObj = regionprops(bw,'Area');


C = vertcat(AreaObj.Area);
 AR = max(C);
    
    
     [elong,compact,convex] = NumCir(bw);

    [tracks,sectors] = KmeansCl(elong,compact,convex);                  
               
   [r,R_x,R_y,ym2,xm2] = RadiusFind(bw);

%  plot(R_x,R_y,'r*','MarkerSize',25);
[nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw);
 
w = 1;
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1) 
               
                r(w,1) =i;
                r(w,2) = j;
                          % took all 1's in r      
                w = w+1;  
                b = b+1;
 
            end
            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);
  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;
    
    else
    end
  end      
 diameter = mx;
 radius = diameter/2;
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
%  plot(R_x,R_y,'r*','MarkerSize',25);
 xx1=R_x;
 yy1=R_y;
 num1=1; 
 % generation (circular mesh generayion = drawtracks+plotsector)
% [xx,yy,rt,sectorcord] = generation(track,radius,nim,R_x,R_y,sector,yy1,xx1,num1);
% drawtracks 
%========================
centers = [R_x,R_y];
hold on;
axis on;
hold on;
nm1=1;
[l11,l22]=size(nim);
s = regionprops(nim,'centroid');
xx=round(s(1).Centroid(1));
yy=round(s(1).Centroid(2));
for ii=1:l11
    for jj=1:l22
        if(nim(ii,jj)==1) 
            cy2(nm1)=jj;
            cx1(nm1)=ii;
            nm1=nm1+1;
        end   
    end
end
pi=3.14;
area=pi*radius*radius;
Area_Ring=area/tracks; 
for i=1:tracks
rt(i)=(Area_Ring*i)/pi;
rt(i)=sqrt(rt(i));
rt = round(rt);
rt = rt'; % transpose
%   viscircles(centers,rt(i));
end
%================================

% plot sector
%==============================
for aa=1:size(nim,1)
    for bb=1:size(nim,2)
        if(nim(aa,bb)==1) 
             XX = [ yy1 xx1;bb aa];
             ds(num1) = pdist(XX,'euclidean');
             dx1(num1)=aa;
             dx2(num1)=bb;
             flag=0;
       for nt=1:tracks
        if(ds(num1)<rt(1))
            trackn(num1)=1;
            flag=1;
            break;
        end
        if(nt~=tracks && ds(num1)>rt(nt)&&ds(num1)<rt(nt+1))
            trackn(num1)=nt+1;
            flag=1;
            break;
        end
        if(flag==0)
            trackn(num1)=10;
        end  
       end
       num1=num1+1;
        end   
    end
end
A=[xx,xx+rt(tracks)];
B=[yy,yy];
angl=360/sectors;
%plot sector
for i=1:sectors
sectorcord(i,1)=R_x+(rt(tracks)*sind(angl*i));
sectorcord(i,2)=R_y+(rt(tracks)*cosd(angl*i));
end 

[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh
[Trk,sec,secangle] = CMRepDes(cxx,cyy,R_x,R_y,rt,sectors);

%%  Counting Track Values and Sector Values
  
 [TrkVar,TrkOcc,SecVar,SecOcc,Trkin,Secin,PeakValley,NormalizedValue,indices,cxxN,cyyN] = CountTrckSec(Trk,sec,cxx,cyy);


%% Label Properties  

[AvgNegSeci,NumNegSeci,AvgZeroTrki,NumTrkZero,RatioSTrkVarSTrk,STrkOcc,RatioMTrkOccSTrkVar,RatioSSecVarSSec,RatioSTrkVarSSecVar,OneSeci,OneSecSSec] = labelprops(TrkVar,Trk,sec,SecVar,TrkOcc,SecOcc);
            
 %% Symmetric Deviation
 [SDT_0_360,SDT_40_140,SDT_320_40,SDT_140_220,CoeffVarT_0_360,CoeffVarT_40_140,CoeffVarT_220_320,CoeffVarT_320_40,CoeffVarT_140_220,Deviation_Symmetry_0_90,Deviation_Symmetry_0_180]= symmetrydevi(Trk,secangle);
 
 
   %%
 [RatioCirPerObjPer] = structuralfor(peri,AR,cxx,cyy,R_x,R_y);

%% Convexity and Convavity Detection Algorithm  
 
        [NumSplo,AvgNumEleAtPeak] = convexcavdet(TrkVar,SecVar,NormalizedValue,cxxN,cyyN);
          %[PeakValleyNew,NumSplo,AvgNumEleAtPeak] = PeakNoNorm(TrkPt,PeakValley,SecPt,cxx,cyy) ;   
      [l m] = size(TrkVar);  
      [k j] = size(SecVar);
        
   F =  [RatioCirPerObjPer,RatioSTrkVarSTrk,l,Deviation_Symmetry_0_180,Deviation_Symmetry_0_90,SDT_0_360,SDT_320_40,SDT_40_140,RatioSSecVarSSec,AvgZeroTrki,RatioSTrkVarSSecVar,OneSecSSec,CoeffVarT_0_360,SDT_140_220,k,CoeffVarT_40_140,RatioMTrkOccSTrkVar,CoeffVarT_140_220,AvgNegSeci,NumSplo,AvgNumEleAtPeak];
   set( handles.uitable3, 'data', num2cell(F))   
 handles.F = F;
guidata(hObject, handles);    

% --- Executes on button press in testing_btn.
function testing_btn_Callback(hObject, eventdata, handles)
% hObject    handle to testing_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;
set(handles.pushbutton26,'visible','off')
set(handles.btn_selectfolder,'visible','off');
set(handles.browse_pbtn,'visible','on')
set(handles.cmg_pbtn,'visible','on')
set(handles.embg_bound,'visible','on')
set(handles.cbl_pbtn,'visible','on')
set(handles.feaureextr_btn,'visible','on')
set(handles.pushbutton16,'visible','on')
set(handles.pushbutton35,'visible','on')
set(handles.axes1,'visible','off')
set(handles.txt_output,'visible','off')
set(handles.text5,'visible','off')
set(handles.edit7,'visible','off')
set(handles.ER_btn,'visible','off')
set(handles.edit11,'visible','off')
set(handles.btn_accuracy,'visible','off')
set(handles.button_sens,'visible','off')
set(handles.button_speci,'visible','off')
set(handles.edit12,'visible','off')
set(handles.edit13,'visible','off')
set(handles.edit14,'visible','off')

% --- Executes on button press in training_btn.
function training_btn_Callback(hObject, eventdata, handles)
% hObject    handle to training_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;
set(handles.pushbutton26,'Visible','on')
set(handles.text5,'Visible','on')
set(handles.edit7,'Visible','on')
set(handles.browse_pbtn,'visible','off')
set(handles.btn_selectfolder,'visible','on')
set(handles.cmg_pbtn,'visible','off')
set(handles.embg_bound,'visible','off')
set(handles.cbl_pbtn,'visible','off')
set(handles.feaureextr_btn,'visible','off')
set(handles.pushbutton16,'visible','off')
set(handles.pushbutton35,'visible','off')
set(handles.axes1,'visible','off')
set(handles.txt_output,'visible','off')
set(handles.text5,'visible','on')
set(handles.edit7,'visible','on')
set(handles.ER_btn,'visible','off')
set(handles.btn_accuracy,'visible','off')
set(handles.button_speci,'visible','off');
set(handles.button_sens,'visible','off');
set(handles.edit7,'visible','off')
set(handles.edit11,'visible','off')
set(handles.edit12,'visible','off')
set(handles.edit13,'visible','off')
set(handles.edit14,'visible','off')




% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla reset;
set(handles.uitable2,'visible','off')
set(handles.uitable3,'visible','off')
set(handles.txt_output,'visible','off')
[fileName,pathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
                      '*.*','All Files' },'Select Input Image',...
                      'DataSet\Image1.jpg');
     B = imread([pathName,fileName]);  
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
    %bw = im2bw(I2);
    bw = im2bw(I2);
    [m,n] = size(bw);
    b = 0;
    bw = imcomplement(bw);
    P = regionprops(bw,'Perimeter');
C = vertcat(P.Perimeter);
peri = max(C);

AreaObj = regionprops(bw,'Area');


C = vertcat(AreaObj.Area);
 AR = max(C);
 %str ='x';        
    
   [elong,compact,convex] = NumCir(bw);

    [tracks,sectors] = KmeansCl(elong,compact,convex);                  
               
    [r,R_x,R_y,ym2,xm2] = RadiusFind(bw);

 plot(R_x,R_y,'r*','MarkerSize',25);
[nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw);
 
w = 1;
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1) 
               
                r(w,1) =i;
                r(w,2) = j;
                          % took all 1's in r      
                w = w+1;  
                b = b+1;
 
            end
            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);
  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;
    
    else
    end
  end      
 diameter = mx;
 radius = diameter/2;
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
 plot(R_x,R_y,'r*','MarkerSize',25);
 xx1=R_x;
 yy1=R_y;
 num1=1; 
 % generation (circular mesh generayion = drawtracks+plotsector)
[xx,yy,rt,sectorcord] = CmGen(tracks,radius,nim,R_x,R_y,sectors,yy1,xx1,num1);


[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh
[cxx,cyy] = BoundEmbd(cxx,cyy);
[Trk,sec,secangle] = CMRepDes(cxx,cyy,R_x,R_y,rt,sectors);

%%  Counting Track Values and Sector Values
  
 [TrkVar,TrkOcc,SecVar,SecOcc,Trkin,Secin,PeakValley,NormalizedValue,indices,cxxN,cyyN] = CountTrckSec(Trk,sec,cxx,cyy);


%% Label Properties  

[AvgNegSeci,NumNegSeci,AvgZeroTrki,NumTrkZero,RatioSTrkVarSTrk,STrkOcc,RatioMTrkOccSTrkVar,RatioSSecVarSSec,RatioSTrkVarSSecVar,OneSeci,OneSecSSec] = labelprops(TrkVar,Trk,sec,SecVar,TrkOcc,SecOcc);
            
 %% Symmetric Deviation
 [SDT_0_360,SDT_40_140,SDT_320_40,SDT_140_220,CoeffVarT_0_360,CoeffVarT_40_140,CoeffVarT_220_320,CoeffVarT_320_40,CoeffVarT_140_220,Deviation_Symmetry_0_90,Deviation_Symmetry_0_180]= symmetrydevi(Trk,secangle);
 
 
   %%
 [RatioCirPerObjPer] = structuralfor(peri,AR,cxx,cyy,R_x,R_y);

%% Convexity and Convavity Detection Algorithm  
 
        [NumSplo,AvgNumEleAtPeak] = convexcavdet(TrkVar,SecVar,NormalizedValue,cxxN,cyyN);
          %[PeakValleyNew,NumSplo,AvgNumEleAtPeak] = PeakNoNorm(TrkPt,PeakValley,SecPt,cxx,cyy) ;   
      [l m] = size(TrkVar);  
      [k j] = size(SecVar);
        
   F =  [RatioCirPerObjPer,RatioSTrkVarSTrk,l,Deviation_Symmetry_0_180,Deviation_Symmetry_0_90,SDT_0_360,SDT_320_40,SDT_40_140,RatioSSecVarSSec,AvgZeroTrki,RatioSTrkVarSSecVar,OneSecSSec,CoeffVarT_0_360,SDT_140_220,k,CoeffVarT_40_140,RatioMTrkOccSTrkVar,CoeffVarT_140_220,AvgNegSeci,NumSplo,AvgNumEleAtPeak];
   
     
 % Read Trained Data

    circFeatureB  = load('circFeatureB.mat');
    circFeatureB = circFeatureB.circFeatureB;
    trainedData = circFeatureB.features;
    groups = circFeatureB.label;   

    
    
    X = circFeatureB.features;
    Y = circFeatureB.label;
    
    
%     set(handles.edit3,'String', label);
    Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
    label = predict(Mdl,F);
%     h = msgbox(label,'Result');
%     th = findall(h, 'Type', 'Text');        %Get the handle to the text within the box
%     msgString = th.String{:};
%     h.text_output.String = msgString; 
set(handles.txt_output,'visible','on');
   set(handles.txt_output,'String', label);
function txt_output_Callback(hObject, eventdata, handles)
% hObject    handle to txt_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of txt_output as text
%        str2double(get(hObject,'String')) returns contents of txt_output as a double


% --- Executes during object creation, after setting all properties.
function txt_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to txt_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function type_input_Callback(hObject, eventdata, handles)
% hObject    handle to type_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of type_input as text
%        str2double(get(hObject,'String')) returns contents of type_input as a double


% --- Executes during object creation, after setting all properties.
function type_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to type_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PerEval_btn.
function PerEval_btn_Callback(hObject, eventdata, handles)
% hObject    handle to PerEval_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% [E] = PerEval(circFeatureB.mat);
cla reset;
set(handles.btn_selectfolder,'visible','off');
set(handles.pushbutton26,'visible','off')
set(handles.browse_pbtn,'visible','off')
set(handles.cmg_pbtn,'visible','off')
set(handles.embg_bound,'visible','off')
set(handles.cbl_pbtn,'visible','off')
set(handles.feaureextr_btn,'visible','off')
set(handles.pushbutton16,'visible','off')
set(handles.pushbutton35,'visible','off')
set(handles.axes1,'visible','off')
set(handles.txt_output,'visible','off')
set(handles.text5,'visible','off')
set(handles.edit7,'visible','off')
set(handles.ER_btn,'visible','on')
% set(handles.edit5,'visible','on')
set(handles.btn_accuracy,'visible','on')
set(handles.edit11,'visible','on')
set(handles.edit12,'visible','on')
set(handles.edit13,'visible','on')
set(handles.edit14,'visible','on')
set(handles.button_speci,'visible','on')
set(handles.button_sens,'visible','on')
% set(handles.uipanel7,'visible','on')
% set(handles.uipanel4,'visible','off')


function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in ER_btn.
function ER_btn_Callback(hObject, eventdata, handles)
% hObject    handle to ER_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load circFeatureB;
X = circFeatureB.features;
Y = circFeatureB.label;
cp = classperf(Y);
for i = 1:10
    [train,test] = crossvalind('LeaveMOut',Y,5);
    mdl = fitcknn(X(train,:),Y(train),'NumNeighbors',3);
    predictions = predict(mdl,X(test,:));
    classperf(cp,predictions,test);
end
E = cp.ErrorRate;

set(handles.edit14,'String', E);


% --- Executes on button press in btn_accuracy.
function btn_accuracy_Callback(hObject, eventdata, handles)
% hObject    handle to btn_accuracy (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load circFeatureB;
X = circFeatureB.features;
Y = circFeatureB.label;
Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
predictedY = resubPredict(Mdl);
tpY = {'Benign'};
% TpY ={'benign'};

tnY = {'Malignant'};
% TnY = {'malignant'}

tppY = {'Benign'};

tnpY = {'Malignant'}
TP = 0;TN =0;FP=0;FN=0;
for i=1:size(Y,1)
  A = strcmpi(Y{i},tpY);
  B = strcmpi(Y{i},tnY);
  
  if(A==1)
      C = strcmpi(predictedY{i},tpY);
      if(C ==1)
      TP=TP+1;
      else
          FN =FN+1;
      end
  elseif(B==1)
      D = strcmpi(predictedY{i},tnY);
      if(D==1)
      TN=TN+1;
      else
          FP =FP+1;
      end
      
  end
    
end

TP= TP;
TN =TN;
n = size(Y,1);
ER = (FP+FN)/n;
Accuracy = round(TP+TN)/n;
set(handles.edit11,'String', Accuracy);

% Sensitivity = TP/(TP+FN);
% Specificity = TN/(TN+FP);





function edit6_Callback(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit6 as text
%        str2double(get(hObject,'String')) returns contents of edit6 as a double


% --- Executes during object creation, after setting all properties.
function edit6_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over PerEval_btn.
function PerEval_btn_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to PerEval_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton26.
function pushbutton26_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton26 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.axes1,'visible','off')
folder_name = handles.myVar;
str = handles.inputClass;

%   strn = str2double(str);
   srcFiles = dir([folder_name,'\*.png']);  % the folder in which ur images exists
   
for i = 1 : length(srcFiles)
        filename = strcat(folder_name,'\',srcFiles(i).name);
       B = imread(filename);  
% [fileName,pathName] = uigetfile({'*.jpg;*.tif;*.png;*.gif','All Image Files';...
%                       '*.*','All Files' },'Select Input Image',...
%                       'DataSet\Image1.jpg');
%      B = imread([pathName,fileName]);  
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
    %bw = im2bw(I2);
    bw = im2bw(I2);
    [m,n] = size(bw);
    b = 0;
    bw = imcomplement(bw);
    P = regionprops(bw,'Perimeter');
C = vertcat(P.Perimeter);
peri = max(C);

AreaObj = regionprops(bw,'Area');


C = vertcat(AreaObj.Area);
 AR = max(C);
[elong,compact,convex] = NumCir(bw);

    [tracks,sectors] = KmeansCl(elong,compact,convex);                  
               
    [r,R_x,R_y,ym2,xm2] = RadiusFind(bw);

%  plot(R_x,R_y,'r*','MarkerSize',25);
[nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw);
 
w = 1;
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1) 
               
                r(w,1) =i;
                r(w,2) = j;
                          % took all 1's in r      
                w = w+1;  
                b = b+1;
 
            end
            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);
  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;
    
    else
    end
  end      
 diameter = mx;
 radius = diameter/2;
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
%  plot(R_x,R_y,'r*','MarkerSize',25);
 xx1=R_x;
 yy1=R_y;
 num1=1; 
 % generation (circular mesh generayion = drawtracks+plotsector)
% [xx,yy,rt,sectorcord] = CmGen(tracks,radius,nim,R_x,R_y,sectors,yy1,xx1,num1);
% drawtracks 
%========================
centers = [R_x,R_y];

nm1=1;
[l11,l22]=size(nim);
s = regionprops(nim,'centroid');
xx=round(s(1).Centroid(1));
yy=round(s(1).Centroid(2));
for ii=1:l11
    for jj=1:l22
        if(nim(ii,jj)==1) 
            cy2(nm1)=jj;
            cx1(nm1)=ii;
            nm1=nm1+1;
        end   
    end
end
pi=3.14;
area=pi*radius*radius;
Area_Ring=area/tracks; 
for i=1:tracks
rt(i)=(Area_Ring*i)/pi;
rt(i)=sqrt(rt(i));
rt = round(rt);
rt = rt'; % transpose
%   viscircles(centers,rt(i));
end
%================================

% plot sector
%==============================
for aa=1:size(nim,1)
    for bb=1:size(nim,2)
        if(nim(aa,bb)==1) 
             XX = [ yy1 xx1;bb aa];
             ds(num1) = pdist(XX,'euclidean');
             dx1(num1)=aa;
             dx2(num1)=bb;
             flag=0;
       for nt=1:tracks
        if(ds(num1)<rt(1))
            trackn(num1)=1;
            flag=1;
            break;
        end
        if(nt~=tracks && ds(num1)>rt(nt)&&ds(num1)<rt(nt+1))
            trackn(num1)=nt+1;
            flag=1;
            break;
        end
        if(flag==0)
            trackn(num1)=10;
        end  
       end
       num1=num1+1;
        end   
    end
end
A=[xx,xx+rt(tracks)];
B=[yy,yy];
angl=360/sectors;
%plot sector
for i=1:sectors
sectorcord(i,1)=R_x+(rt(tracks)*sind(angl*i));
sectorcord(i,2)=R_y+(rt(tracks)*cosd(angl*i));
end 



[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh
% [cxx,cyy] = BoundEmbd(cxx,cyy);
[Trk,sec,secangle] = CMRepDes(cxx,cyy,R_x,R_y,rt,sectors);

%%  Counting Track Values and Sector Values
  
 [TrkVar,TrkOcc,SecVar,SecOcc,Trkin,Secin,PeakValley,NormalizedValue,indices,cxxN,cyyN] = CountTrckSec(Trk,sec,cxx,cyy);


%% Label Properties  

[AvgNegSeci,NumNegSeci,AvgZeroTrki,NumTrkZero,RatioSTrkVarSTrk,STrkOcc,RatioMTrkOccSTrkVar,RatioSSecVarSSec,RatioSTrkVarSSecVar,OneSeci,OneSecSSec] = labelprops(TrkVar,Trk,sec,SecVar,TrkOcc,SecOcc);
            
 %% Symmetric Deviation
 [SDT_0_360,SDT_40_140,SDT_320_40,SDT_140_220,CoeffVarT_0_360,CoeffVarT_40_140,CoeffVarT_220_320,CoeffVarT_320_40,CoeffVarT_140_220,Deviation_Symmetry_0_90,Deviation_Symmetry_0_180]= symmetrydevi(Trk,secangle);
 
 
   %%
 [RatioCirPerObjPer] = structuralfor(peri,AR,cxx,cyy,R_x,R_y);

%% Convexity and Convavity Detection Algorithm  
 
         [NumSplo,AvgNumEleAtPeak] = convexcavdet(TrkVar,SecVar,NormalizedValue,cxxN,cyyN);
          
      [l m] = size(TrkVar);  
      [k j] = size(SecVar);
        
   F =  [RatioCirPerObjPer,RatioSTrkVarSTrk,l,Deviation_Symmetry_0_180,Deviation_Symmetry_0_90,SDT_0_360,SDT_320_40,SDT_40_140,RatioSSecVarSSec,AvgZeroTrki,RatioSTrkVarSSecVar,OneSecSSec,CoeffVarT_0_360,SDT_140_220,k,CoeffVarT_40_140,RatioMTrkOccSTrkVar,CoeffVarT_140_220,AvgNegSeci,NumSplo,AvgNumEleAtPeak];

chk = exist('circFeatureB.mat', 'file'); 
    if chk ~= 0 
                      
              
        
       circFeatureB = load('circFeatureB.mat');
       circFeatureB = circFeatureB.circFeatureB;
        circFeatureB.features(end+1,:)=F;
        circFeatureB.label{end+1,1}=str;
        save('circFeatureB.mat','circFeatureB');
        
        
        
    else
        
        circFeatureB = struct();
        circFeatureB.features=[];
        circFeatureB.label={};
        circFeatureB.features=F;
        circFeatureB.label{end+1,1}=str;
        save('circFeatureB.mat','circFeatureB');
         
    end
end
msgbox('Training Completed','Success');

function edit7_Callback(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit7 as text
%        str2double(get(hObject,'String')) returns contents of edit7 as a double
a =get(handles.edit7,'string');

% --- Executes during object creation, after setting all properties.
function edit7_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in button_speci.
function button_speci_Callback(hObject, eventdata, handles)
% hObject    handle to button_speci (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load circFeatureB;
X = circFeatureB.features;
Y = circFeatureB.label;
Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
predictedY = resubPredict(Mdl);
tpY = {'Benign'};

tnY = {'Malignant'};

tppY = {'Benign'};

tnpY = {'Malignant'}
TP = 0;TN =0;FP=0;FN=0;
for i=1:size(Y,1)
  A = strcmpi(Y{i},tpY);
  B = strcmpi(Y{i},tnY);
  
  if(A==1)
      C = strcmpi(predictedY{i},tpY);
      if(C ==1)
      TP=TP+1;
      else
          FN =FN+1;
      end
  elseif(B==1)
      D = strcmpi(predictedY{i},tnY);
      if(D==1)
      TN=TN+1;
      else
          FP =FP+1;
      end
      
  end
    
end

TP= TP;
TN =TN;
n = size(Y,1);
ER = (FP+FN)/n;
Specificity = TN/(TN+FP);
set(handles.edit13,'String', Specificity);

% Sensitivity = TP/(TP+FN);


% --- Executes on button press in button_sens.
function button_sens_Callback(hObject, eventdata, handles)
% hObject    handle to button_sens (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load circFeatureB;
X = circFeatureB.features;
Y = circFeatureB.label;
Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
predictedY = resubPredict(Mdl);
tpY = {'Benign'};

tnY = {'Malignant'};

tppY = {'Benign'};

tnpY = {'Malignant'}
TP = 0;TN =0;FP=0;FN=0;
for i=1:size(Y,1)
  A = strcmpi(Y{i},tpY);
  B = strcmpi(Y{i},tnY);
  
  if(A==1)
      C = strcmpi(predictedY{i},tpY);
      if(C ==1)
      TP=TP+1;
      else
          FN =FN+1;
      end
  elseif(B==1)
      D = strcmpi(predictedY{i},tnY);
      if(D==1)
      TN=TN+1;
      else
          FP =FP+1;
      end
      
  end
    
end

TP= TP;
TN =TN;
n = size(Y,1);
ER = (FP+FN)/n;
Sensitivity = TP/(TP+FN);

set(handles.edit12,'String', Sensitivity);



function edit8_Callback(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit8 as text
%        str2double(get(hObject,'String')) returns contents of edit8 as a double


% --- Executes during object creation, after setting all properties.
function edit8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit9_Callback(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit9 as text
%        str2double(get(hObject,'String')) returns contents of edit9 as a double


% --- Executes during object creation, after setting all properties.
function edit9_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when entered data in editable cell(s) in uitable2.
function uitable2_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable2 (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton30.
function pushbutton30_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double


% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in btn_selectfolder.
function btn_selectfolder_Callback(hObject, eventdata, handles)
% hObject    handle to btn_selectfolder (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
folder_name = uigetdir;
handles.myVar = folder_name;
guidata(hObject, handles);
set(handles.text5,'visible','on');
set(handles.edit7,'visible','on');
pause(7);
str =get(handles.edit7, 'String');  
handles.inputClass = str;
guidata(hObject, handles);


% --- Executes on button press in pushbutton35. classification
function pushbutton35_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 B = handles.I2;
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
    %bw = im2bw(I2);
    bw = im2bw(I2);
    [m,n] = size(bw);
    b = 0;
    bw = imcomplement(bw);
    P = regionprops(bw,'Perimeter');
C = vertcat(P.Perimeter);
peri = max(C);

AreaObj = regionprops(bw,'Area');


C = vertcat(AreaObj.Area);
 AR = max(C);
    
    
     [elong,compact,convex] = NumCir(bw);

    [tracks,sectors] = KmeansCl(elong,compact,convex);                  
               
   [r,R_x,R_y,ym2,xm2] = RadiusFind(bw);

%  plot(R_x,R_y,'r*','MarkerSize',25);
[nim,m,n] = rotangle(ym2,R_y,R_x,xm2,bw);
 
w = 1;
      for i = 1:m
        for j = 1:n
            if(nim(i,j)==1) 
               
                r(w,1) =i;
                r(w,2) = j;
                          % took all 1's in r      
                w = w+1;  
                b = b+1;
 
            end
            
        end
      end
         c = 1;
    [m,n] = size(r);   
    p=1;
    a = 1;
    mx = 0;
  for p = 1:m   % for finding the diameter : distance between one point to all other points
     x1=r(p,1);
     y1= r(p,2);
  
     for i =1:m
        x2 = r(i,1);
        y2 =r(i,2);
        if(x1 == x2 && y1 == y2)
            break;
        
        else
            
              X = [x1,y1;x2,y2]; 
              r1(c) =pdist(X);
              
            if(r1(c)>mx)
                mx=r1(c);
                xm1 = x1;
                ym1 = y1;
                xm2 = x2;
                ym2 = y2;
                
                
            end
            c = c+1;
       end
     end
     exist r1;
    if(ans == 1)
      c = 1;
      a = a+1;
    
    else
    end
  end      
 diameter = mx;
 radius = diameter/2;
 CD = [ym1,xm1;ym2,xm2];
 xm = [ym1,xm1];
 ym = [ym2,xm2];
 rad =    [(ym1+ym2)/2, (xm1+xm2)/2];  
 R_x = rad(1,1);
 R_y = rad(1,2);
 centers = [R_x,R_y];
%  plot(R_x,R_y,'r*','MarkerSize',25);
 xx1=R_x;
 yy1=R_y;
 num1=1; 
 % generation (circular mesh generayion = drawtracks+plotsector)
% [xx,yy,rt,sectorcord] = generation(track,radius,nim,R_x,R_y,sector,yy1,xx1,num1);
% drawtracks 
%========================
centers = [R_x,R_y];
hold on;
axis on;
hold on;
nm1=1;
[l11,l22]=size(nim);
s = regionprops(nim,'centroid');
xx=round(s(1).Centroid(1));
yy=round(s(1).Centroid(2));
for ii=1:l11
    for jj=1:l22
        if(nim(ii,jj)==1) 
            cy2(nm1)=jj;
            cx1(nm1)=ii;
            nm1=nm1+1;
        end   
    end
end
pi=3.14;
area=pi*radius*radius;
Area_Ring=area/tracks; 
for i=1:tracks
rt(i)=(Area_Ring*i)/pi;
rt(i)=sqrt(rt(i));
rt = round(rt);
rt = rt'; % transpose
%   viscircles(centers,rt(i));
end
%================================

% plot sector
%==============================
for aa=1:size(nim,1)
    for bb=1:size(nim,2)
        if(nim(aa,bb)==1) 
             XX = [ yy1 xx1;bb aa];
             ds(num1) = pdist(XX,'euclidean');
             dx1(num1)=aa;
             dx2(num1)=bb;
             flag=0;
       for nt=1:tracks
        if(ds(num1)<rt(1))
            trackn(num1)=1;
            flag=1;
            break;
        end
        if(nt~=tracks && ds(num1)>rt(nt)&&ds(num1)<rt(nt+1))
            trackn(num1)=nt+1;
            flag=1;
            break;
        end
        if(flag==0)
            trackn(num1)=10;
        end  
       end
       num1=num1+1;
        end   
    end
end
A=[xx,xx+rt(tracks)];
B=[yy,yy];
angl=360/sectors;
%plot sector
for i=1:sectors
sectorcord(i,1)=R_x+(rt(tracks)*sind(angl*i));
sectorcord(i,2)=R_y+(rt(tracks)*cosd(angl*i));
end 

[cxx,cyy] = CCLabel(xx,yy,sectorcord,sectors,nim,mx,R_y); % labelling circular mesh
[Trk,sec,secangle] = CMRepDes(cxx,cyy,R_x,R_y,rt,sectors);

%%  Counting Track Values and Sector Values
  
 [TrkVar,TrkOcc,SecVar,SecOcc,Trkin,Secin,PeakValley,NormalizedValue,indices,cxxN,cyyN] = CountTrckSec(Trk,sec,cxx,cyy);


%% Label Properties  

[AvgNegSeci,NumNegSeci,AvgZeroTrki,NumTrkZero,RatioSTrkVarSTrk,STrkOcc,RatioMTrkOccSTrkVar,RatioSSecVarSSec,RatioSTrkVarSSecVar,OneSeci,OneSecSSec] = labelprops(TrkVar,Trk,sec,SecVar,TrkOcc,SecOcc);
            
 %% Symmetric Deviation
 [SDT_0_360,SDT_40_140,SDT_320_40,SDT_140_220,CoeffVarT_0_360,CoeffVarT_40_140,CoeffVarT_220_320,CoeffVarT_320_40,CoeffVarT_140_220,Deviation_Symmetry_0_90,Deviation_Symmetry_0_180]= symmetrydevi(Trk,secangle);
 
 
   %%
 [RatioCirPerObjPer] = structuralfor(peri,AR,cxx,cyy,R_x,R_y);

%% Convexity and Convavity Detection Algorithm  
 
        [NumSplo,AvgNumEleAtPeak] = convexcavdet(TrkVar,SecVar,NormalizedValue,cxxN,cyyN);
          %[PeakValleyNew,NumSplo,AvgNumEleAtPeak] = PeakNoNorm(TrkPt,PeakValley,SecPt,cxx,cyy) ;   
      [l m] = size(TrkVar);  
      [k j] = size(SecVar);
        
   F =  [RatioCirPerObjPer,RatioSTrkVarSTrk,l,Deviation_Symmetry_0_180,Deviation_Symmetry_0_90,SDT_0_360,SDT_320_40,SDT_40_140,RatioSSecVarSSec,AvgZeroTrki,RatioSTrkVarSSecVar,OneSecSSec,CoeffVarT_0_360,SDT_140_220,k,CoeffVarT_40_140,RatioMTrkOccSTrkVar,CoeffVarT_140_220,AvgNegSeci,NumSplo,AvgNumEleAtPeak];

 circFeatureB  = load('circFeatureB.mat');
    circFeatureB = circFeatureB.circFeatureB;
    trainedData = circFeatureB.features;
    groups = circFeatureB.label;   

    
    
    X = circFeatureB.features;
    Y = circFeatureB.label;
    
    
%     set(handles.edit3,'String', label);
    Mdl = fitcknn(X,Y,'NumNeighbors',5,'Standardize',1);
    label = predict(Mdl,F);
%     h = msgbox(label,'Result');
%     th = findall(h, 'Type', 'Text');        %Get the handle to the text within the box
%     msgString = th.String{:};
%     h.text_output.String = msgString; 
set(handles.txt_output,'visible','on');
   set(handles.txt_output,'String', label);
