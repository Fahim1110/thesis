function [v] = SuddenChange(videoFrame)
background = imread('D:\Thesis\Background Subtraction & Modelling\Final Codes\TestRoadside\f0000000.bmp');
    row, col = size(videoFrame);
    threshold = 50;
    c = abs((row * col) / 2);
    count = 0;

    for i = 1 : row
        for j = 1 : col
            if(abs(double(videoFrame(i,j)) - double(background(i,j)))> threshold)
                count = count + 1;
            end
            if(count >= c)
                break;
            end
 
        end
    end
    if (count >= c)
        v = true;
    else
        v = false;
    end
end