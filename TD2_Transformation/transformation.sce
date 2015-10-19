function [tRow] = haarTransformRow(row)
    //Low pass filter
    f1 = [0.5 0.5];
    tRow1 = conv2(row, f1, "same");
    //Downsampling
    tRow1 = tRow1(2:2:length(tRow1));
    
    //High pass filter
    f2 = [-0.5 0.5];
    tRow2 = conv2(row, f2, "same");
    //Downsampling
    tRow2 = tRow2(2:2:length(tRow2));
    
    //Concatenation of averages and differences
    tRow = [tRow1 tRow2];
endfunction

function [transform] = haarTransform2D(img, level)
    transform=img;
    
    for l = 1:level
        rowDimFilter = size(transform, 1)/(2^(l-1));
        colDimFilter = size(transform, 2)/(2^(l-1));
        
        filtImg=[];
        for i = 1:rowDimFilter
            filtImg = [filtImg; haarTransformRow(transform(i,1:colDimFilter))];
        end
        filtImg2 = [];
        for i = 1:colDimFilter
            filtImg2 = [filtImg2 haarTransformRow(filtImg(1:rowDimFilter,i)')'];
        end
        transform(1:rowDimFilter, 1:colDimFilter)=filtImg2;
    end
endfunction

lena = double(rgb2gray(imread("images/Baboon.jpg")));
fLena = haarTransform2D(lena, 2);
figure; ShowImage(abs(fLena/255), "filtered Lena");
