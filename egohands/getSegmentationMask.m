function img_mask = getSegmentationMask(vid, i, hand_type)
% getSegmentationMask(vid, i, hand_type) returns the binary segmentation mask
% for hands in the "i"th frame in video "vid", where "vid" is an EgoHands video 
% metadata structure.
%
%   img_mask = getSegmentationMask(vid, 1, 'all') returns a mask for all hands in first frame of vid
%
%   img_mask = getSegmentationMask(vid, 1, 'mine') returns a mask for all egocentric observer hands in first frame of vid
%
%   img_mask = getSegmentationMask(vid, 1, 'your_right') returns a mask for all egocentric partner's right hand in first frame of vid
%
%   Possible values for hand_type are "all", "mine", "yours", "my_left", "my_right", "your_left", "your_right".
%
%
%   For full dataset details, see the <a href="matlab: web('http://vision.soic.indiana.edu/egohands')">EgoHands project website</a>.
%
%   See also getFramePath, getMetaBy, getBoundingBoxes, showLabelsOnFrame

	img_mask = uint8(zeros(720, 1280, 3));

    if (strcmp(hand_type, 'my_left') || strcmp(hand_type, 'mine') || strcmp(hand_type, 'all')) && ~isempty(vid.labelled_frames(i).myleft)
        shape = reshapeAreaCoords(vid.labelled_frames(i).myleft);
        img_mask = insertShape(img_mask, 'FilledPolygon', shape, 'Color', {'white'}, 'Opacity', 1);
    end
    if (strcmp(hand_type, 'my_right') || strcmp(hand_type, 'mine') || strcmp(hand_type, 'all')) && ~isempty(vid.labelled_frames(i).myright)
        shape = reshapeAreaCoords(vid.labelled_frames(i).myright);
        img_mask = insertShape(img_mask, 'FilledPolygon', shape, 'Color', {'white'}, 'Opacity', 1);
    end
    if (strcmp(hand_type, 'your_left') || strcmp(hand_type, 'yours') || strcmp(hand_type, 'all')) && ~isempty(vid.labelled_frames(i).yourleft)
        shape = reshapeAreaCoords(vid.labelled_frames(i).yourleft);
        img_mask = insertShape(img_mask, 'FilledPolygon', shape, 'Color', {'white'}, 'Opacity', 1);
    end
    if (strcmp(hand_type, 'your_right') || strcmp(hand_type, 'yours') || strcmp(hand_type, 'all')) && ~isempty(vid.labelled_frames(i).yourright)
        shape = reshapeAreaCoords(vid.labelled_frames(i).yourright);
        img_mask = insertShape(img_mask, 'FilledPolygon', shape, 'Color', {'white'}, 'Opacity', 1);
    end

    img_mask = logical(img_mask(:,:,1));
	
end

function shape2 = reshapeAreaCoords(shape)
	shape2 = zeros(1, 2*length(shape));
	shape2(1:2:end) = shape(:,1)';
	shape2(2:2:end) = shape(:,2)';
end