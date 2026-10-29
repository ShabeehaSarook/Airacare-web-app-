# Architecture

## Detection

```text
Browser camera -> resized request frame -> Flask /api/detect
  -> WebDetectionService -> AndroidTfliteDetector
  -> validation / temporal confirmation / tracking
  -> distance / risk / warnings -> response
  -> browser live state and confirmed-event Firestore saving
```

`frontend/app.js` owns camera access, request scheduling, drawing, and Firebase
client calls. `src/web_detection_service.py` orchestrates inference and retains
tracking state; `src/android_tflite_detector.py` loads and decodes the model.
Model tensor dimensions must be inspected independently of the configured
request/inference image-size setting. The eight labels shipped with the TFLite
asset differ from the seven-class dataset documented in earlier training notes.

## Capture & Store

```text
Confirmed dog/cat -> explicit Capture & Store click
  -> crop original video frame using detection coordinates
  -> POST /api/remove-background -> PNG preview
  -> explicit Save -> POST /api/captured-pets/upload
  -> Cloudinary image URL/public ID
  -> Firestore captured_pets metadata -> My Collection
```

PhotoRoom or the configured fallback creates the alpha mask. The preview's
checkerboard is CSS. Cloudinary stores the resulting image; Firebase Storage
is not part of this flow. Firestore contains ownership, label, confidence,
timestamps, image URL/public ID, box, distance/risk, and capture metadata.

Deletion calls `/api/captured-pets/delete` and removes the Firestore record.
Image storage and Firestore are separate services, so save/delete failure paths
must be tested independently. Do not interpret a successful upload as a
successful metadata write.

## API Entry Points

| Method | Path | Responsibility |
| --- | --- | --- |
| GET | `/api/health` | Model/configuration readiness |
| POST | `/api/detect` | Frame detection |
| POST | `/api/remove-background` | Crop segmentation and PNG generation |
| POST | `/api/captured-pets/upload` | PNG upload to Cloudinary |
| POST | `/api/captured-pets/delete` | Cloudinary image deletion |
| GET | `/` and static paths | Local browser UI |

Read route implementations in `backend/app.py` and callers in `frontend/app.js`
together before changing request/response fields. Provider credentials stay on
the backend. `/api/health` reporting a provider as configured does not prove
its credentials, quota, or an actual upload are working.
