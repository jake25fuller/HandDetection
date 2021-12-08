### QUICK START:

Check out DEMO_1.m and DEMO_2.m to see examples on how to use the data and access ground-truth. You
may also want to look at the ACCESSING THE DATA section in here to see how the data is structured.

### INTRO:

Thank you for downloading the EgoHands dataset! This dataset contains 48 Google Glass videos of
complex, first-person interactions between two people. The main intention of this dataset is to
enable better, data-driven approaches to understanding hands in first-person computer vision. The
dataset offers
 - high quality, pixel-level segmentations of hands
 - the possibility to semantically distinguish between the observer's hands and someone else's hands,
   as well as left and right hands
 - virtually unconstrained hand poses as actors freely engage in a set of joint activities
 - lots of data with 15,053 ground-truth labeled hands

If you have any questions, please contact Sven at sbambach@indiana.edu. If you would like to use
this data in your work you are more than welcome to, but please cite our corresponding ICCV paper:

@inproceedings{bambach2015hand,
  title={Lending A Hand: Detecting Hands and Recognizing Activities in Complex Egocentric Interactions},
  author={Bambach, Sven and Lee, Stefan and Crandall, David and Yu, Chen},
  booktitle={Computer Vision (ICCV), 2015 IEEE International Conference on},
  year={2015},
  organization={IEEE}
}

### ABOUT THE DATA:

To create as realistic a dataset as possible while still giving some experimental control, we 
collected data from different pairs of four participants who sat facing each other while engaged in
different activities. We chose four activities that encourage interaction and hand motion:
 - playing cards, specifically a simple version of Mau Mau
 - playing chess, where for efficiency we encouraged participants to focus on speed rather than
 strategy;
 - solving a 24- or 48-piece jigsaw puzzle;
 - playing Jenga, which involves removing pieces from a 3d puzzle until it collapses.

We also varied context by collecting videos in three different locations: a table in a conference
room, a patio table in an outdoor courtyard, and a coffee table in a home. We recorded over multiple
days and did not restrict participant clothing so there is significant variety (e.g. both short- and
long-sleeved shirts, etc.). We systematically collected data from four actors performing all four
activities at all three locations while randomly assigning participants to one another for
interaction, resulting in 4 x 4 x 3 = 48 unique combinations of videos. Each participant wore a
pair of Google Glass, which recorded 720x1280px video at 30 Hz.

In post-processing, we synchronized the video pairs to one another and cut them to be exactly 90
seconds (2,700 frames) each. For ground truth, we manually annotated a random subset of 100 frames
from each video (about one frame per second) with pixel-level hand masks. Each hand pixel was given
one of four labels: the camera wearer's left or right hand ("own left" or "own right"), or the
social partner's left or right hand ("other left" or "other right").

### ACCESSING THE DATA:

The data is structured as follows: The folder "_LABELLED_SAMPLES" contains 48 folders, one for each
video. The name of each folder is ACTIVITY_LOCATION_VIEWER_PARTNER, where:
 - ACTIVITY = {CARDS, CHESS, JENGA, PUZZLE}
 - LOCATION = {COURTYARDS, OFFICE, LIVINGROOM}
 - VIEWER/PARTNER = {B, H, S, T}

Each folder contains 100 frames as JPEG files. All ground-truth data is stored in metadata.mat file
in the root directory. This file contains a MATLAB struct array called video, which has the
following fields:
 - video_id
 - partner_video_id
 - ego_viewer_id
 - partner_id
 - location_id
 - activity_id
 - labeled_frames (array)  ---  frame_ids
                           ---  polygons with hand segmentations

We provide you with a simple API to quickly get the right data out of the struct, and letting you 
easily split the videos into different sets. The quickest way to understand how things work is by
running (and reading) DEMO_1.m and DEMO_2.m. Lastly, each function that we provide (and use in the
demo scripts is documented and has a help function, meaning you can type help getMetaBy into the 
MATLAB prompt to read the help menu of the function getMetaBy().