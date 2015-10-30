xdel(winsid());

function [filtered, laplacianLayers] = laplacianAnalysis(img, nbDecomp)
    //filtering the original image with a Gaussian filter
    gaussianFilter = fspecial('gaussian', 7, 5);
    previousFiltered = double(imfilter(img, gaussianFilter));
    //Construction of Laplacian layers
    laplacianLayers = cell(nbDecomp, 1);
    for i = 1:nbDecomp
        //Downsampling image to filter
        previousResized = imresize(previousFiltered, 0.5);
        //Filtering the image
        filtered = imfilter(previousResized, gaussianFilter);
       
        //Construct a new layer by upsampling the two images and computing the difference
        resize1 = imresize(previousFiltered, size(img));
        resize2 = imresize(filtered, size(img));
        laplacianLayer =  resize1 - resize2;
        laplacianLayers(i).entries = int8(laplacianLayer);
        previousFiltered = filtered;
    end
    
endfunction

function [origImg] = laplacianSynthesis(filtered, laplacianLayers)
    //Size of original image
    origSize = size(laplacianLayers(1).entries);
    origImg = filtered;
    for i=1:size(laplacianLayers, 1)
        //Upsampling the last scale
        upSampled = imresize(origImg, origSize);
        //Addition of the last scale of filtered image and the corresponding laplacian layer 
        origImg = upSampled + laplacianLayers(size(laplacianLayers, 1)-i+1).entries;
    end
endfunction

cameraman = double(imread("images/cameraman"));
[filtered, laplacianLayers] = laplacianAnalysis(cameraman, 3);
figure; ShowImage(filtered, "");
figure; ShowImage(uint8(abs(laplacianLayers(1).entries)), "");
figure; ShowImage(uint8(abs(laplacianLayers(2).entries)), "");
figure; ShowImage(uint8(abs(laplacianLayers(3).entries)), "");
origImg = laplacianSynthesis(filtered, laplacianLayers);
figure; ShowImage(uint8(origImg), "");
