function [x] = doubleToInt(fg)
global row;
global col;
    for i=1:row
        for j=1:col
            x(i,j)=uint8(fg(i,j));
        end
    end
end