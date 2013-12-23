% Author: Jinxin Yang
% Parameters: generated phantom and reconstructed phantom

function varargout = result(varargin)
% RESULT MATLAB code for result.fig
%      RESULT, by itself, creates a new RESULT or raises the existing
%      singleton*.
%
%      H = RESULT returns the handle to a new RESULT or the handle to
%      the existing singleton*.
%
%      RESULT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RESULT.M with the given input arguments.
%
%      RESULT('Property','Value',...) creates a new RESULT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before result_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to result_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help result

% Last Modified by GUIDE v2.5 12-Dec-2013 03:26:41

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @result_OpeningFcn, ...
                   'gui_OutputFcn',  @result_OutputFcn, ...
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


% --- Executes just before result is made visible.
function result_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to result (see VARARGIN)

handles.nt = 3;
handles.anginc = 5;
handles.probe = 1.0;

handles.old_input = varargin{1};
handles.img_for_analysis = handles.old_input;

axes(handles.axes_old); hold on;
imagesc(varargin{1});
axes(handles.axes_new); hold on;
imagesc(varargin{2});

% Choose default command line output for result
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes result wait for user response (see UIRESUME)



% --- Outputs from this function are returned to the command line.
function varargout = result_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function nt_val_Callback(hObject, eventdata, handles)
% hObject    handle to nt_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of nt_val as text
%        str2double(get(hObject,'String')) returns contents of nt_val as a double

handles.nt = str2double(get(hObject,'String'));
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function nt_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to nt_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function anginc_val_Callback(hObject, eventdata, handles)
% hObject    handle to anginc_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of anginc_val as text
%        str2double(get(hObject,'String')) returns contents of anginc_val as a double

handles.anginc = str2double(get(hObject,'String'));
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function anginc_val_CreateFcn(hObject, eventdata, handles)
% hObject    handle to anginc_val (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in probe_type.
function probe_type_Callback(hObject, eventdata, handles)
% hObject    handle to probe_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns probe_type contents as cell array
%        contents{get(hObject,'Value')} returns selected item from probe_type

contents = get(hObject,'Value');
probe_str = get(hObject,'String');

switch probe_str{contents}
    case 'arc'
        handles.probe = int32(1);
    case 'linear'
        handles.probe = int32(0);
end

guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function probe_type_CreateFcn(hObject, eventdata, handles)
% hObject    handle to probe_type (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in start_analyze.
function start_analyze_Callback(hObject, eventdata, handles)
% hObject    handle to start_analyze (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

analyze(handles.img_for_analysis, handles.old_input);

% analysis done, set to off
set(hObject, 'Enable', 'off');

% --- Executes on button press in set_def.
function set_def_Callback(hObject, eventdata, handles)
% hObject    handle to set_def (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% reset nt, anginc, probe
set(handles.nt_val, 'Value', 3);
set(handles.nt_val, 'String', '3');
set(handles.anginc_val, 'Value', 5);
set(handles.anginc_val, 'String', '5');
set(handles.probe_type, 'Value', 1.0);

handles.nt = 3;
handles.anginc = 5;
handles.probe = 1.0;

% end

guidata(hObject, handles);

% --- Executes on button press in set_paras.
function set_paras_Callback(hObject, eventdata, handles)
% hObject    handle to set_paras (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if ~( check_num(handles.nt) && check_num(handles.anginc) )
    uiwait(msgbox('Invalid parameters, NT and Anginc should be integer and >0','Error','Warn','modal'));
    set_def_Callback(handles.set_def, eventdata, handles);
else
    reconstructed_img = CT_JustForFun3vP(handles.old_input, handles.nt, handles.anginc, handles.probe);
    handles.img_for_analysis = reconstructed_img;
    set(handles.start_analyze, 'Enable', 'on');
    axes(handles.axes_new); hold on;
    imagesc(reconstructed_img);
end

guidata(hObject, handles);
