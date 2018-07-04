function PixelProcess(i, j, pix_val)
    global a; 
    global p;
    global K;
    global T;
    global grim;
    global Mean;
    global w;
    global vr;
    global vr_init;
    global dif;
    global fg;
    global fg_mask;

       
%% weight normalization
    sum = 0;
    for k = 1 : K
       sum = sum + w(i,j,k);
    end
    for k = 1 : K
       w(i,j,k) = w(i,j,k) / sum;
    end
       
%% rank
    rank = zeros(K, 2);
    for k = 1 : K
        rank(k,1) = w(i,j,k) / vr(i,j,k);
        rank(k,2) = k;
    end
    rank = sortrows(rank, -1);     % descending order
    
%% How many Background Model    
    BGWeight = 0;
    B = 0;
    for k = 1 : K
        r = rank(k, 2);
        BGWeight = BGWeight + w(i, j, r);
        if(BGWeight > T)
           B = k;
           break; 
        end
    end
    
    %% match and update
    gaussianMatch = -1;
    Match = false;
    for k= 1 : K
        r = rank(k, 2);
        if(gaussianMatch < 0 && dif(i, j, r) * dif(i, j, r) <= (grim * grim * vr(i, j, r)))
            gaussianMatch = k;
            if k <= B 
                Match = true; 
            end
            w(i, j, r) = (1-a) * w(i,j,r) + a;
            Mean(i, j, r) = (1-a) * Mean(i,j,r) + a * pix_val;
            vr(i, j, r) = (1-a) * vr(i,j,r) + a * dif(i,j,r) * dif(i,j,r);
        else
            w(i, j, r) = (1-a) * w(i,j,r);
        end
    end
    
%% if not matched , replace the least weighted gaussian with the new pixel value
    if(gaussianMatch < 0)
        r = rank(K, 2);
        Mean(i, j, r) = pix_val;
        vr(i, j, r) = vr_init;
        w(i, j, r) = 0.05;
    end
    
    %% foreground detection
    if(Match)
		fg_mask(i, j) = false;
        fg(i, j) = 0;
    else
		fg_mask(i, j) = true;
        fg(i, j) = pix_val;
    end
end