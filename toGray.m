function [ X ] = toGray(rgb)
%rgb to gray scale
[r,c,v] = size(rgb);
    for x = 1:r
        for y = 1:c
            X(x,y) = 0.2989*rgb(x,y,1) + 0.5870*rgb(x,y,2) + 0.1140*rgb(x,y,3);
        end
    end
end