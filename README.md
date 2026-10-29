# Airacare Animal Safety

Airacare provides live camera detection, estimated distance and risk, detection
history, and dog/cat Capture & Store. Captured stickers are stored in Cloudinary;
Firestore stores their metadata. The web client is hosted on Firebase Hosting
and the Python Flask API on Render.

## Start Here

1. Read [local setup](docs/SETUP.md) to run the current web app.
2. Read the [project map](docs/PROJECT_MAP.md) to find the code you need.
3. Read [architecture](docs/ARCHITECTURE.md) for the detection and capture flows.
4. Read [deployment](docs/DEPLOYMENT.md) before updating Render or Firebase.
5. Read the [handoff checklist](docs/HANDOFF.md) for the technology stack,
   completed work, and remaining production checks.

The Android application is a separate repository/project. This repository
contains the web application, Python desktop tools, and training utilities.

## Repository Layout

```text
backend/             Flask API, background removal, Cloudinary integration
frontend/            Browser UI: index.html, app.js, styles.css
database/            Firestore security rules and database documentation
web_backend.py       Compatibility launcher for backend/app.py
src/                 Detection, tracking, risk, calibration, training modules
models/              Model weights and TFLite labels
config/              Camera calibration and runtime configuration files
tests/               Automated Python tests
test_data/           Test inputs
dataset/             Training images, annotations, splits, reports
docs/                Setup, architecture, deployment, project map
docs/history/        Preserved earlier development and training notes
tools/               Local helper executables
results/, runs/      Generated experiment/validation output
main.py              Python desktop camera application
web_app.py           Earlier server-camera browser application
*.bat                Windows launch/calibration/validation shortcuts
```

Root launchers and deployment files retain their original paths. Firebase now
publishes frontend/ and loads database/firestore.rules. The scripts depend on
the repository root as their working directory. Shared Python modules stay in
src/ because both the backend and desktop tools use them.

## Current Web Stack

- Frontend: HTML, CSS, JavaScript, browser camera/canvas, Firebase SDK.
- Backend: Python, Flask, Gunicorn, OpenCV, NumPy, LiteRT/TFLite.
- Default model: `models/airacare_custom.tflite`; labels in
  `models/airacare_custom_labels.txt` (includes elephant as the eighth class).
- Background removal: configured PhotoRoom provider with supported local
  fallback modes; inspect `/api/health` for the active configuration.
- Images: Cloudinary. Metadata/authentication: Firestore/Firebase Auth.

The earlier seven-class YOLO training materials are preserved under
[docs/history](docs/history/DEVELOPMENT_PHASES.md). They describe historical
stages, not the current web model configuration.

## Existing Deployment Addresses

- Frontend: https://airacare-animal-safety.web.app
- Backend health: https://airacare-web-backend.onrender.com/api/health
- Frontend with explicit API selection:
  https://airacare-animal-safety.web.app/?api=https://airacare-web-backend.onrender.com

These are configured project addresses, not an uptime guarantee. A healthy
API does not by itself verify inference, segmentation, upload, or Firestore writes.

## Contributing

Run commands from the repository root. Keep credentials in local process
environment variables or hosting secrets. Do not commit API secrets, captured
private images, virtual environments, or temporary request payloads. Keep
datasets, trained assets, and their class mappings together and document any
model replacement. See [the project map](docs/PROJECT_MAP.md) before moving files.
