# Airacare Completion Workflow

The live software pipeline exists, but the full Airacare requirement needs real data, labels, training, and camera calibration. Do not claim the custom 7-class model is complete until `models/airacare_animal_detector_best.pt` is produced by actual training.

Historical desktop/dataset workflow. Run commands from the repository root.
See ../../README.md for the current web application setup.

## 1. Capture Raw Images

Webcam example:

```powershell
python -m src.capture_dataset --camera-source 0 --class-name dog
```

Phone/IP Webcam example:

```powershell
python -m src.capture_dataset --camera-source "http://PHONE_IP:8080/video" --class-name dog
```

Use the correct class each time:

```text
person, dog, cat, horse, cow, deer, goat
```

Press `S` to save useful frames. Press `Q` to quit.

For automatic capture during a controlled recording:

```powershell
python -m src.capture_dataset --camera-source 0 --class-name dog --auto-save --interval 1.0 --max-images 100
```

## 2. Inspect Raw Dataset

```powershell
python -m src.dataset_inspector
```

Remove bad, duplicate, blurry, or wrong-class images manually.

## 3. Annotate Images

Use CVAT, LabelImg, Roboflow, or another YOLO-compatible annotation tool.

Every visible target object must have its own bounding box. If one image has two dogs and one cow, create three YOLO label lines.

YOLO class IDs:

```text
0 person
1 dog
2 cat
3 horse
4 cow
5 deer
6 goat
```

Place annotated source files in:

```text
dataset/annotated/images
dataset/annotated/labels
```

## 4. Split Annotated Dataset

```powershell
python -m src.split_dataset --source-images dataset/annotated/images --source-labels dataset/annotated/labels --dry-run
```

If the dry run looks correct:

```powershell
python -m src.split_dataset --source-images dataset/annotated/images --source-labels dataset/annotated/labels
```

## 5. Validate Annotations

```powershell
python -m src.validate_annotations
```

Fix all reported errors before training.

## 6. Train Custom Model

Preflight only:

```powershell
python -m src.train_model --check-only
```

Train:

```powershell
python -m src.train_model --epochs 100 --imgsz 640
```

After successful training, the best model should be copied to:

```text
models/airacare_animal_detector_best.pt
```

## 7. Calibrate Camera For Distance

Webcam:

```powershell
python -m src.calibrate_distance --camera-source 0 --known-height 1.70 --known-distance 3.0 --output config/webcam_calibration.json
```

Phone:

```powershell
python -m src.calibrate_distance --camera-source "http://PHONE_IP:8080/video" --known-height 1.70 --known-distance 3.0 --output config/phone_calibration.json
```

Use the real measured object height and real measured camera distance. Do not change zoom after calibration.

## 8. Run Full Camera-Only Airacare Prototype

Webcam:

```powershell
python main.py --camera-source 0 --calibration config/webcam_calibration.json --confidence 0.20 --imgsz 416 --iou 0.45 --vehicle-speed-kmh 30 --tracking --distance --warnings --audio-warning --enhancement auto
```

Phone:

```powershell
python main.py --camera-source "http://PHONE_IP:8080/video" --calibration config/phone_calibration.json --confidence 0.20 --imgsz 416 --iou 0.45 --vehicle-speed-kmh 30 --tracking --distance --warnings --audio-warning --enhancement auto
```

## 9. Check Readiness

```powershell
python -m src.airacare_status
```

This reports missing model/data/calibration items without modifying anything.

## Safety Note

This is a research driver-assistance prototype. Distance, closing speed, TTC, risk, and warnings are estimates. Do not test by driving toward people or animals.
