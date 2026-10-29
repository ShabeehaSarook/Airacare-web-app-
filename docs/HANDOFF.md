# Airacare Handoff

## Start Here

Read the root README, then:

1. Follow [SETUP.md](SETUP.md) to create a new virtual environment.
2. Read [PROJECT_MAP.md](PROJECT_MAP.md) before changing code.
3. Read [ARCHITECTURE.md](ARCHITECTURE.md) to understand detection and Capture & Store.
4. Read [DEPLOYMENT.md](DEPLOYMENT.md) before changing Render or Firebase.

## What Is Required to Run

The repository intentionally does not include the local Python virtual
environment or generated training/validation output. Recreate the environment
from `requirements-web.txt` for the web backend, or `requirements.txt` for the
desktop tools. Model assets and matching labels remain in `models/`.

Keep these deployment files at the repository root:

- `render.yaml`, `Procfile`, `runtime.txt`
- `firebase.json`, `.firebaserc`
- `requirements-web.txt`, `requirements.txt`

Keep secrets in Render/Firebase service configuration. The repository must not
contain Cloudinary or PhotoRoom credentials.

## Production Components

- Firebase Hosting publishes `frontend/`.
- Render runs `backend.app` through the root compatibility entry point
  `web_backend.py` and imports shared modules from `src/`.
- Firestore rules are in `database/firestore.rules`.
- TFLite inference uses `models/airacare_custom.tflite` and its labels.
- Cloudinary stores Capture & Store PNG images; Firestore stores metadata.

## Technology Stack

| Area | Technology | Role |
| --- | --- | --- |
| Browser frontend | HTML, CSS, JavaScript | Camera UI, live boxes, status, Capture & Store, collection |
| Camera and crop | `getUserMedia`, Canvas API | Captures the phone/browser frame and crops the selected pet |
| Frontend database client | Firebase Web SDK | Anonymous authentication and Firestore reads/writes |
| API | Python, Flask | Detection, health, segmentation, upload and delete routes |
| API server | Gunicorn | Production process on Render |
| Computer vision | OpenCV, NumPy | Image decoding, crop processing and fallback masking |
| ML runtime | LiteRT/TensorFlow Lite | Runs `models/airacare_custom.tflite` on the backend |
| Detection logic | TFLite preprocessing/postprocessing, validation, tracking | Class mapping, confidence checks, stable detections |
| Safety logic | Python distance, risk, motion, path and warning modules | Distance estimate, risk level and warning state |
| Background removal | PhotoRoom API, configured fallback | Produces transparent PNG stickers |
| Image storage | Cloudinary | Stores captured dog/cat PNGs and returns image URLs |
| Metadata storage | Cloud Firestore | Stores detection history and `captured_pets` metadata |
| Frontend hosting | Firebase Hosting | Publishes `frontend/` over HTTPS |
| Backend hosting | Render Free Web Service | Runs the Flask ML API |
| Dataset/training tools | YOLO/Ultralytics, OpenCV, Python utilities | Earlier desktop training and validation workflows |

## Completed in This Repository

- Clear backend/frontend/database/model folder structure.
- Browser camera detection connected to the Flask `/api/detect` endpoint.
- Android TFLite model loaded by the web backend, with the eight-class label file.
- Bounding boxes, confidence, distance, risk, movement/path state and warnings.
- Temporal confirmation, class thresholds, box checks, tracking and stale-state clearing.
- Firestore authentication and normal detection history saving.
- Dog/cat-only Capture & Store button and explicit user confirmation.
- High-resolution browser crop with padding and boundary clamping.
- Background-removal endpoint returning transparent PNG data.
- Cloudinary upload/delete endpoints and Firestore `captured_pets` metadata.
- My Collection with dog/cat filters and delete action.
- Firebase Hosting and Render configuration files.
- Local automated tests and deployment documentation.

## Remaining Before Final Handover

- Recreate a local virtual environment and rerun the test suite on the clean copy.
- Run one real phone test for empty scene, person, dog, cat, capture, reload, and delete.
- Confirm Render is connected to the intended GitHub branch and the latest commit.
- Confirm Firebase Hosting has the current `frontend/` deployment.
- Confirm Render secrets exist: `CLOUDINARY_URL` and `PHOTOROOM_API_KEY`.
- Confirm Firestore rules and anonymous authentication in the Firebase console.
- Transfer GitHub, Firebase, Render, Cloudinary, PhotoRoom, and Android project access.
- Decide whether the old desktop YOLO/dataset tools are needed; they are preserved for reference.

The clean repository does not claim that an external provider, phone camera, or
production model accuracy has been tested merely because the code is present.

## Before Handover

Confirm the recipient has access to the GitHub repository, Firebase project,
Render service, Cloudinary account, PhotoRoom account, and the Android project
if Android maintenance is included. Transfer ownership through each provider's
account controls; do not send credentials in source files or chat.

Generated folders such as `venv/`, `results/`, and `runs/` can be recreated and
are ignored by Git. The source dataset is retained separately under `dataset/`.
