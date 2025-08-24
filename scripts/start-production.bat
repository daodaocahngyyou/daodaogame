@echo off
chcp 65001 >nul
echo 🚀 启动叨叨电竞管理系统生产版本...

REM 检查dist目录是否存在
if not exist frontend\dist (
    echo ❌ 前端dist目录不存在，请先运行构建脚本
    echo 运行: scripts\build-production.bat
    pause
    exit /b 1
)

if not exist backend\dist (
    echo ❌ 后端dist目录不存在，请先运行构建脚本
    echo 运行: scripts\build-production.bat
    pause
    exit /b 1
)

echo ✅ 检查完成，开始启动服务...

REM 启动后端服务（后台）
echo 🔧 启动后端服务...
start "叨叨电竞后端服务" cmd /k "cd backend && npm start"

REM 等待后端启动
echo ⏳ 等待后端服务启动...
timeout /t 5 /nobreak >nul

REM 启动前端服务
echo 🌐 启动前端服务...
cd frontend\dist
echo 📍 前端服务目录: %cd%
echo 🌐 访问地址: http://localhost:3000
echo 🔧 后端地址: http://localhost:10000
echo.
echo 💡 提示：
echo - 按 Ctrl+C 停止前端服务
echo - 后端服务在另一个窗口中运行
echo - 关闭后端窗口可停止后端服务
echo.
npx serve -s . -l 3000
