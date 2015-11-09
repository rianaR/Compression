% returns the correlation between two images
function [err] = MSE(img1, img2)
    % mse formula  
    err = sum((img1-img2).^2)/size(img1(:), 1);
end