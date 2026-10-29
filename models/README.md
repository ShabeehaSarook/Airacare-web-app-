# Models

The default web model is `airacare_custom.tflite`, decoded by
`src/android_tflite_detector.py`. Its companion `airacare_custom_labels.txt`
contains person, dog, cat, horse, cow, deer, goat, elephant in that order.

The `.pt` assets support earlier YOLO/desktop/training workflows. They are not
interchangeable with the TFLite model or its labels. Historical seven-class
training notes do not establish provenance for the eight-class TFLite model.

Keep weights and matching labels together. Verify tensor layout, preprocessing,
class order, and sample inference before replacing a model. A successful model
load does not establish accuracy.
