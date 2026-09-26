# GHOSTLINE // LOCAL UPLINK - one-shot setup for the Z13
# Run in PowerShell:  powershell -ExecutionPolicy Bypass -File GHOSTLINE-SETUP.ps1
$ErrorActionPreference = "Stop"
function Say($t){ Write-Host ("[GHOSTLINE] " + $t) -ForegroundColor Yellow }

# 1. Ollama present?
if (-not (Get-Command ollama -ErrorAction SilentlyContinue)) {
    Say "Ollama not found - installing via winget..."
    winget install --id Ollama.Ollama -e --accept-source-agreements --accept-package-agreements
    $env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path","User")
} else { Say "Ollama found: $((ollama --version) 2>$null)" }

# 2. Allow the hosted GHOSTLINE page to talk to Ollama (file:// use needs nothing)
$origins = [Environment]::GetEnvironmentVariable("OLLAMA_ORIGINS","User")
if ($origins -notlike "*jacobegarcia.github.io*") {
    $new = if ($origins) { "$origins;https://jacobegarcia.github.io" } else { "https://jacobegarcia.github.io" }
    [Environment]::SetEnvironmentVariable("OLLAMA_ORIGINS",$new,"User")
    Say "OLLAMA_ORIGINS set for jacobegarcia.github.io"
} else { Say "OLLAMA_ORIGINS already allows the hosted page" }

# 3. Restart Ollama so the env var lands
Say "Restarting Ollama..."
Get-Process ollama -ErrorAction SilentlyContinue | Stop-Process -Force
Start-Process ollama -ArgumentList "serve" -WindowStyle Hidden
Start-Sleep -Seconds 4

# 4. Pull the model (5.2 GB, skipped if already present)
Say "Pulling Qwen3.5-9B-abliterated Q4_K_M (5.2 GB, one time)..."
ollama pull hf.co/lukey03/Qwen3.5-9B-abliterated-GGUF:Q4_K_M

# 5. Smoke test
Say "Smoke test..."
$probe = ollama list | Select-String "abliterated"
if ($probe) { Say "Model present: $($probe.Line.Trim())" } else { throw "Model not listed after pull" }

Say "DONE. Open https://jacobegarcia.github.io/ghostline/ or double-click index.html"
