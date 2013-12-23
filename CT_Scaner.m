% Author: Jinxin Yang
% Function: CT_Scaner GUI
function varargout = CT_Scaner(varargin)
% CT_SCANER MATLAB code for CT_Scaner.fig
%      CT_SCANER, by itself, creates a new CT_SCANER or raises the existing
%      singleton*.
%
%      H = CT_SCANER returns the handle to a new CT_SCANER or the handle to
%      the existing singleton*.
%
%      CT_SCANER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CT_SCANER.M with the given input arguments.
%
%      CT_SCANER('Property','Value',...) creates a new CT_SCANER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CT_Scaner_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CT_Scaner_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CT_Scaner

% Last Modified by GUIDE v2.5 03-Dec-2013 19:24:49

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @CT_Scaner_OpeningFcn, ...
    'gui_OutputFcn',  @CT_Scaner_OutputFcn, ...
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


% --- Executes just before CT_Scaner is made visible.
function CT_Scaner_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CT_Scaner (see VARARGIN)

%temp for debugging
set(handles.process, 'Enable', 'On');

% default values in the GUI
handles.ps = 1; % add_circular
handles.x_val = int32(0);
handles.y_val = int32(0);
handles.r_val = int32(0);
handles.oc = 0.3;

% add rectangular
%(X,Y), left_top, same as cicular center point
%(X',Y'), right_bottom, get from r_val, will be set when change the ps
handles.x_prime = int32(0);
handles.y_prime = int32(0);

% check flag
handles.flag = 0;

% default gray background with a big white circle: canvas
img = canvas;
handles.origin = img;
handles.current_data = img;
imshow(img);

%r_value_Callback(handles.r_value, eventdata, handles);

% Choose default command line output for CT_Scaner
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes CT_Scaner wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CT_Scaner_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in process.
function process_Callback(hObject, eventdata, handles)
% hObject    handle to process (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% this is for phsycis
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
old_img = handles.current_data;
%tmp_img = old_img.';
%save tmp_img.txt -ascii tmp_img;

% by default, set NT = 3, Anginc = 5, Probe = 1
% and these three parameters will be configured in the result GUI
NT = 3; % number of transducers
Anginc = 5; % angular increment
Probe = 1; % Type of transducer

new_img = CT_JustForFun3vP(old_img, NT, Anginc, Probe);%handles.current_data;


result(old_img.', new_img.', NT, Anginc, Probe);


set(hObject, 'Enable', 'off');

if handles.ps == 2
    set(handles.config_panel, 'Visible', 'off');
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% this is lame... but really efficient!!!
close(gcbf);
CT_Scaner;

% --- Executes on button press in phantom_style.
function phantom_style_Callback(hObject, eventdata, handles)
% hObject    handle to phantom_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of phantom_style
set(handles.generate_phantom, 'Enable', 'off');

set(handles.x_value, 'String', '0');
set(handles.y_value, 'String', '0');
set(handles.object_color, 'String', '0.3');
handles.x_val = int32(0);
handles.y_val = int32(0);
handles.oc = 0.3;

ps_val = get(hObject,'Value');
ps_str = get(hObject,'String');

switch ps_str{ps_val}
    case 'Circular'    % user select to add a Circular: 1
        handles.ps = int32(1);
        
        set(handles.radius, 'String', 'R');
        set(handles.r_value, 'String', '0');
        set(handles.r_value, 'Max', 1);
        
        % default values in the GUI R -> C
        handles.r_val = int32(0);
        
    case 'Rectangular' % user select to add a Rectangular: 0
        handles.ps = int32(0);
        
        % change R to right_bottom coordinates (X', Y') and initialized
        set(handles.radius, 'String', ['X''';'Y''']);
        set(handles.r_value, 'Max', 2);
        set(handles.r_value, 'String', ['0';'0']);
        
        % default values in the GUI C -> R
        handles.x_prime = int32(0);
        handles.y_prime = int32(0);
    case 'Matlab' % Matlab default phantom
        handles.ps = int32(2);
        
        set(handles.set_panel, 'Visible', 'off');
        set(handles.generate_phantom, 'Enable', 'on');
end
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function phantom_style_CreateFcn(hObject, eventdata, handles)
% hObject    handle to phantom_style (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in generate_phantom.
function generate_phantom_Callback(hObject, eventdata, handles)
% hObject    handle to generate_phantom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


global PhantomSize;
PhantomSize = 420;

img = handles.current_data;
handles.origin = img;

if handles.ps == 2
    img = phantom('Modified Shepp-Logan', PhantomSize);
end

if handles.flag == 1
    if handles.ps == 1
        img = add_circular(img, handles.y_val, handles.x_val, handles.r_val, handles.oc);
    end
    
    if handles.ps == 0
        img = add_rectangular(img, handles.x_val, handles.y_val, handles.x_prime, handles.y_prime, handles.oc);
    end
end
imshow(img.'); % suppose not to be transposed, but just for convenience
%hold on;
handles.current_data = img;

% success, then enable Process
handles.flag = 0;
set(hObject, 'Enable', 'off');
set(handles.process, 'Enable', 'on');

guidata(hObject, handles);




function x_value_Callback(hObject, eventdata, handles)
% hObject    handle to x_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of x_value as text
%        str2double(get(hObject,'String')) returns contents of x_value as a double
set(handles.generate_phantom, 'Enable', 'off');

handles.x_val = int32(str2double(get(hObject,'String')));
%handles.x_handle = hObject; % this is just for test how to return the handle

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function x_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to x_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function y_value_Callback(hObject, eventdata, handles)
% hObject    handle to y_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of y_value as text
%        str2double(get(hObject,'String')) returns contents of y_value as a double
set(handles.generate_phantom, 'Enable', 'off');

handles.y_val = int32(str2double(get(hObject,'String')));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function y_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to y_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in add_object.
function add_object_Callback(hObject, eventdata, handles)
% hObject    handle to add_object (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check the parameters, if valid, enable Generate

if handles.ps == 1 % check circular
    check_flag = check_cir(handles.x_val, handles.y_val, handles.r_val);
else % check rectangular
    check_flag = check_rec(handles.x_val, handles.y_val, handles.x_prime, handles.y_prime);
end

if (check_flag)
    handles.flag = 1;
    set(handles.generate_phantom, 'Enable', 'on');
else
    uiwait(msgbox('Invalid parameters, use top left cursor + to locate','Error','Warn','modal'));
end

guidata(hObject, handles);



function r_value_Callback(hObject, eventdata, handles)
% hObject    handle to r_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r_value as text
%        str2double(get(hObject,'String')) returns contents of r_value as a double
set(handles.generate_phantom, 'Enable', 'off');

if handles.ps == 1
    handles.r_val = int32(str2double(get(hObject,'String')));
else
    xy_prime = get(hObject,'String');
    %n_rows = size(xy_prime,1);
    handles.x_prime = int32(str2double(xy_prime(1,:)));
    handles.y_prime = int32(str2double(xy_prime(2,:)));
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function r_value_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r_value (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function object_color_Callback(hObject, eventdata, handles)
% hObject    handle to object_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of object_color as text
%        str2double(get(hObject,'String')) returns contents of object_color as a double
set(handles.generate_phantom, 'Enable', 'off');

handles.oc = str2double(get(hObject,'String'));

guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function object_color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to object_color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
