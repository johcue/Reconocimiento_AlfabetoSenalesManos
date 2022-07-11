%% Momentos de HU
% Son 7 Numeros que no se pueden ver
% Vamos a hacer un entrenador de Hu
Letras=['A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';...
    'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z'];
n=5;
diccionario=zeros(length(Letras)*n,8);
cont=1;
for i=1:length(Letras)
    for j=1:n
        mano=strcat(Letras(i),num2str(j),'.jpg');
        RGB=imread(mano);
        gray=rgb2gray(RGB);
        bin=~imbinarize(gray);
        [B S] = Mascara_Manos(RGB);
        %B=imfill(B, 'holes');%Para rellenar

        figure(1)
        subplot(2,2,1)
        imshow(RGB)
        title(strcat('Imagen' , mano,' A Color'))
        subplot(2,2,2)
        imshow(gray)
        title(strcat('Imagen' , mano,' En Grises'))
        subplot(2,2,3)
        imshow(bin)
        title(strcat('Imagen' , mano,' Binarizada OTSU'))
        subplot(2,2,4)
        imshow(B)
        title(strcat('Imagen' , mano,' Binarizada con Mascara HSV'))


        M=invmoments(B) %Devuelve 7 números, momentos de HU
        diccionario(cont, :)=[M double(Letras(i))];%Se guarda los codigos de la letra
        cont=cont+1;
        pause(1)



    end
end

%Guardamos el Diccionario
save('PLiccionario.mat', 'diccionario')












