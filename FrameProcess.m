function FrameProcess(videoFrame)
global row;
global col;
global Mean;
global dif;
global d;
global K;



%%
    for i=1:row
        for j=1:col
            for k=1:K
                dif(i,j,k) = abs(Mean(i,j,k) - videoFrame(i,j)) ;
            end
        end
    end
   
    for i=1:row
        for j=1:col
            pix_val = videoFrame(i,j);
            PixelProcess(i, j, pix_val);
        end
    end
end