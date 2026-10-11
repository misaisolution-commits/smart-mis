@echo off
title Smart MIS tunnel - KEEP THIS WINDOW OPEN
set "APP=https://smart-mis-arwrkpjssa9rfonlc97qje.streamlit.app"
set "LOG=%TEMP%\cf_tunnel.log"
del "%LOG%" >nul 2>&1

echo ============================================================
echo  Starting free tunnel to your Ollama (port 11434)...
echo  Please wait about 15 seconds. Do NOT close this window
echo  and do NOT press Ctrl+C (that stops the tunnel).
echo ============================================================
echo.

rem Background helper: finds the new link, copies it, opens your app with it.
start "" /b powershell -NoProfile -Command "$u=$null; for($i=0;$i -lt 90 -and -not $u;$i++){Start-Sleep 1; if(Test-Path $env:TEMP\cf_tunnel.log){$m=Select-String -Path $env:TEMP\cf_tunnel.log -Pattern 'https://(?!api\.)[a-z0-9-]+\.trycloudflare\.com' | Select-Object -First 1; if($m){$u=$m.Matches[0].Value}}}; if($u){Set-Clipboard $u; Write-Host ''; Write-Host 'YOUR LINK (already copied to clipboard):'; Write-Host $u; Write-Host ''; Write-Host 'Opening your app with the link filled in...'; Start-Process ($env:APP + '/?ollama=' + $u)} else {Write-Host 'Could not find the link. Check your internet and run this file again.'}"

cloudflared tunnel --url http://localhost:11434 --http-host-header="localhost:11434" > "%LOG%" 2>&1

echo.
echo Tunnel stopped. Double-click start_tunnel.bat again to get a new link.
pause
