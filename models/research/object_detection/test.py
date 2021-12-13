#! /usr/bin/python3

import cv2
import numpy as np
import os
import tensorflow as tf
from object_detection.utils import label_map_util
from object_detection.utils import visualization_utils as viz_utils
from object_detection.builders import model_builder
from object_detection.utils import config_util

# not needed MODEL_PATH = '/home/daniel/csce585/HandDetection/inference/saved_model'
LABEL_PATH = '/home/daniel/csce585/HandDetection/models/research/object_detection/label_map.pbtxt'
#CHECK_PATH = '/home/daniel/csce585/HandDetection/ssd_mobilenet_v2_fpnlite_320x320_coco17_tpu-8/checkpoint'
CHECK_PATH = '/home/daniel/csce585/HandDetection/V2/output_training'
CONFIG_PATH = '/home/daniel/csce585/HandDetection/V2/ssd_mobilenet_v2_fpnlite_320x320_coco17_tpu-8/pipeline.config'

#height = 320
#width = 320

category_index = label_map_util.create_category_index_from_labelmap(LABEL_PATH)
# detection_model = tf.saved_model.load(MODEL_PATH)
configs = config_util.get_configs_from_pipeline_file(CONFIG_PATH)
detection_model = model_builder.build(model_config=configs['model'], is_training=False)

ckpt = tf.compat.v2.train.Checkpoint(model=detection_model)
ckpt.restore(os.path.join(CHECK_PATH, 'ckpt-15')).expect_partial()

@tf.function
def detect_fn(image):
    image, shapes = detection_model.preprocess(image)
    prediction_dict = detection_model.predict(image, shapes)
    detections = detection_model.postprocess(prediction_dict, shapes)
    return detections



#def test_webcam():
#   cap = cv2.VideoCapture(0)
#    while True:
#        ret, frame = cap.read()
#        input = cv2.cv2.resize(frame, (width, height))
#        image_np = np.array(input)
#    
#        input_tensor = tf.convert_to_tensor(np.expand_dims(image_np, 0), dtype=tf.uint8)
#        boxes, scores, classes, num_det = detection_model(input_tensor)
#
#        img = cv2.flip(img, 1)
#        cv2.imshow('testing', img)
#
#        if cv2.waitKey(1) & 0xFF == ord('q'): 
#            cap.release()
#            break


def infer():

    # Setup capture
    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 320)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 320) 
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

    while True: 
        #cv2.resize(cap.read(),(320, 320))
        ret, frame = cap.read()

        #frame_resized = cv2.resize(frame, (320,320))
        #image_np = np.array(cv2.flip(frame_resized, 1))
        
        image_np = np.array(frame)
    
        input_tensor = tf.convert_to_tensor(np.expand_dims(image_np, 0), dtype=tf.float32)
        detections = detect_fn(input_tensor)
    
        num_detections = int(detections.pop('num_detections'))
        detections = {key: value[0, :num_detections].numpy()
                  for key, value in detections.items()}
        detections['num_detections'] = num_detections

        # detection_classes should be ints.
        detections['detection_classes'] = detections['detection_classes'].astype(np.int64)

        label_id_offset = 1
        image_np_with_detections = image_np.copy()
        print(detections['detection_boxes'])

        viz_utils.visualize_boxes_and_labels_on_image_array(
                image_np_with_detections,
                detections['detection_boxes'],
                detections['detection_classes']+label_id_offset,
                detections['detection_scores'],
                category_index,
                use_normalized_coordinates=True,
                max_boxes_to_draw=5,
                min_score_thresh=.5,
                agnostic_mode=False)

        cv2.imshow('object detection',  cv2.resize(image_np_with_detections, (800, 600)))
    
        if cv2.waitKey(1) & 0xFF == ord('q'):
            cap.release()
            break
        detections = detect_fn(input_tensor)

def main():
    infer()

if __name__ == '__main__':
    main()
