function [tRow] = haarTransformRow(row)
    //Low pass filter
    f1 = [0.5 0.5];
    tRow1 = conv2(row, f1, "same");
    //Downsampling
    tRow1 = tRow1(1:2:length(tRow1)-1);
    
    //High pass filter
    f2 = [-0.5 0.5];
    tRow2 = conv2(row, f2, "same");
    //Downsampling
    tRow2 = tRow2(1:2:length(tRow2)-1);
    
    //Concatenation of averages and differences
    tRow = [tRow1 tRow2];
endfunction

function [transform] = haarTransform2D(img, level)
    //transform : image which is transformed at each iteration
    transform=img;
    
    for l = 1:level
        //where to apply the Haar transform at each iteration
        rowDimFilter = size(transform, 1)/(2^(l-1));
        colDimFilter = size(transform, 2)/(2^(l-1));
        
        //Transformations on rows
        filtImg=[];
        for i = 1:rowDimFilter
            filtImg = [filtImg; haarTransformRow(transform(i,1:colDimFilter))];
        end
        
        //Transformation on columns
        filtImg2 = [];
        for i = 1:colDimFilter
            filtImg2 = [filtImg2 haarTransformRow(filtImg(1:rowDimFilter,i)')'];
        end
        
        //We modify the upper-left part of the final image
        transform(1:rowDimFilter, 1:colDimFilter)=filtImg2;
    end
endfunction

function [sRow] = haarSynthesisRow(row)
    halfRow = size(row,2)/2;
    sRow=[];
    for i = 1:halfRow
        toAdd = [row(i)+row(halfRow+i) row(i)-row(halfRow+i)];
        sRow = [sRow toAdd];
    end
endfunction

function [synth] = haarSynthesis2D(transform, level)
    //synth : image which is reconstructed at each iteration
    synth=transform;
    
    //To iterate from highest to lowest level
    levels = 1:level;
    invertedLevels = levels($:-1:1);
    for l = invertedLevels
        rowDimFilter = size(transform, 1)/(2^(l-1));
        colDimFilter = size(transform, 2)/(2^(l-1));
        
        //Synthesis on columns
        synthImg1 = [];
        for i = 1:colDimFilter
            synthImg1 = [synthImg1 haarSynthesisRow(synth(1:rowDimFilter,i)')'];
        end
        disp(size(synthImg1));
        
        //Synthesis on rows
        synthImg2=[];
        for i = 1:rowDimFilter
            synthImg2 = [synthImg2; haarSynthesisRow(synthImg1(i,1:colDimFilter))];
        end
        
        //Storing reconstructed image
        synth(1:rowDimFilter, 1:colDimFilter)=synthImg2;
    end
    
endfunction

baboon = double(rgb2gray(imread("images/Baboon.jpg")));
figure; ShowImage(abs(baboon/255), "original Baboon");

fBaboon = haarTransform2D(baboon, 2);;
figure; ShowImage(abs(fBaboon/255), "filtered Baboon");

synthBaboon = haarSynthesis2D(fBaboon, 2);
figure; ShowImage(abs(synthBaboon/255), "reconstructed Baboon");
