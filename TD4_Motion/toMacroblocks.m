

% returns : matrix containing the macroblock and their position
function [macroblock, macroblock_positions] = toMacroblocks(imaged, blocSize)


    [lineCount,columnCount] = size(imaged);
    % Initialization of the return values
    macroblock = zeros(blocSize,blocSize,1);
    macroblock_positions = zeros(1,2,1);
    matrixIndex = 1;
 
    
    % Iterate on the lines, then on the colum
    for i=1:blocSize:lineCount
        for j = 1:blocSize:columnCount
            % extract a block
            imageBlock = imaged(i:i+(blocSize-1), j:j+(blocSize-1));
            % store block data in hypermatrix
            macroblock(:,:,matrixIndex) = imageBlock;
            % store block coordinates (upper left corner)
            macroblock_positions(:,:,matrixIndex) = [i,j];
            matrixIndex = matrixIndex +1;
        end
    end
    
end

