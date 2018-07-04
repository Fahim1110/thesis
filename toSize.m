function  [Frame] = toSize(videoFrame)
%Video = VideoReader('denis_run.avi');
%videoFrame = readFrame(Video);
    videoFrame = toGray(videoFrame); 
    videoFrame = imresize(videoFrame, [128 NaN]);
    Frame(:,:) = double(videoFrame(:,:));
    %imshow(Frame);
end