%%
% 26/10/2015
% TD4 Video Processing
close all;

%*********************************************************************************************
% Here we'll try to reconstruct imgd1 with imgd2 

BLOCK_SIZE = 32;

disp('Loading images...');

reader = VideoReader('videos/planes.mp4');
video = read(reader, [1 20]);
for i=1:20
    img = video(:,:,:,i);
    img = img(513:1024, 300:(300+1023));
    filename = char(['videos/planes',int2str(i),'.jpg']);
    imwrite(img, filename);
end

imgd1 = imread('videos/planes1.jpg');
imgd2 = imread('videos/planes5.jpg');
%%
disp('Converting to macroblocks...');
[macroblock, positions] = toMacroblocks(double(imgd1), BLOCK_SIZE);

disp('Compression...');

% Param�tre p permettant de calculer la largeur de la zone de recherche
param_p = 20;

[m,n] = size(imgd2);

%imgd3 est l'image que l'on va pr�dire
imgd3_recons = zeros(m,n);
% Loop de reconstruction d'imgd2
for i=1:size(macroblock,3)
    %Affichage de l'avancement du matching
    fprintf('%1.2f%% \n',i*100/size(macroblock,3));
    
    %Recup�ration du bloc et de sa position
    block = macroblock(:,:,i);
    pos = positions(:,:,i);
    coord_i = pos(1);
    coord_j = pos(2);
    
    
    [movement] = getBlockMovement(double(imgd2),param_p, block, coord_i, coord_j);
    block_temp = imgd2(coord_i:coord_i+BLOCK_SIZE-1, coord_j:coord_j+BLOCK_SIZE-1);
    new_coord_i = coord_i + movement(1);
    new_coord_i_block = min(new_coord_i+BLOCK_SIZE-1, m);
    new_coord_j = coord_j + movement(2);
    new_coord_j_block = min(new_coord_j+BLOCK_SIZE-1, n);

    imgd3_recons(new_coord_i:new_coord_i_block, new_coord_j:new_coord_j_block) = block_temp;
end

figure; imshow(uint8(imgd3_recons));
% Use the PSNR to measure the dirsotsion of the frame reconstructed
%%
HPSNR = vision.PSNR;
imgd3 = imread('videos/planes9.jpg');
psnr = step(HPSNR,imgd3,uint8(imgd3_recons))
