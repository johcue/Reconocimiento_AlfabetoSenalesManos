%% Reconocimiento Alfabeto de Señales de Manos
% Restamos los momentos de Hu a cada imagen y el que de menor, pues esa
% será la letra
clc
clear 
close all

load Diccionario
MomentosHU=diccionario(:,1:7);
Clase=diccionario(:,8);

ModelKNN=fitcknn(MomentosHU,Clase,'NumNeighbors', 1, 'Distance', 'euclidean','Standardize',1)

[file path]=uigetfile('*.jpg')
mano=strcat(path,file);

RGB=imread(mano);
gray=rgb2gray(RGB);
bin=~imbinarize(gray);
[B S] = Mascara_Manos(RGB);
B=imfill(B, 'holes');%Para rellenar

% figure(1)
% subplot(2,2,1)
% imshow(RGB)
% title('Imagen A Color')
% subplot(2,2,2)
% imshow(gray)
% title('Imagen En Grises')
% subplot(2,2,3)
% imshow(bin)
% title('Imagen  Binarizada OTSU')
% subplot(2,2,4)
% imshow(B)
% title('Imagen Binarizada con Mascara HSV')
M=invmoments(B); %Devuelve 7 números, momentos de HU

prediction_KNN=char(predict(ModelKNN,M))

















