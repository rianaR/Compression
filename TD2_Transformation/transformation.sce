function [tRow] = haarTransformRow1(row)
    for i = 1:size(row, 2)/2
        trRow(i) = (row(2*i-1)+row(2*i))/2;
        trRow(i+size(row,2)/2) = (row(2*i-1)-row(2*i))/2;
        tRow = trRow';
    end
endfunction

function [tRow] = haarTransformRow2(row)
    f1 = [0.5 0.5];
    tRow1 = conv(row, f1);
    tRow1 = tRow1(2:2:length(tRow1));
    f2 = [-0.5 0.5];
    tRow2 = conv(row, f2);
    tRow2 = tRow2(2:2:length(tRow2));
    tRow = [tRow1 tRow2];
endfunction

A = [88 88 89 90 92 94 96 97];
At1 = haarTransformRow1(A)
At2 = haarTransformRow2(A)
