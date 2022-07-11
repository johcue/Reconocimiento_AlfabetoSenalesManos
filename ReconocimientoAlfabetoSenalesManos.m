function varargout = ReconocimientoAlfabetoSenalesManos(varargin)
% RECONOCIMIENTOALFABETOSENALESMANOS MATLAB code for ReconocimientoAlfabetoSenalesManos.fig
%      RECONOCIMIENTOALFABETOSENALESMANOS, by itself, creates a new RECONOCIMIENTOALFABETOSENALESMANOS or raises the existing
%      singleton*.
%
%      H = RECONOCIMIENTOALFABETOSENALESMANOS returns the handle to a new RECONOCIMIENTOALFABETOSENALESMANOS or the handle to
%      the existing singleton*.
%
%      RECONOCIMIENTOALFABETOSENALESMANOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in RECONOCIMIENTOALFABETOSENALESMANOS.M with the given input arguments.
%
%      RECONOCIMIENTOALFABETOSENALESMANOS('Property','Value',...) creates a new RECONOCIMIENTOALFABETOSENALESMANOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ReconocimientoAlfabetoSenalesManos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ReconocimientoAlfabetoSenalesManos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ReconocimientoAlfabetoSenalesManos

% Last Modified by GUIDE v2.5 07-Jul-2021 16:58:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ReconocimientoAlfabetoSenalesManos_OpeningFcn, ...
                   'gui_OutputFcn',  @ReconocimientoAlfabetoSenalesManos_OutputFcn, ...
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


% --- Executes just before ReconocimientoAlfabetoSenalesManos is made visible.
function ReconocimientoAlfabetoSenalesManos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ReconocimientoAlfabetoSenalesManos (see VARARGIN)



% Choose default command line output for ReconocimientoAlfabetoSenalesManos
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);


% UIWAIT makes ReconocimientoAlfabetoSenalesManos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ReconocimientoAlfabetoSenalesManos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in btnNuevo.
function btnNuevo_Callback(hObject, eventdata, handles)
% hObject    handle to btnNuevo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file path]=uigetfile('*.jpg')
mano=strcat(path,file);
RGB=imread(mano);
set(handles.imgLetra,'Units','pixels');
resizePos = get(handles.imgLetra,'Position');
RGB= imresize(RGB, [resizePos(3) resizePos(3)]);
axes(handles.imgLetra);
imshow(RGB);
set(handles.imgLetra,'Units','normalized');

MomentosHU=load('Diccionario.mat',:,1:7);
Clase=load('Diccionario.mat', :,8);
ModelKNN=fitcknn(MomentosHU,Clase,'NumNeighbors', 1, 'Distance', 'euclidean','Standardize',1)
[B S] = Mascara_Manos(RGB);
B=imfill(B, 'holes');%Para rellenar
M=invmoments(B);
prediction_KNN=char(predict(ModelKNN,M));
prediction_KNN=convertCharsToStrings(get(handles.prediction_KNN, 'String'));
%%%%%%%%%%%%%%%%%%%%%%%%%%%%



            



function editLetra_Callback(hObject, eventdata, handles)
% hObject    handle to editLetra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLetra as text
%        str2double(get(hObject,'String')) returns contents of editLetra as a double

set(handles.editLetra, 'String', prediction_KNN)


% --- Executes during object creation, after setting all properties.
function editLetra_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLetra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
