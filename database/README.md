# Database

Firestore is hosted externally. This folder contains its security rules and
schema documentation, not database contents. Root `firebase.json` points here.
Browser authentication, detection saving, and collection queries currently live
in `frontend/app.js`. Check `firestore.rules` for collection access requirements.

`captured_pets` stores owner ID, pet label/confidence, bounding box, distance/risk,
capture timestamps, image URL, Cloudinary public ID, and segmentation metadata.
Normal detection history is separate and retains its existing rules and schema.

Cloudinary stores PNG images. Firebase Storage is not used for captured pets.
Deploy reviewed rules from the root with `firebase deploy --only firestore:rules`.
Moving the rule file does not change its permissions.
