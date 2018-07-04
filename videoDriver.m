clear all;
%% Bowden
video = VideoReader('a.avi');
videoFrame = readFrame(video);
videoFrame = toSize(videoFrame);
global row;     
global col;     [row, col]  = size(videoFrame);
global grim;    grim        = 2.5;
global K;       K           = 5;          % number of gaussian
global T;       T           = 0.7;        % Background proportion threshold
global a;       a           = 0.005;          % alpha
global p;       p           = a/(1/K);    % rho
global vr_init; vr_init = 6.0*6.0;
global Mean;    for k=1:K
                    Mean(:,:,k) = videoFrame(:,:);
                end
        
global w;       w   = ones(row, col, K)*(0.05);
global vr;      vr  = ones(row, col, K)*(vr_init);

global dif;     dif = zeros(row, col, K);
global fg;      fg      = zeros(row,col);
global fg_mask; fg_mask = false(row,col);


t = 1;
while hasFrame(video)
    videoFrame = readFrame(video);  t=t+1;
    videoFrame = toSize(videoFrame);
    FrameProcess(videoFrame);
    imshow(doubleToInt(fg));
    fprintf('frame   =   %d\n', t);
    %if t==43 break; end
end

