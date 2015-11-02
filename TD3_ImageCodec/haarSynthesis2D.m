function [synth] = haarSynthesis2D(transform, level)
    %synth : image which is reconstructed at each iteration
    synth=transform;
    
    %To iterate from highest to lowest level
    levels = 1:level;
    invertedLevels = levels(end:-1:1);
    for l = invertedLevels
        rowDimFilter = size(transform, 1)/(2^(l-1));
        colDimFilter = size(transform, 2)/(2^(l-1));
        
        %Synthesis on columns
        synthImg1 = zeros(size(rowDimFilter,colDimFilter));
        for i = 1:colDimFilter
            synthImg1(:,i) = haarSynthesisRow(synth(1:rowDimFilter,i)')';
        end
        disp(size(synthImg1));
        
        %Synthesis on rows
        synthImg2=zeros(size(rowDimFilter,colDimFilter));
        for i = 1:rowDimFilter
            synthImg2(i,:) = haarSynthesisRow(synthImg1(i,1:colDimFilter));
        end
        
        %Storing reconstructed image
        synth(1:rowDimFilter, 1:colDimFilter)=synthImg2;
    end
end

function [sRow] = haarSynthesisRow(row)
    halfRow = size(row,2)/2;
    sRow=zeros(size(row));
    for i = 1:halfRow
        sRow(2*i - 1) = row(i)+row(halfRow+i);
        sRow(2*i) = row(i)-row(halfRow+i);
    end
end