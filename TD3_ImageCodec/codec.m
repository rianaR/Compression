close all; clear all;

baboon = imread('images/lena.jpg');
figure; imshow(baboon);

fBaboon = haarTransform2D(baboon, 2);
figure; imshow(uint8(fBaboon));