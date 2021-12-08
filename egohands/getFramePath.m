function [frame_path] = getFramePath(vid, i)
% getFramePath(vid, i) returns the file path to the "i"th labeled frame in video "vid", where "vid"
% is an EgoHands video metadata structure.
%
%
%   For full dataset details, see the <a href="matlab: web('http://vision.soic.indiana.edu/egohands')">EgoHands project website</a>.
%
%   See also getBoundingBoxes, getMetaBy, getSegmentationMask, showLabelsOnFrame

	basepath = ['_LABELLED_SAMPLES/' vid.video_id];
	frame_path = [basepath sprintf('/frame_%04d.jpg', vid.labelled_frames(i).frame_num)];

end