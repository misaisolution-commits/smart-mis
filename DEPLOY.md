# Smart MIS - free setup guide (Ollama + Streamlit)

Everything here is free: GitHub, Streamlit Community Cloud, Ollama, Cloudflare tunnel.

## Files in this package
| File | Upload to GitHub? | Purpose |
|---|---|---|
| smart_mis.py | Yes | The app |
| requirements.txt | Yes | Python packages |
| .gitignore | Optional | Keeps secrets out of Git |
| secrets_example.toml | No | Copy its lines into Streamlit Secrets |
| start_tunnel.bat | No (keep on your PC) | Double-click to start the free tunnel |
| run_local.bat | No (keep on your PC) | Double-click to run the app on your PC only |

---

## Option A - Run only on your PC (simplest)
1. Put all files in one folder.
2. Double-click `run_local.bat`.
3. Open http://localhost:8501. The Ollama URL is already correct.
4. Colleagues on the same Wi-Fi can open http://YOUR-PC-IP:8501
   (find your IP with `ipconfig` > IPv4 Address).

## Option B - Online from anywhere (Streamlit Cloud + your PC as the AI)

### B1. Put the code on GitHub (once)
1. Open your repo https://github.com/misaisolution-commits/smart-mis
2. Add file > Upload files > drag in `smart_mis.py` and `requirements.txt`.
3. Click Commit changes. (Same file name = it replaces the old one.)

### B2. Deploy on Streamlit (once)
1. share.streamlit.io > Create app.
2. Repository: misaisolution-commits/smart-mis | Branch: main | Main file: smart_mis.py
3. Advanced settings > Python 3.11 or 3.12 > Deploy.
4. If it says "repository does not exist": the repo is private and Streamlit can't see
   it. Make the repo Public (Settings > Danger Zone > Change visibility), or link
   private-repo access in Streamlit (profile > Settings > Linked accounts).

### B3. Every time you want to use it
1. Make sure Ollama is running (`ollama list` shows your models).
2. Double-click `start_tunnel.bat` and KEEP THE WINDOW OPEN.
3. Copy the `https://....trycloudflare.com` link it prints.
4. Test it in your BROWSER (not PowerShell): add `/api/tags` to the end.
   You should see your model names.
5. Open your Streamlit app. In the sidebar set:
   - AI provider: Ollama (free - local / tunnel)
   - Ollama URL: the link (no `/` at the end)
   - Model: qwen2.5-coder:7b (accurate) or qwen2.5:3b (faster)
6. Upload your file > pick a prompt > Generate Report.

The link changes every time the tunnel restarts, so paste the new one each time.
(Optional: save it in Streamlit Settings > Secrets as OLLAMA_URL = "...".)

### B4. Protect the app
- Streamlit app > Settings > Secrets: add `APP_PASSWORD = "your-password"`.
- Streamlit app > Settings > Sharing: restrict viewers by email.
- The app runs AI-written pandas code. The built-in filter is a basic guard, not a
  true sandbox, so do not leave the app open to the public.
- Anyone with your tunnel link can use your Ollama while the tunnel runs. Don't share it.

---

## Troubleshooting
| Problem | Fix |
|---|---|
| "Could not reach the AI service ... localhost" | The sidebar still has localhost. Paste the tunnel link. |
| "Ollama not detected" | Tunnel window closed, link changed, or Ollama is not running. |
| Link test shows an error page | Run `ollama list`; start Ollama from the Start menu. |
| 'cloudflared' is not recognized | `winget install --id Cloudflare.cloudflared`, then reopen the window. |
| First report is very slow | Normal: the model is loading. Try qwen2.5:3b for speed. |
| ModuleNotFoundError | Add the package to requirements.txt and commit. |
| Word/PDF buttons greyed out | python-docx / reportlab missing from requirements.txt. |
| App asleep | Free tier sleeps when idle. Click "Wake up". |
