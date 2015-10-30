function [quantized] = myquantizer(signal, R, min, max)
    L = 2^R;
    delta = double((max-min)/L);
    //intervals = linspace(0,255,2);
    row = 1;
    [nbRows, nbColumns] = size(signal);
    while (row <= nbRows)
        if (nbColumns > 1) then
            col = 1;
            while (col <= nbColumns)
                quantized(row,col) = double(delta*floor(signal(row, col)/delta) + 0.5*delta);
                col=col+1;
            end
        else
            quantized(row) = double(delta*floor(signal(row)/delta) + 0.5*delta);
        end
        row=row+1;
    end
endfunction

//Mean Square Error
function [err] = mse(origImage, quantized)
    err = (origImage - quantized).^2;
    err = sum(err, "double");
    len = double(length(origImage));
    err = err/len;
endfunction

xdel(winsid());
//Input/output characteristic
test = 255*rand(1000, 1,"uniform");
R1 = 3;
quantizedTest = myquantizer(test, R1, 0, 255);
scf(0); plot(test, quantizedTest, 'o')

//Quantizing "Baboon.jpg"
origImage = double(imread("images/lena.jpg"));
for R2=2:6
    quantized = myquantizer(origImage, R2, 0, 255);
    imTitle = "After quantization (R="+string(R2)+")";
    //figure; ShowImage(quantized, imTitle);
end
mseValues = [];
for R = 1:8
    mseValues = [mseValues  mse(origImage, myquantizer(origImage, R, 0, 255))]
end
scf(1); plot2d(1:8, mseValues);


