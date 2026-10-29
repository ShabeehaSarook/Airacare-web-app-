# Airacare Future Validation Notes

These items are not required for the current webcam-only prototype run, but should be completed before claiming full physical-distance accuracy or phone-camera readiness.

Paths and commands are relative to the repository root. Checklist items are
not evidence of completed tests.

## Physical Distance Accuracy

Status: Pending

Validate the calibrated webcam distance estimate at measured real-world distances:

- 2 m
- 3 m
- 4 m
- 5 m

For each test, record:

- actual distance
- estimated Airacare distance
- absolute error
- percentage error
- notes about lighting, camera position, and whether the full body/object was visible

Use this CSV to record future measured distance checks:

```text
results/distance_validation_template.csv
```

Do not claim exact distance accuracy until these measurements are completed.

## Phone Calibration

Status: Pending, not needed for webcam testing

Phone calibration is only required when running Airacare with an IP Webcam source.

The project includes a non-runtime template at:

```text
config/phone_calibration.example.json
```

Do not rename or use that template as the real calibration file. The real phone file must be created from the phone camera because focal length depends on the phone lens, resolution, and zoom.

Create it later with:

```powershell
.\calibrate_phone_camera.bat
```

or manually:

```powershell
python -m src.calibrate_distance --camera-source "http://PHONE_IP:8080/video" --model-mode pretrained --calibration-object person --known-height 1.70 --known-distance 3.0 --output config/phone_calibration.json
```

Replace `PHONE_IP` with the real phone IP address shown by the IP Webcam app.
