%作者：陈超
%学号：10213053

%**********************MATLAB仿真DTMF信号的生成与解码**************************
%这是一个在GUIDE工具自动生成图形界面的基础上添加自写功能函数形成的.m文件
%文件必须与对应的.fig文件一起运行

%*************前几个函数为自动成功关于图形界面的函数，自编写的功能函数在后面**************


function varargout = DTMF(varargin)
% DTMF MATLAB code for DTMF.fig
%      DTMF, by itself, creates a new DTMF or raises the existing
%      singleton*.
%
%      H = DTMF returns the handle to a new DTMF or the handle to
%      the existing singleton*.
%
%      DTMF('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DTMF.M with the given input arguments.
%
%      DTMF('Property','Value',...) creates a new DTMF or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DTMF_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DTMF_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DTMF

% Last Modified by GUIDE v2.5 14-May-2013 20:33:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DTMF_OpeningFcn, ...
                   'gui_OutputFcn',  @DTMF_OutputFcn, ...
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


% --- Executes just before DTMF is made visible.
function DTMF_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DTMF (see VARARGIN)

% Choose default command line output for DTMF
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DTMF wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DTMF_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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



%*******************************************************************************
%*******************************************************************************
%*******************************************************************************
%*********************以上函数为GUIDE自动生成的关于图形界面的函数******************
%*******************************************************************************
%*********************以下函数为自己编辑函数**************************************
%*******************************************************************************
%*******************************************************************************
%*******************************************************************************



%********************************显示一个字符的波形*********************************************
%当按钮被按下，函数读取按钮信息，在edit1显示框中追加字符，并显示该字符对应的波形图与频谱图。
% --- Executes on button press in pushbutton1.
function pushbutton_Callback(hObject, ~, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.edit2,'Visible','off');

%添加显示
set(handles.edit1,'String',strcat(get(handles.edit1,'String'),get(hObject,'String')));

%生成信号序列
[a,b]=generate(get(hObject,'String'));

%显示前0.05s的波形
axes(handles.axes1);
plot(b,a);
axis([0,0.05,-2,2]);grid

%fft变换
y=fft(a,512); %只有400个点，添0做512点的FFT。
mag=abs(y);
f=[1:512]*8000/512;

%显示频域信号
axes(handles.axes2);
stem(f,mag);
axis([500,2000,0,200]);grid

%发声
p=audioplayer(a,8000);
play(p);
pause(0.5);



%*******************************清空屏幕*************************************
% --- Executes on button press in pushbutton17.
function clc_Callback(~, ~, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.edit1,'String','');
cla(handles.axes1);
cla(handles.axes2);
set(handles.edit2,'Visible','off');


%****************************显示整个电话号码串的波形****************************************
% --- Executes on button press in pushbutton18.
function gs_Callback(~, ~, handles)
% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%获取拨号序列 
list=get(handles.edit1,'String');

%每个信号持续0.05s，就是400个点
%每个信号后跟随一段空信号，也是0.05s，400个点。
%所以整个数据长度为400*2*电话号码长度。 
stream=zeros(1,length(list)*400*2);     %预建立空序列。

for i=1:length(list)                 %对于每个拨号号码，做以下操作
   [a,~]=generate(list(i));         %生成离散信号
    for j=1:400                       %先把一个拨号的序列存进去
       stream(j+(i-1)*2*400)=a(j);
    end
    [a,~]=generate('gap'); 
    for j=1:400                       %再把间隔的空信号序列存进去
       stream(j+(i-1)*2*400+400)=a(j);
    end
end
t=(1:length(list)*400*2)/8000;        %信号的横坐标——时间

%将时域信号图打印在axes1上
axes(handles.axes1);
plot(t,stream);

%生成fft
y=fft(stream,length(list)*400*2);
mag=abs(y);
f=[1:length(list)*400*2]*8000/(length(list)*400*2);

%将频域信号打印在axes2上
axes(handles.axes2);
plot(f,mag);
axis([500,1800,0,ceil(max(mag)/200)*200]);grid %只显示特定的频段

%将声音保存为wav文件
wavwrite(stream,8000,'Dial.wav');

%显示提示保存成功
set(handles.edit2,'String','Signal stored in Dial.wav');
set(handles.edit2,'Visible','on');
pause(1.5);
set(handles.edit2,'Visible','off');



%*******************************生成一个字符的波形********************************************
%函数输入String形式的按钮标示，返回相应的离散信号和离散时间序列。
%返回的是采样频率为8kHz，采样时间为500ms的离散信号。
function [a,b] = generate(text)
  Fs=8000;            %采样频率为8kHz， 即采样周期为1/8000s。
  t=(1:400)/Fs;      %信号持续时间为50ms。采样400个点。
  pit=2*pi*t;         %算子
  
  %根据不同的按键，确定不同的高、低频率。
  if(strcmp(text,'1'))
    fl=697;
    fh=1209;
  elseif (strcmp(text,'2'))
    fl=697;
    fh=1336;
  elseif (strcmp(text,'3'))
    fl=697;
    fh=1477;  
  elseif (strcmp(text,'4'))
    fl=770;
    fh=1209;  
  elseif (strcmp(text,'5'))
    fl=770;
    fh=1336;
  elseif (strcmp(text,'6'))
    fl=770;
    fh=1477;  
  elseif (strcmp(text,'7'))
    fl=852;
    fh=1209;  
  elseif (strcmp(text,'8'))
    fl=852;
    fh=1336;
  elseif (strcmp(text,'9'))
    fl=852;
    fh=1477;  
  elseif (strcmp(text,'0'))
    fl=941;
    fh=1336;
   elseif (strcmp(text,'*'))
    fl=941;
    fh=1209;  
  elseif (strcmp(text,'#'))
    fl=941;
    fh=1477;
  elseif (strcmp(text,'A'))
    fl=697;
    fh=1633; 
  elseif (strcmp(text,'B'))
    fl=770;
    fh=1633;
  elseif (strcmp(text,'C'))
    fl=852;
    fh=1633;
  elseif (strcmp(text,'D'))
    fl=941;
    fh=1633;
  elseif(strcmp(text,'gap'))
    fl=0;
    fh=0;
  end
  
  %生成波形
  y=sin(fl*pit);
  x=sin(fh*pit);
  a=x+y;
  b=t;



%************************************解码文件*****************************************
%函数读取音频文件，解码并显示其时域、频域波形与电话号码。
% --- Executes on button press in pushbutton19.
function decode_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
%读取音频文件
[y,fs,nbits]=wavread(get(handles.edit3,'String'));

%音频的时间序列
 t=[1:length(y)]/fs;
 
%打印时域信号
 axes(handles.axes1);
 plot(t,y);
 axis([0,length(y)/fs,-1.5,1.5]);grid;

 %fft变换
 a=fft(y,length(y));
 mag=abs(a);
 f=[1:length(y)]*8000/(length(y));
 
 %打印频域信号
 axes(handles.axes2);
 plot(f,mag);
 axis([500,1800,0,ceil(max(mag)/200)*200]);grid;
 
 
 %#####以下对音频进行解码#####
 
 n=length(y)/800;
 r=zeros(4*n,64);
 c=zeros(54*n,64);
 for s=1:4*n
     R=y((200*(s-1)+1):(200*s));
   
     g=fft(R,256);
     c(s,:)=abs(g(1:64));
     r(s,:)=c(s,:);
     z=find(c(s,:)<50); %************************************阀值定位50
  
     c(s,z)=zeros(size(z));
 end
 sm=[31 44;23 40;23 44;23 48;26 40;26 44;26 48;28 40;28 44;28 48;23 53;26 53;28 53;31 53;31 40;31 48];
 for i3=1:4*n
    b=nnz(c(i3,:));
    if b==2
        q1=find(c(i3,:));
        for i4=1:16     
            if q1==sm(i4,:)
                AN(i3)=i4-1;
                break;
            end
        end
    else 
        AN(i3)=NaN;
    end
 end
 
 %生成的序列中，每四位号码中，前两位为相同的号码，后两位为空号码。因此只要四取一就行。
 for i7=1:length(AN)/4
     switch(AN((i7-1)*4+1))
         case 1
             str(i7)='1';
         case 2
             str(i7)='2';            
         case 3
             str(i7)='3';            
         case 4
             str(i7)='4';
         case 5
             str(i7)='5';
         case 6
             str(i7)='6';
         case 7
             str(i7)='7';
         case 8
             str(i7)='8';
         case 9
             str(i7)='9';
         case 0
             str(i7)='0';
         case 10
             str(i7)='A';
         case 11
             str(i7)='B';
         case 12
             str(i7)='C';
         case 13
             str(i7)='D';
         case 14
             str(i7)='*';
         case 15
             str(i7)='#';
         otherwise
             str(i7)='X';
     end
 end
 
 %显示提示被解码的号码
 set(handles.edit2,'String','The number is:');
 set(handles.edit2,'Visible','on');
 set(handles.edit1,'String',str);
 
 %发声
 wavplay(y,8000);
