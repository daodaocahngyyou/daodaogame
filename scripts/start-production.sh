#!/bin/bash

echo "🚀 启动叨叨电竞管理系统生产版本..."

# 检查dist目录是否存在
if [ ! -d "frontend/dist" ]; then
    echo "❌ 前端dist目录不存在，请先运行构建脚本"
    echo "运行: ./scripts/build-production.sh"
    exit 1
fi

if [ ! -d "backend/dist" ]; then
    echo "❌ 后端dist目录不存在，请先运行构建脚本"
    echo "运行: ./scripts/build-production.sh"
    exit 1
fi

echo "✅ 检查完成，开始启动服务..."

# 启动后端服务（后台）
echo "🔧 启动后端服务..."
cd backend
npm start &
BACKEND_PID=$!
cd ..

# 等待后端启动
echo "⏳ 等待后端服务启动..."
sleep 5

# 启动前端服务
echo "🌐 启动前端服务..."
cd frontend/dist
echo "📍 前端服务目录: $(pwd)"
echo "🌐 访问地址: http://localhost:3000"
echo "🔧 后端地址: http://localhost:10000"
echo ""
echo "💡 提示："
echo "- 按 Ctrl+C 停止前端服务"
echo "- 后端服务PID: $BACKEND_PID"
echo "- 停止后端: kill $BACKEND_PID"
echo ""

# 捕获Ctrl+C信号
trap 'echo ""; echo "🛑 正在停止服务..."; kill $BACKEND_PID 2>/dev/null; echo "✅ 服务已停止"; exit 0' INT

# 启动前端服务
npx serve -s . -l 3000
