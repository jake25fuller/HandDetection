function img = showLabelsOnFrame(vid, i)
% showLabelsOnFrame(vid, i) returns the "i"th labeled frame in video "vid", where "vid" is an
% EgoHands video metadata structure, with the ground-truth segmentations highlighted
% in different colors:
%   "own left" hand    = blue
%   "own right" hand   = yellow
%   "other left" hand  = red
%   "other right" hand = green
%
%
%   For full dataset details, see the <a href="matlab: web('http://vision.soic.indiana.edu/egohands')">EgoHands project website</a>.
%
%   See also getFramePath, getMetaBy, getSegmentationMask, getBoundingBoxes

    opacity = 0.33;

    img = imread(getFramePath(vid, i));
	
    if ~isempty(vid.labelled_frames(i).yourright)
        shape = reshapeAreaCoords(vid.labelled_frames(i).yourright);
        img = insertShape(img, 'FilledPolygon', shape, 'Color', {'green'}, 'Opacity', opacity);
    end

    if ~isempty(vid.labelled_frames(i).yourleft)
        shape = reshapeAreaCoords(vid.labelled_frames(i).yourleft);
        img = insertShape(img, 'FilledPolygon', shape, 'Color', {'red'}, 'Opacity', opacity);
    end

    if ~isempty(vid.labelled_frames(i).myright)
        shape = reshapeAreaCoords(vid.labelled_frames(i).myright);
        img = insertShape(img, 'FilledPolygon', shape, 'Color', {'yellow'}, 'Opacity', opacity);
    end
    
	if ~isempty(vid.labelled_frames(i).myleft)
        shape = reshapeAreaCoords(vid.labelled_frames(i).myleft);
        img = insertShape(img, 'FilledPolygon', shape, 'Color', {'blue'}, 'Opacity', opacity);
    end
end

function shape2 = reshapeAreaCoords(shape)
    shape2 = zeros(1, 2*length(shape));
    shape2(1:2:end) = shape(:,1)';
    shape2(2:2:end) = shape(:,2)';
end