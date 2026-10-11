# Deploying Smart MIS on Streamlit Community Cloud

## Files you need in your GitHub repo

```
your-repo/
├── smart_mis.py        <- your app (rename if you like)
├── requirements.txt    <- packages (provided)
└── .gitignore          <- keeps junk and secrets out (provided)
```

---

## Part 1: Fix one bug before you deploy

In `smart_mis.py`, inside `report_docx`, find this line:

```python
for chunk in re.split(r"(\\*\\*.+?\\*\\*)", _plain(text)):
```

Replace it with:

```python
for chunk in re.split(r"(\*\*.+?\*\*)", _plain(text)):
```

Without this, bold text in the Word download will not work.

---

## Part 2: Put the code on GitHub

1. Create a free account at https://github.com if you don't have one.
2. Click **New repository**. Name it `smart-mis`. Choose **Private** if the app is for internal use. Click **Create repository**.
3. Click **Add file > Upload files**.
4. Drag in `smart_mis.py`, `requirements.txt` and `.gitignore`.
5. Click **Commit changes**.

(Command-line alternative:)

```bash
git init
git add smart_mis.py requirements.txt .gitignore
git commit -m "Smart MIS"
git branch -M main
git remote add origin https://github.com/<your-username>/smart-mis.git
git push -u origin main
```

---

## Part 3: Deploy on Streamlit

1. Go to https://share.streamlit.io and click **Sign in with GitHub**.
2. Authorize Streamlit to access your repositories (including private ones, if applicable).
3. Click **Create app** > **Deploy a public app from GitHub**.
4. Fill in:
   - **Repository:** `<your-username>/smart-mis`
   - **Branch:** `main`
   - **Main file path:** `smart_mis.py`
5. Click **Advanced settings** and pick Python **3.11** or **3.12**.
6. Click **Deploy** and wait 2 to 5 minutes while packages install.
7. Your app opens at `https://<something>.streamlit.app`.

---

## Part 4: Make the AI work (Ollama)

The app calls Ollama at `http://localhost:11434`. On Streamlit Cloud, "localhost" is Streamlit's server, not your PC, so you must give the app a reachable Ollama URL.

### Option A: Tunnel your own PC (fastest)

1. Install Ollama and pull a model: `ollama pull qwen2.5:7b`
2. Install Cloudflare Tunnel: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/downloads/
3. Run:
   ```bash
   cloudflared tunnel --url http://localhost:11434
   ```
4. Copy the `https://xxxx.trycloudflare.com` URL it prints.
5. Open your deployed app, go to the sidebar, and paste that URL into **Ollama URL**.

Notes: your PC must stay on, the URL changes each time you restart the tunnel, and anyone with the URL can use your Ollama.

### Option B: Run Ollama on a server (more reliable)

1. Rent a VPS (a GPU one for good speed).
2. Install Ollama and pull a model.
3. Put it behind HTTPS with a password or API-key proxy (for example Nginx or Caddy).
4. Paste the server URL into **Ollama URL** in the app.

### Option C: Use a hosted AI API (best for a public app)

Replace `llm()` and `llm_stream()` with calls to a hosted API, and store the key in Streamlit Secrets (see Part 5). Ask me and I will make this change for you.

---

## Part 5: Secrets and access control

**Store secrets (API keys, passwords):**
1. In Streamlit Cloud, open your app > **Settings** > **Secrets**.
2. Add, for example:
   ```toml
   APP_PASSWORD = "choose-a-strong-password"
   OLLAMA_URL = "https://xxxx.trycloudflare.com"
   ```
3. Read them in code with `st.secrets["APP_PASSWORD"]`.

**Restrict who can open the app:**
1. App > **Settings** > **Sharing**.
2. Choose **Only specific people can view this app** and add email addresses.

**Why this matters:** the app runs AI-generated pandas code with `exec`. The regex blocklist is a basic guard, not a sandbox. Do not leave it open to the public, and do not upload confidential data to a public app.

---

## Part 6: Updating the app later

Push any change to GitHub (edit the file on github.com and commit). Streamlit redeploys automatically within a minute.

## Troubleshooting

| Problem | Fix |
|---|---|
| `ModuleNotFoundError` | Add the missing package to `requirements.txt`, commit |
| "Ollama not detected" | Wrong URL, or tunnel/server is down |
| App sleeps after inactivity | Normal on the free tier; click "Wake up" |
| Word/PDF buttons greyed out | `python-docx` / `reportlab` missing from `requirements.txt` |
| `.xls` files fail | Make sure `xlrd` is in `requirements.txt` |
