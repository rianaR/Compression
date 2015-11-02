% returns : the best corresponding block coordinates
%         : and the motion vector
function [bestBlockPosition, motionVector] = bestCorrespondingBlock(block, block_x_pos, block_y_pos, img, p)

    imgd = double(img);
    [m,n] = size(img);

    BLOCK_SIZE = size(block,1);

    % Search-block bondaries
    search_min_x = block_x_pos - p;
    search_min_y = block_y_pos - p;
    search_max_x = block_x_pos + BLOCK_SIZE + p;
    search_max_y = block_y_pos + BLOCK_SIZE + p;

    % Checking limits todo: pas sur pour l'ordre x,y
    if search_min_x < 1
        search_min_x = 1;
    end
    if search_min_y < 1
        search_min_y = 1;
    end
    if (search_max_x+BLOCK_SIZE-1) > n-1
        search_max_x = n-1-BLOCK_SIZE;
    end
    if (search_max_y+BLOCK_SIZE-1) > m-1
        search_max_y = m-1-BLOCK_SIZE;
    end

    % What we'll return
    bestMatchPosition = [ -1, -1 ];
    % Initializing to a high value
    bestCorrelation = 30000000;
    % Loop on every block possible
    for i = search_min_x:search_max_x
        for j = search_min_y:search_max_y

            generatedBlock = imgd(i:i+BLOCK_SIZE-1, j:j+BLOCK_SIZE-1);

            % computing correlation
            temp_correlation = getCorrelation(generatedBlock, block);

            % If the correlation is better
            if temp_correlation < bestCorrelation
                % update the return values
                bestCorrelation = temp_correlation;
                bestMatchPosition = [i, j];
            end

        end
    end

    bestBlockPosition = bestMatchPosition;
    % Movement from img to block
    motionVector = [ bestMatchPosition(1)-block_x_pos, bestMatchPosition(2)-block_y_pos];

end