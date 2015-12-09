function create_video(im_sequence, filename)

outputVideo = VideoWriter(filename);
outputVideo.FrameRate = 30;

open(outputVideo)

for ii = 1:length(im_sequence)
   img = im_sequence{ii};
   
   %img_max = max(img(:));
   %img = abs(img) / img_max;
   
   writeVideo(outputVideo, img)
end

close(outputVideo)

end