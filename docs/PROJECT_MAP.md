# Project Map

## Where to Make Changes

| Task | Files |
| --- | --- |
| Browser controls, camera, capture, collection | `frontend/app.js` |
| UI markup and appearance | `frontend/index.html`, `frontend/styles.css` |
| HTTP routes, background removal, Cloudinary | `backend/app.py` |
| Existing hosting/launcher compatibility | `web_backend.py` |
| Web inference orchestration and confirmation | `src/web_detection_service.py` |
| TFLite tensors, preprocessing, decoding | `src/android_tflite_detector.py` |
| Desktop detector and YOLO loading | `src/detector.py`, `main.py` |
| Distance and calibration | `src/distance.py`, `src/calibrate_distance.py`, `config/` |
| Risk, movement and path | `src/risk.py`, `src/movement.py`, `src/relative_motion.py`, `src/path_analysis.py` |
| Tracking and warnings | `src/tracker.py`, `src/warning.py`, `src/audio_alert.py` |
| Visibility and sensor support | `src/visibility.py`, `src/image_enhancement.py`, `src/fusion.py`, `src/vehicle_speed.py` |
| Training and model evaluation | `src/train_model.py`, `src/evaluate_model.py`, `src/review_predictions.py` |
| Dataset preparation | `src/capture_dataset.py`, `src/dataset_inspector.py`, `src/split_dataset.py`, `src/validate_annotations.py`, `src/preview_annotations.py`, `src/augment_weak_classes.py`, `src/download_open_images_airacare.py` |
| Validation/debugging | `tests/test_core.py`, `src/live_validation.py`, `src/validate_distance_accuracy.py`, `src/evaluate_enhancement.py`, `src/debug_camera_frame.py`, `src/test_warning.py`, `src/airacare_status.py` |
| Firebase hosting and permissions | `firebase.json`, `.firebaserc`, `database/firestore.rules` |
| Render startup and dependencies | `render.yaml`, `Procfile`, `runtime.txt`, `requirements-web.txt` |

## Windows Shortcuts

Run a shortcut from PowerShell using `./name.bat` (or `.\name.bat`).

| Shortcut | Purpose |
| --- | --- |
| `run_web_backend.bat` | Current Flask web app/API at localhost:8000 |
| `run_webcam.bat`, `run_phone_camera.bat` | Desktop camera/IP-camera detector |
| `run_phone_camera_no_detection.bat`, `run_phone_fast_debug.bat` | Camera/debug variants |
| `start_web_app.bat`, `start_web_app_phone.bat` | Earlier `web_app.py` server-camera UI |
| `calibrate_*.bat` | Camera calibration |
| `validate_*.bat` | Live-source or distance validation |
| `augment_weak_classes.bat` | Dataset augmentation |
| `install_airacare_autostart.bat` | Optional machine startup integration; inspect before running |

The earlier server-camera UI receives frames from the server's camera. The
current `frontend` captures frames in the user's browser. These are different
entry points and should not be substituted for each other.

## Data and Generated Files

- `models/`: preserve weights and labels; `.pt` training assets are distinct
  from the default web `.tflite` asset. `yolo11n.pt` at root is a local base-model asset.
- `dataset/`: see its existing README for annotation conventions. Never treat
  user-collected images/labels as disposable build output.
- `config/`: real calibration files and example JSON; calibrations depend on camera.
- `test_data/`: inputs used for manual/automated validation; inspect before sharing.
- `results/`, `runs/`: generated experiment outputs; intentionally removed from the handoff copy and recreated by validation/training scripts.
- `venv/`, `__pycache__/`, `.firebase/`: local environment/cache artifacts.
- `tmp_*_payload.json`: local API request payloads that may contain camera images.
- `tools/cloudflared.exe`: optional tunnel helper, not required by Render hosting.

The Flask API lives in `backend/`, browser assets in `frontend/`, Firestore rules
in `database/`, and model assets in `models/`. Shared modules remain in `src/`.
The root compatibility launcher preserves existing startup commands.
New operational documentation belongs
in `docs/`; historical milestones belong in `docs/history/`. Historical command
paths remain relative to the repository root.
