% This demo shows how to load and access ground-truth data for any of the videos.

% Let's load all videos at the courtyard location where the activity was puzzle solving.
% getMetaBy() returns a struct array that contains all possible meta information (including
% the ground-truth data) about the videos. Check the getMetaBy() documentation for more.
videos = getMetaBy('Location', 'COURTYARD', 'Activity', 'PUZZLE');

% Each video has 100 annotated frames. Let's consider the first video. One can access the 8th frame
% of the first video like this:
img = imread(getFramePath(videos(1), 8));

% Here is how to get a binary mask with hand segmentations for the current frame. The third argument
% implies that the mask will show "all" hands. To get masks for specific hands, change this argument
% to e.g. "my_right" or "yours" to get only the observer's right hand or only the other actor's 
% hands respectively. Check the getSegmentationMask() documentation for more.
hand_mask = getSegmentationMask(videos(1), 8, 'all');

% The bounding boxes for each hand are also easily accessible. The function below returns a 4x4
% matrix, where each row corresponds to a hand bounding box in the format [x y width height], where
% x and y mark the top left corner of the box. The rows from top to bottom contain the bounding
% boxes for "own left", "own right", "other left", and "other right" hand respectively. If a hand
% is not in the frame, the values are set to 0.
bounding_boxes = getBoundingBoxes(videos(1), 8);



% That's it. Let's display the data that we just generated:

% make a new figure to show results
scrsz = get(groot,'ScreenSize');
figure('Position',[1 scrsz(4)*0.8 scrsz(3)*0.4 scrsz(4)*0.8]);

% display the frame
subplot(3,1,1);
imshow(img);
set(0, 'DefaulttextInterpreter', 'none'); % just so underscores in the title are displayed correctly...
title(['Video: ' videos(1).video_id ' - Frame # ' num2str(8)]);

% display the segmentation mask
subplot(3,1,2);
imshow(hand_mask);
title('Hand Segmentations');

% display the bounding boxes
subplot(3,1,3);
imshow(insertShape(img, 'Rectangle', bounding_boxes, 'Color', {'blue', 'yellow', 'red', 'green'}, 'LineWidth', 10));
title('Bounding Boxes');