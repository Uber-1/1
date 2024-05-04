@echo off
@title r3dfox Portable Creator - ver.4.6.1 [05.05.2024]
@cd /d "%~dp0"

@if not exist "curl.exe" (@if not exist "%SystemRoot%\SYSTEM32\curl.exe" (
@echo Checking version with powershell . . .
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Eclipse-Community/r3dfox/releases/latest', 'latest')"
)) else (
@echo Checking version with CURL . . .
@curl.exe -RL# "https://github.com/Eclipse-Community/r3dfox/releases/latest" -o "latest"
)

@for /f "eol=- tokens=1-26 delims=v " %%a in ('@type "latest" ^| @FINDSTR /IRC:"title.*.Release.v.*.r3dfox"') do (@if NOT DEFINED r3dfoxLatest (@set r3dfoxLatest=%%c))
@echo r3dfox Latest Version: [%r3dfoxLatest%]
@del "latest" /q

@if not exist "curl.exe" (@if not exist "%SystemRoot%\SYSTEM32\curl.exe" (
@echo Downloading with powershell . . .
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Eclipse-Community/r3dfox/releases/download/%r3dfoxLatest%/r3dfox-%r3dfoxLatest%.en-US.win32.installer.exe', 'r3dfwin.exec')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://www.7-zip.org/a/7zr.exe', '7zr.exe')"
)) else (
@echo Downloading with CURL . . .
@curl.exe -RL# "https://github.com/Eclipse-Community/r3dfox/releases/download/%r3dfoxLatest%/r3dfox-%r3dfoxLatest%.en-US.win32.installer.exe" -o "r3dfwin.exec"
@curl.exe -RLO# "https://www.7-zip.org/a/7zr.exe"
)

@md "r3dfoxPortable\core\defaults\pref"
@md "r3dfoxPortable\core\distribution"
@"7zr.exe" x -t7z -bso0 "r3dfwin.exec" -o"r3dfoxPortable" -xr!setup.exe -xr!*crashreporter* -xr!*default*agent* -xr!maintenanceservice*.exe -xr!minidump-analyzer.exe -xr!updater* -xr!uninstall
@del "7zr.exe" "r3dfwin.exec" /q

@md "r3dfoxPortable\portable"
@md "r3dfoxPortable\portable\chrome"

@if not exist "curl.exe" (@if not exist "%SystemRoot%\SYSTEM32\curl.exe" (
@echo Downloading with powershell . . .
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/autoconfiglocal.js', 'r3dfoxPortable\core\autoconfiglocal.js')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/autoconfig.js', 'r3dfoxPortable\core\defaults\pref\autoconfig.js')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/distribution.ini', 'r3dfoxPortable\core\distribution\distribution.ini')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/policies.json', 'r3dfoxPortable\core\distribution\policies.json')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/userContent.css', 'r3dfoxPortable\portable\chrome\userContent.css')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/userChrome.css', 'r3dfoxPortable\portable\chrome\userChrome.css')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://github.com/Uber-1/Toys/raw/main/Firefox/prefs.js', 'r3dfoxPortable\portable\prefs.js')"
)) else (
@echo Downloading with CURL . . .
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/autoconfiglocal.js" -o "r3dfoxPortable\core\autoconfiglocal.js"
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/autoconfig.js" -o "r3dfoxPortable\core\defaults\pref\autoconfig.js"
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/distribution.ini" -o "r3dfoxPortable\core\distribution\distribution.ini"
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/policies.json" -o "r3dfoxPortable\core\distribution\policies.json"
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/userContent.css" -o "r3dfoxPortable\portable\chrome\userContent.css"
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/userChrome.css" -o "r3dfoxPortable\portable\chrome\userChrome.css"
@curl -RL# "https://github.com/Uber-1/Toys/raw/main/Firefox/prefs.js" -o "r3dfoxPortable\portable\prefs.js"
)
(@echo {"windows":[],"selectedWindow":0,"_closedWindows":[],"session":{},"scratchpads":[],"global":{}})>"r3dfoxPortable\portable\sessionstore.js"
(@echo @cd core&@echo @start r3dfox.exe -no-remote -profile ..\portable %%*)>"r3dfoxPortable\r3dfoxPortable.bat"

@md "r3dfoxPortable\portable\extensions"
@if not exist "curl.exe" (@if not exist "%SystemRoot%\SYSTEM32\curl.exe" (
@echo Downloading with powershell . . .
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/', 'r3dfoxPortable\portable\extensions\{9a41dee2-b924-4161-a971-7fb35c053a4a}.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/hls-stream-detector/', 'r3dfoxPortable\portable\extensions\@m3u8link.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/noscript/', 'r3dfoxPortable\portable\extensions\{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/save-page-we/', 'r3dfoxPortable\portable\extensions\savepage-we@DW-dev.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/send-to-my-phone-qr-code-gener/', 'r3dfoxPortable\portable\extensions\jid1-dgAsBwQgc4SQBk@jetpack.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/smart-rss-reader/', 'r3dfoxPortable\portable\extensions\smart-rss@mozilla.firefox.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/', 'r3dfoxPortable\portable\extensions\uBlock0@raymondhill.net.xpi')"
@powershell -Command "(New-Object Net.WebClient).DownloadFile('https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/', 'r3dfoxPortable\portable\extensions\sponsorBlocker@ajay.app.xpi')"
)) else (
@echo Downloading with CURL . . .
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/enhanced-h264ify/" -o "r3dfoxPortable\portable\extensions\{9a41dee2-b924-4161-a971-7fb35c053a4a}.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/hls-stream-detector/" -o "r3dfoxPortable\portable\extensions\@m3u8link.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/noscript/" -o "r3dfoxPortable\portable\extensions\{73a6fe31-595d-460b-a920-fcc0f8843232}.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/save-page-we/" -o "r3dfoxPortable\portable\extensions\savepage-we@DW-dev.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/send-to-my-phone-qr-code-gener/" -o "r3dfoxPortable\portable\extensions\jid1-dgAsBwQgc4SQBk@jetpack.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/smart-rss-reader/" -o "r3dfoxPortable\portable\extensions\smart-rss@mozilla.firefox.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/" -o "r3dfoxPortable\portable\extensions\uBlock0@raymondhill.net.xpi"
@curl -RL# "https://addons.mozilla.org/firefox/downloads/latest/sponsorblock/" -o "r3dfoxPortable\portable\extensions\sponsorBlocker@ajay.app.xpi"
)
