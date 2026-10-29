# Local Setup

## Current Web App

Use Python compatible with `requirements-web.txt` and its native TFLite runtime.
Render is configured for Python 3.11.9. On a new machine, run in PowerShell:

```powershell
cd C:\path\to\airacare-animal-detector
py -3.11 -m venv venv
.\venv\Scripts\python.exe -m pip install -r requirements-web.txt
$env:AIRACARE_MODEL_BACKEND = "android_tflite"
$env:AIRACARE_INFERENCE_IMAGE_SIZE = "320"
$env:AIRACARE_TFLITE_THREADS = "1"
.\venv\Scripts\python.exe web_backend.py
```

Open http://localhost:8000/?api=http://localhost:8000 and check
http://localhost:8000/api/health. The backend serves `frontend/` directly;
there is no Node frontend build step. `run_web_backend.bat` is also available
when the virtual environment is already installed.

Confirm `models/airacare_custom.tflite` and its label file exist. Installation
may fail if the selected Python/platform has no compatible LiteRT wheel;
use a supported environment rather than silently substituting a different model.
Gunicorn is the Linux hosting entry point; use `web_backend.py` on Windows.

Camera access on a remote phone needs HTTPS and browser permission. Plain
HTTP on a laptop's LAN IP is not equivalent to trusted localhost on the laptop.

## External Services

Set secrets privately in the process environment or hosting dashboard:

| Variable | Purpose |
| --- | --- |
| `CLOUDINARY_URL` | Cloudinary server-side upload credentials |
| `PHOTOROOM_API_KEY` | PhotoRoom server-side segmentation credentials |
| `AIRACARE_BACKGROUND_REMOVAL_ENGINE` | For example `photoroom`; code also supports fallback modes |
| `AIRACARE_CLOUDINARY_FOLDER` | Optional image folder; default `airacare/captured_pets` |
| `AIRACARE_WEB_PORT` | Local port; default 8000, overridden by `PORT` |

The backend reads environment variables directly. A `.env` file is not
automatically loaded by the current startup code. Never put secrets into
`frontend/` or commit them. Firebase browser project configuration is in
`frontend/app.js`; Firestore rules and Authentication must match that project.
Using the existing Firebase configuration can write to the existing database.

## Desktop and Dataset Tools

`requirements.txt` is for desktop OpenCV/YOLO tools; `requirements-dataset.txt`
adds optional dataset-download dependencies. Prefer separate virtual environments
for desktop and web development because they install different OpenCV variants.
Read [historical development instructions](history/DEVELOPMENT_PHASES.md) and
the dataset README before running training, augmentation, or calibration scripts.

## Checks

From the repository root:

```powershell
.\venv\Scripts\python.exe -m compileall web_backend.py backend src tests
.\venv\Scripts\python.exe -m unittest discover -s tests -p "test_*.py"
```

Tests are not a substitute for camera and external-service checks. Manually
verify detection, no-detection state, dog/cat capture, PNG preview, save, gallery
reload, and delete on a real phone. Verify that non-pet classes cannot trigger
Capture & Store. Use test records and clean them up afterward.
