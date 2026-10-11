@echo off
title Smart MIS tunnel - KEEP THIS WINDOW OPEN
echo ============================================================
echo  Starting free tunnel to your Ollama (port 11434)...
echo  Wait a few seconds, then COPY the link that looks like
echo      https://xxxx-xxxx-xxxx.trycloudflare.com
echo  and paste it into the app's "Ollama URL" box (no / at end).
echo  Closing this window stops the tunnel.
echo ============================================================
echo.
cloudflared tunnel --url http://localhost:11434 --http-host-header="localhost:11434"
echo.
echo Tunnel stopped.
pause
