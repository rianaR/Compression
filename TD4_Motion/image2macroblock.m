% returns : an hypermatrix containing macroblocks
%           an hypermatrix containing the blocks positions
function [macroblock, macroblock_positions] = image2macroblock(img, BLOCK_SIZE)

    imgd = double(img);    
    [m,n] = size(imgd);

    % Initializing our two hypermatrices
    macroblock = zeros(BLOCK_SIZE,BLOCK_SIZE,1);
    macroblock_positions = zeros(1,2,1);

    % hypermatrix index
    index = 1;
    % Loop on blocks
    for i=1:BLOCK_SIZE:m % lines
        for j = 1:BLOCK_SIZE:n % cols
            % extract a block
            imgBlock = imgd(i:i+(BLOCK_SIZE-1), j:j+(BLOCK_SIZE-1));
            % store block data in hypermatrix
            macroblock(:,:,index) = imgBlock;
            % store block coordinates (upper left corner)
            macroblock_positions(:,:,index) = [i,j];
            index = index +1;
        end
    end
end