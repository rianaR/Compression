

% returns : matrix containing the macroblock and their position
function [macroblock, macroblock_positions] = toMacroblocks(image, blocSize)

    imaged = double(image);    
    [m,n] = size(imaged);

    % Initialization of the return values
    macroblock = zeros(blocSize,blocSize,1);
    macroblock_positions = zeros(1,2,1);

    % hypermatrix index
    index = 1;
    
    % Iterate on the lines, then on the colum
    for i=1:blocSize:m 
        for j = 1:blocSize:n
            % extract a block
            imageBlock = imaged(i:i+(blocSize-1), j:j+(blocSize-1));
            % store block data in hypermatrix
            macroblock(:,:,index) = imageBlock;
            % store block coordinates (upper left corner)
            macroblock_positions(:,:,index) = [i,j];
            index = index +1;
        end
    end
end