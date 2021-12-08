% This demo shows how to easily look at ground-truth segmentations for a given video.

% Let's load the video of actor B playing jenga in the livingroom.
% getMetaBy() returns a struct that contains all possible meta information (including
% the ground-truth data) about the video. Check the getMetaBy() documentation for more.
vid = getMetaBy('Location', 'LIVINGROOM', 'Activity', 'JENGA', 'Viewer', 'B');

% Each video contains annotated frames. All we do here is display those frames, one after 
% the other, with hand segmentations annotated in different colors.

% open a new figure...
figure('name', vid.video_id);
disp('Press any key to go to the next frame.');

% loop over frames...
num_frames = length(vid.labelled_frames);
for i = 1:num_frames
	
	% Return the "i"th frame of video "vid" with colored ground-truth segmentations. See 
	% Check the showLabelsOnFrame() documentation for more. 
	img = showLabelsOnFrame(vid, i);

	% also show the frame ID for reference
	img = insertText(img, [0 0], ['Frame # ' num2str(vid.labelled_frames(i).frame_num)]);
	imshow(img);
	pause;
end