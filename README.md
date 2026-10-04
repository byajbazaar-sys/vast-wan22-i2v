# Vast.ai Serverless — Wan2.2 I2V 14B FP8

Target: **Wan2.2 I2V 14B FP8 + ComfyUI** on a Vast.ai Serverless worker.

## Model assets

The official ComfyUI Wan2.2 14B I2V workflow uses:

- `wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors`
- `wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors`
- `wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors`
- `wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors`
- `umt5_xxl_fp8_e4m3fn_scaled.safetensors`
- `wan_2.1_vae.safetensors`

Official workflow:
https://github.com/Comfy-Org/workflow_templates/blob/main/templates/video_wan2_2_14B_i2v.json

## Provisioning

Run:

```bash
bash scripts/provision_wan22_i2v.sh
```

The script is intentionally idempotent: existing model files are not downloaded again.

## Vast configuration

Recommended starting point:

- Template: `ComfyUI (Serverless)`
- GPU: RTX PRO 6000 WS 96 GB
- GPU count: 1
- Worker minimum: 0
- Worker maximum: 1
- Disk: about 125 GB
- Target output: 1280x720

Do not put Vast API keys, Hugging Face tokens, S3 credentials, or other secrets in this repository.

## Important

The Vast ComfyUI Serverless template already provides the ComfyUI/API/PyWorker runtime. This repository is for the model provisioning assets and workflow configuration; do not replace Vast's worker runtime with an unverified custom implementation.
