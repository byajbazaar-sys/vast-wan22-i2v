#!/usr/bin/env bash
set -euo pipefail

# Wan2.2 I2V 14B FP8 model provisioning for Vast.ai ComfyUI Serverless.
# This script downloads only the model assets; the Vast ComfyUI Serverless
# template provides ComfyUI, the API wrapper and PyWorker runtime.

COMFY_DIR="${COMFY_DIR:-/workspace/ComfyUI}"
MODEL_DIR="$COMFY_DIR/models"

mkdir -p \
  "$MODEL_DIR/diffusion_models" \
  "$MODEL_DIR/loras" \
  "$MODEL_DIR/text_encoders" \
  "$MODEL_DIR/vae"

download() {
  local url="$1"
  local dest="$2"

  if [ -f "$dest" ]; then
    echo "Already exists: $dest"
    return
  fi

  echo "Downloading: $(basename "$dest")"
  wget -c --progress=dot:giga "$url" -O "$dest"
}

# Wan2.2 I2V 14B FP8 diffusion experts (~13.31 GB each)
download \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors" \
  "$MODEL_DIR/diffusion_models/wan2.2_i2v_high_noise_14B_fp8_scaled.safetensors"

download \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors" \
  "$MODEL_DIR/diffusion_models/wan2.2_i2v_low_noise_14B_fp8_scaled.safetensors"

# LightX2V 4-step LoRAs (~1.14 GB each)
download \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors" \
  "$MODEL_DIR/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_high_noise.safetensors"

download \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors" \
  "$MODEL_DIR/loras/wan2.2_i2v_lightx2v_4steps_lora_v1_low_noise.safetensors"

# Text encoder (~6.27 GB)
download \
  "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" \
  "$MODEL_DIR/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

# VAE (~242 MB)
download \
  "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" \
  "$MODEL_DIR/vae/wan_2.1_vae.safetensors"

echo
echo "Wan2.2 I2V model provisioning complete."
du -sh "$MODEL_DIR"/* 2>/dev/null || true
