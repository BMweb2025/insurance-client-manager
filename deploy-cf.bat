@echo off
chcp 65001 >nul
echo ======================================
echo   荐荐保险服务管家 - Cloudflare 一键部署
echo ======================================
echo.

REM 检查 Node.js
where node >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [错误] 未检测到 Node.js，请先安装：https://nodejs.org/
    pause
    exit /b 1
)

REM 检查 npm
where npm >nul 2>&1
if %ERRORLEVEL% neq 0 (
    echo [错误] 未检测到 npm，请先安装 Node.js
    pause
    exit /b 1
)

echo [1/4] 正在安装 Cloudflare Wrangler CLI...
npm install -g wrangler >nul 2>&1
echo [完成] Wrangler 安装成功

echo.
echo [2/4] 正在登录 Cloudflare（请在弹出的浏览器窗口中授权）...
npx wrangler login
if %ERRORLEVEL% neq 0 (
    echo [错误] Cloudflare 授权失败，请确保在浏览器中点击"允许授权"
    echo.
    echo 如果浏览器没有弹出，请手动访问: https://dash.cloudflare.com/sign-in
    echo 登录后告诉我"授权完成"，我来继续部署
    pause
    exit /b 1
)
echo [完成] Cloudflare 授权成功

echo.
echo [3/4] 正在部署到 Cloudflare Pages（这可能需要1-2分钟）...
cd /d "%~dp0"
npx wrangler pages deploy . --project-name=jianshou-insurance --branch=main
if %ERRORLEVEL% neq 0 (
    echo [错误] 部署失败，请将上面的错误信息发给我
    pause
    exit /b 1
)

echo.
echo ======================================
echo   部署成功！
echo ======================================
echo.
echo 你的网站将在以下地址上线（可能需要等待1-2分钟）：
echo.
echo   https://jianshou-insurance.pages.dev/
echo.
echo 私密性：此链接仅你能访问，完美保密！
echo.
pause
