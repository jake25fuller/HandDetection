function boxes = getBoundingBoxes(vid, i)
% getBoundingBoxes(vid, i) returns the ground-truth bounding boxes for the "ith" annotated frame of
% video "vid", where "vid" is an EgoHands video metadata structure.
% 
% Boxes is a 4x4 matrix, where each row corresponds to a hand bounding box in the format [x y width
% height], where x and y mark the top left corner of the box. The rows from top to bottom contain 
% the bounding boxes for "own left", "own right", "other left", and "other right" hand respectively.
% If a hand is not in the frame, the values are set to 0.
%
%
%   For full dataset details, see the <a href="matlab: web('http://vision.soic.indiana.edu/egohands')">EgoHands project website</a>.
%
%   See also getFramePath, getMetaBy, getSegmentationMask, showLabelsOnFrame

    boxes = zeros(4,4);

    if ~isempty(vid.labelled_frames(i).myleft)
        box = segmentation2box(vid.labelled_frames(i).myleft);
        boxes(1, :) = box;
    end
    if ~isempty(vid.labelled_frames(i).myright)
        box = segmentation2box(vid.labelled_frames(i).myright);
        boxes(2, :) = box;
    end
    if ~isempty(vid.labelled_frames(i).yourleft)
        box = segmentation2box(vid.labelled_frames(i).yourleft);
        boxes(3, :) = box;
    end
    if ~isempty(vid.labelled_frames(i).yourright)
        box = segmentation2box(vid.labelled_frames(i).yourright);
        boxes(4, :) = box;
    end

end

function box_xywh = segmentation2box(shape)
    box_xyxy = round([min(shape(:, 1)) min(shape(:, 2)) max(shape(:, 1)) max(shape(:, 2))]);
    box_xyxy(1) = max(1, box_xyxy(1));
    box_xyxy(2) = max(1, box_xyxy(2));
    box_xyxy(3) = min(1280, box_xyxy(3));
    box_xyxy(4) = min(720, box_xyxy(4));
    box_xywh = [box_xyxy(1) box_xyxy(2) box_xyxy(3)-box_xyxy(1)+1 box_xyxy(4)-box_xyxy(2)+1];
end