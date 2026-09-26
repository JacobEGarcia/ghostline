# GHOSTLINE // LOCAL UPLINK

A fully local, uncensored chat uplink for **Qwen3.5-9B Abliterated** running on your own machine via Ollama or LM Studio. Nothing leaves the machine.

- **Zero setup:** double-click `index.html` with Ollama running - `file://` origins are trusted by default.
- **Hosted:** one-time `setx OLLAMA_ORIGINS "https://jacobegarcia.github.io"`, restart Ollama.
- **One-shot Windows setup:** `GHOSTLINE-SETUP.ps1` installs Ollama if missing, sets origins, pulls the model, smoke-tests.

## The model
`ollama pull hf.co/lukey03/Qwen3.5-9B-abliterated-GGUF:Q4_K_M` (5.2 GB, Apache-2.0)

## Features
Streaming responses, tok/s + context telemetry, 5 persona presets + custom system prompt, temperature/context sliders, persistent sessions, .md export, stop button, mobile drawer UI, NERV amber chrome.
