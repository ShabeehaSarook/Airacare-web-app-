# Deployment

## Render Backend

The repository is `ShabeehaSarook/airacare-web-backend`, branch `main`.
Keep the service root at the repository root.

```text
Build: pip install -r requirements-web.txt
Start: gunicorn web_backend:app --bind 0.0.0.0:$PORT --workers 1 --threads 2 --timeout 180
```

`render.yaml`, `Procfile`, and `runtime.txt` remain at root. Required runtime
assets include `backend/`, `src/`, `config/`, `models/airacare_custom.tflite`, and its labels.
The local UI also uses `frontend/`.

Configure `AIRACARE_MODEL_BACKEND=android_tflite`,
`AIRACARE_INFERENCE_IMAGE_SIZE=320`, and `AIRACARE_TFLITE_THREADS=1`.
Set `CLOUDINARY_URL` and `PHOTOROOM_API_KEY` privately and select the intended
`AIRACARE_BACKGROUND_REMOVAL_ENGINE`. Dashboard environment values may differ
from repository defaults; check the running service.

After reviewing and pushing the intended changes, confirm the commit shown in
Render's deployment log. Use Manual Deploy -> Deploy latest commit if needed.
Then check `/api/health` and perform a real inference/capture test. Cold starts,
resource limits, provider errors and segmentation quality still require testing.

## Firebase Frontend and Rules

`firebase.json` publishes `frontend/`; `.firebaserc` selects the project.
Use the Firebase CLI with an account authorized for that project:

```powershell
firebase deploy --only hosting
```

Deploy security rules only after reviewing their changes:

```powershell
firebase deploy --only firestore:rules
```

Anonymous Authentication, ownership checks, and Firestore permissions must match
the browser implementation. Do not make collections globally writable to resolve
permission errors. Frontend deploys do not deploy Python or change Render secrets.

## Release Verification

1. Confirm backend commit and health/model readiness.
2. Reload the frontend and verify its build identifier/assets.
3. Allow camera access on Android Chrome and iPhone Safari over HTTPS.
4. Test confirmed detection and empty-scene clearing.
5. Capture a dog/cat, inspect PNG transparency and full-body crop.
6. Save, reload My Collection, and check the Firestore record and image URL.
7. Delete the test item and verify both services removed it.

Only report these checks as passing when they were actually performed. This
repository organization does not deploy changes or certify production behavior.
