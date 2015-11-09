% image has to be double
function [macthingBlock, vectors] = matchingBlock(img,p, block, blockx, blocky)
    
    % Size of a block
    BlockSize = size(block,1);
    [m,n] = size(img);
    
    % defining de search area
    xmin = blockx - p;
    ymin = blocky - p;
    xmax = blockx + BlockSize + p;
    ymax = blocky + BlockSize + p;


    % position of the best matching block
    bestBlockPosition = [ -1, -1 ];
    
    % Initializing to a high value
    tempError = 5000000;
    
    
    
    % image limits
    if xmin < 1
        xmin = 1;
    end
    if ymin < 1
        ymin = 1;
    end
    if (xmax+BlockSize-1) > n-1
        xmax = n-1-BlockSize;
    end
    if (ymax+BlockSize-1) > m-1
        ymax = m-1-BlockSize;
    end
    
    
    for i = xmin:xmax
        for j = ymin:ymax

            generatedBlock = img(i:i+BlockSize-1, j:j+BlockSize-1);

            
            temp_error = MSE(generatedBlock, block);

            
            if temp_error < tempError
                
                tempError = temp_error;
                bestBlockPosition = [i, j];
            end

        end
    end
    % final values
    macthingBlock = bestBlockPosition;
    vectors = [ bestBlockPosition(1)-blockx, bestBlockPosition(2)-blocky];

end