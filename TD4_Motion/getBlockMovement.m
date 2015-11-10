% image has to be double
function [vectors] = getBlockMovement(img,p, block, block_i, block_j)
    
    % Size of a block
    BlockSize = size(block,1);
    [m,n] = size(img);
    
    % defining de search area
    linesMin = block_i - p;
    columnsMin = block_j - p;
    linesMax = block_i + BlockSize + p;
    columnsMax = block_j + BlockSize + p;


    % position of the best matching block
    bestBlockPosition = [ -1, -1 ];
    
    % Initializing to a high value
    minError = 5000000;
    
    
    
    % image limits
    if linesMin < 1
        linesMin = 1;
    end
    if columnsMin < 1
        columnsMin = 1;
    end
    if (linesMax+BlockSize-1) > m-1
        linesMax = m-1-BlockSize;
    end
    if (columnsMax+BlockSize-1) > n-1
        columnsMax = n-1-BlockSize;
    end
    
    
    for i = linesMin:linesMax
        for j = columnsMin:columnsMax
            generatedBlock = img(i:i+BlockSize-1, j:j+BlockSize-1);           
            
            temp_error = MSE(generatedBlock, block);      
            if temp_error < tempError
                tempError = temp_error;
                bestBlockPosition = [i, j];
            end

        end
    end
    vectors = [ bestBlockPosition(1)-block_i, bestBlockPosition(2)-block_j];

end