@echo off
title Smart MIS (local)
cd /d "%~dp0"
echo Installing packages (first time only)...
pip install -r requirements.txt
echo.
echo Starting Smart MIS. It opens at http://localhost:8501
streamlit run smart_mis.py
pause
