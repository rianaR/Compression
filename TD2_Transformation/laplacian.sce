

img = double(imread("images/lena.jpg"));
matrixSize= size(img,1);
sigma=1;


//function [tRow] = gaussianfilter(x,y,sigma)
  //  tRow = (1/(2*%pi*sigma*sigma)*exp(-(x*x+y*y)/(2*sigma*sigma));
//endfunction


gaussMatrix = [1,2,1;2,4,4;1,2,1]/16;
//F = fspecial('gaussian',matrixSize,sigma);

lenaFiltred = conv2(img,gaussMatrix);

//imshow(lenaFiltred/255);
lenaResized = imresize(lenaFiltred,[257 257]);

imshow(fullLena/255);

