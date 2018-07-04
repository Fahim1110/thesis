function [T] = calculateT(videoFrame,previousFrame)
    
    % Global variables
    global row;
    global col;

    % Lables
    Ich = 0;
    Icm = 0;
    Icl = 0;
    Icvl = 0;
    
    % thresholds
    l4th = 90;
    l3th = 60;
    l2th = 30;
    l1th = 0;
    
    % 50% of frame
    fifty_persent = round(((row*col)/2));
    EIClable = 0;
    EIC_label_num = 0;
    EIC_probability = 0;
    
    % T
    Tj = 0;
    Upper_limit = 150;
    
    for i = 1 : row
        for j = 1 : col
            
            %Subtract each pixel
            sub_pixel = abs(double(videoFrame(i,j)) - double(previousFrame(i,j)));
            
            % Pixel count for each label
            if sub_pixel >= l4th
                Ich = Ich + 1;
            elseif sub_pixel >= l3th
                Icm = Icm + 1;
            elseif sub_pixel >= l2th
                Icl = Icl + 1;
            elseif sub_pixel >= l1th
                Icvl = Icvl + 1;
            end
            
        end
    end
    
    fprintf('%d_%d_%d_%d\n',Ich, Icm, Icl, Icvl);
    
    % find EIC label 
    if Ich >= fifty_persent
        EIClable = Ich;
        EIC_label_num = 4;
    elseif Icm >= fifty_persent
        EIClable = Icm;
        EIC_label_num = 3;
    elseif Icl >= fifty_persent
        EIClable = Icl;
        EIC_label_num = 2;
    elseif Icvl >= fifty_persent
        EIClable = Icvl;
        EIC_label_num = 1;
    end
    
    EIC_probability = (EIClable / (row*col));
    fprintf('%f_Prob\n',EIC_probability);
    
    % Find Tj
    if EIC_label_num == 1
        Tj = 4;
    elseif EIC_label_num == 2
        Tj = 3;
    elseif EIC_label_num == 3
        Tj = 2;
    elseif  EIC_label_num == 4
        Tj = 1;
    end
    
    T = ((Upper_limit - 4)*EIC_probability);
    disp(T);
end

