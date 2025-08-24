@echo off
chcp 65001 >nul
echo 🚀 开始构建叨叨电竞管理系统生产版本...

REM 检查Node.js版本
for /f "tokens=*" %%i in ('node -v') do set NODE_VERSION=%%i
echo 📦 Node.js版本: %NODE_VERSION%

REM 清理之前的构建
echo 🧹 清理之前的构建文件...
if exist frontend\dist rmdir /s /q frontend\dist
if exist backend\dist rmdir /s /q backend\dist

REM 安装前端依赖
echo 📥 安装前端依赖...
cd frontend
call npm install
if %errorlevel% neq 0 (
    echo ❌ 前端依赖安装失败
    exit /b 1
)

REM 构建前端
echo 🔨 构建前端项目...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ 前端构建失败
    exit /b 1
)
echo ✅ 前端构建完成

REM 返回根目录
cd ..

REM 安装后端依赖
echo 📥 安装后端依赖...
cd backend
call npm install
if %errorlevel% neq 0 (
    echo ❌ 后端依赖安装失败
    exit /b 1
)

REM 构建后端
echo 🔨 构建后端项目...
call npm run build
if %errorlevel% neq 0 (
    echo ❌ 后端构建失败
    exit /b 1
)
echo ✅ 后端构建完成

REM 返回根目录
cd ..

REM 创建生产环境配置文件
echo 📝 创建生产环境配置...
(
echo # 生产环境配置
echo VITE_APP_TITLE=叨叨电竞管理系统
echo VITE_APP_API_BASE_URL=https://api.daodao-gaming.com
echo VITE_APP_VERSION=2.0.0
echo VITE_APP_ENV=production
) > frontend\dist\.env.production

REM 创建部署说明文件
echo 📋 创建部署说明...
(
echo # 部署说明
echo.
echo ## 快速启动
echo.
echo ### 1. 启动后端服务
echo ```bash
echo cd backend
echo npm start
echo ```
echo.
echo ### 2. 启动前端服务
echo ```bash
echo # 使用serve（推荐）
echo npx serve -s . -l 3000
echo.
echo # 或使用其他静态文件服务器
echo python -m http.server 3000
echo ```
echo.
echo ## 访问地址
echo - 前端: http://localhost:3000
echo - 后端: http://localhost:10000
echo.
echo ## 注意事项
echo - 确保后端服务已启动
echo - 检查端口是否被占用
echo - 生产环境请配置HTTPS
) > frontend\dist\DEPLOY.md

REM 显示构建结果
echo.
echo 🎉 构建完成！
echo.
echo 📁 构建结果:
echo   前端: frontend\dist\
echo   后端: backend\dist\
echo.
echo 🚀 启动命令:
echo   后端: cd backend ^&^& npm start
echo   前端: cd frontend\dist ^&^& npx serve -s . -l 3000
echo.
echo 🌐 访问地址:
echo   前端: http://localhost:3000
echo   后端: http://localhost:10000
echo.
echo 📋 详细部署说明请查看: frontend\dist\DEPLOY.md

pause
