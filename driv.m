clear all;

%videoFrame = imread('D:\Thesis\Background Subtraction & Modelling\Final Codes\xTestSetJPG\0440.jpg');
videoFrame = imread('D:\Thesis\Background Subtraction & Modelling\Final Codes\TestRoadside\f0000000.bmp');
bak_frame = toSize( imread('D:\Thesis\Background Subtraction & Modelling\Final Codes\TestRoadside\f0000000.bmp') );
videoFrame = toSize(videoFrame);
global row;     
global col;     [row, col]  = size(videoFrame);
global grim;    grim        = 2.5;
global K;       K           = 5;          % number of gaussian
global T;       T           = 0.7;        % Background proportion threshold
global a;       a           = 1;          % alpha
global p;       p           = a/(1/K);    % rho
global vr_init; vr_init = 30.0*30.0;
global Mean;    for k=1:K
                    Mean(:,:,k) = videoFrame(:,:);
                end
        
global w;       w   = ones(row, col, K)*(0.05);
global vr;      vr  = ones(row, col, K)*(vr_init);

global dif;     dif = zeros(row, col, K);
global fg;      fg      = zeros(row,col);
global fg_mask; fg_mask = false(row,col);

train = 150;    % train frame number

p_frame = videoFrame;
a_buffer = [];

frames = dir('D:\Thesis\Background Subtraction & Modelling\Final Codes\TestRoadside\*.bmp');

for t = 1 : train
    s = fullfile(frames(t).folder, frames(t).name);
    videoFrame = imread(s);
    videoFrame = toSize(videoFrame);
    
    %Determine T
    
    ct = calculateT(videoFrame, p_frame);
    p_frame = videoFrame;
    
    %Determine T
    
    a = 1/ct;
    fprintf('%f_a\n', a);
    a_buffer(t) = a;
    
    FrameProcess(videoFrame);
%     imshow(fg_mask);
%     fprintf('frame   =   %d\n', t);
end

a_mean = (sum(a_buffer)/train);

a = a_mean;

%a = 0.005;

for t = train+1 : length(frames)
    s = fullfile(frames(t).folder, frames(t).name);
    videoFrame = imread(s);
    videoFrame = toSize(videoFrame);
    FrameProcess(videoFrame);
    imshow(fg_mask);
    %imshow(doubleToInt(fg));
    fprintf('frame   =   %d\n', t);
end

