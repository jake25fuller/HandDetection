function [video] = getMetaBy(varargin)
% getMetaBy  Returns EgoHands video metadata structures for videos which
% match the argument filters. For a description of the metadata structure
% see buildMetadata help.
%
%   C = getMetaBy() returns metadata for all videos.
%
%   C = getMetaBy(FilterName, Value, ...) returns metadat for all videos 
%   matching the filters. Possible filters and values are listed below:
%
%   Filter            Possible Values        Info
%   ----------        --------------------   ------------------------
%   'Location'        'OFFICE','COURTYARD',  Video background location
%                     'LIVINGROOM'
%
%   'Activity'        'CHESS','JENGA',       Activity in video
%                     'PUZZLE','CARDS'
%
%   'Viewer'          'B','S','T','H'        Identity of egocentric viewer
%
%   'Partner'         'B','S','T','H'        Identity of egocentric partner
%
%   Multiple filters and values can be mixed, for example:
%   getMetaBy('Location','OFFICE, COURTYARD', 'Activity','CHESS', 'Viewer', 'B,S,T')
%   would return all videos of Chess played with B,S, or T as the egocentric
%   observer filmed at the Office or Courtyard locations.
%
%   Also available is the data split used as the "Main Split" in our ICCV 2015
%   paper. This split randomly partitioned the data into training, validation
%   and test groups such that actors, activities and locations are evenly
%   distributed across partitions. This split has 36 training, 4 validation,
%   and 8 test videos. Each partition is accessible through the filter below,
%   which can also be combined with the filters above.
%
%   Filter            Possible Values        Info
%   ----------        --------------------   ------------------------
%   'MainSplit'       'TRAIN','TEST',        Main Split from ICCV 2015 paper
%                     'VALID'
%
%
%   For full dataset details, see the <a href="matlab: web('http://vision.soic.indiana.edu/egohands')">EgoHands project website</a>.
%
%   See also getFramePath, getBoundingBoxes, getSegmentationMask, showLabelsOnFrame

	 p = inputParser;
	 addOptional(p, 'Location', 'OFFICE,COURTYARD,LIVINGROOM');
	 addOptional(p, 'Activity', 'CHESS,JENGA,PUZZLE,CARDS');
	 addOptional(p, 'Viewer', 'B,S,T,H');
	 addOptional(p, 'Partner', 'B,S,T,H');
	 addOptional(p, 'MainSplit', 'TRAIN,TEST,VALID');
	 parse(p, varargin{:});

	 % load video struct
     load('metadata.mat');
     
     %MainSplit from ICCV 2015 paper
	 index = logical([1 0 0 0 0 0 0 0 0 0 1 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 1 0 0 1 0 0 0 1 0 0 0 0 0 1 0 0 0 0;  % TEST
			  0 0 0 0 0 0 1 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 1 0;  % VALID
			  0 1 1 1 1 1 0 1 1 1 0 1 0 0 1 1 1 1 1 0 1 1 1 1 1 1 1 0 1 1 0 1 1 0 1 1 1 0 1 1 1 1 1 0 1 1 0 1]); % TRAIN
	 keep = false(size(video));
	 if ~isempty(strfind(p.Results.MainSplit, 'TEST'))
	 	keep = keep | index(1,:);
	 end
	 if ~isempty(strfind(p.Results.MainSplit, 'VALID'));
	 	keep = keep | index(2,:);
	 end
	 if ~isempty(strfind(p.Results.MainSplit, 'TRAIN'))
	 	keep = keep | index(3,:);
	 end
	 video = video(keep);

	 %Location	 
	 keep = true(size(video));
	 for i=1:length(video)
	 	if(isempty(strfind(p.Results.Location, video(i).location_id)))
			keep(i) = false;
		end
	 end
	 video = video(keep);

	%Activity	 
	 keep = true(size(video));
	 for i=1:length(video)
	 	if(isempty(strfind(p.Results.Activity, video(i).activity_id)))
			keep(i) = false;
		end
	 end
	 video = video(keep);

	%EgoPerson	 
	 keep = true(size(video));
	 for i=1:length(video)
	 	if(isempty(strfind(p.Results.Viewer, video(i).ego_viewer_id)))
			keep(i) = false;
		end
	 end
	 video = video(keep);

	%EgoPartner	 
	 keep = true(size(video));
	 for i=1:length(video)
	 	if(isempty(strfind(p.Results.Partner, video(i).partner_id)))
			keep(i) = false;
		end
	 end
	 video = video(keep);
	 
end