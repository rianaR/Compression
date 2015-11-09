

% 26/10/2015
% TD4 Video Processing
close all;

%*********************************************************************************************
% Here we'll try to reconstruct imgd1 with imgd2 

BLOCK_SIZE = 32;

disp('Loading images...');

reader = VideoReader('videos/walking.mp4');
video = read(reader);

%imgd1 = double(rgb2gray(imread('videos/standingup_00000.jpg')));
%imgd2 = double(rgb2gray(imread('videos/standingup_00015.jpg')));
imgd1 = video(:,:,:,2);
imgd2 = video(:,:,:,3);
imgd1 = imgd1(1:128, 1:128);
imgd2 = imgd2(1:128, 1:128);
imwrite(imgd1, 'videos/walking1.jpg');
imwrite(imgd2, 'videos/walking2.jpg');
disp('Converting to macroblocks...');

[macroblock, positions] = toMacroblocks(double(imgd2), BLOCK_SIZE);

disp('Compression...');

% Petit test
param_p = 50;

[m,n] = size(imgd2);

%todo: doit etre la premiere image : verifier.
% The image reconstructed from imgd1 infos
imgd1_reconstruct = zeros(m,n);

% Loop de reconstruction d'imgd2
for i=1:size(macroblock,3)
    
    % Parce qu'on est pas des sauvages
    fprintf('%1.2f%% \n',i*100/size(macroblock,3));
    
    block = macroblock(:,:,i);
    pos = positions(:,:,i);
    coord_x = pos(1);
    coord_y = pos(2);
    
    
    [bestBlock_coords, movement] = bestCorrespondingBlock(block, coord_x, coord_y, imgd2, param_p);

    new_coord_x = coord_x - movement(2);
    new_coord_y = coord_y - movement(1);
    % todo : commenter tout ca
    % we crop the best imgd2 block corresponding to imgd1
    block_temp = imgd2(bestBlock_coords(1):bestBlock_coords(1)+BLOCK_SIZE-1, bestBlock_coords(2):bestBlock_coords(2)+BLOCK_SIZE-1);
    % We put the block at the right coordinates on our reconstructed image
    imgd1_reconstruct(coord_x:coord_x+BLOCK_SIZE-1, coord_y:coord_y+BLOCK_SIZE-1) = block_temp;
    
end

figure; imshow(uint8(imgd1_reconstruct));
% todo : comparer imgd1 imgd1_reconstruct

% Use the PSNR to measure the dirsotsion of the frame reconstructed

