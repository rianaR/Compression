% returns the correlation between two images
function [cor] = getCorrelation(img1, img2)
    % mse formula  
    cor = (mean(mean((img1-img2).^2)));
end