# Backend

`app.py` contains Flask routes, background removal, and Cloudinary integration.
It uses shared detection/risk modules in `../src/` and assets in `../models/`.

From the repository root, run `python -m backend.app` with the web dependencies
installed. The root `web_backend.py` compatibility entry point preserves existing
Render `gunicorn web_backend:app` and Windows launcher commands.

Dependencies remain in root `requirements-web.txt`. Secrets belong in environment
variables; see ../docs/SETUP.md. Run commands from the root so calibration paths resolve.
