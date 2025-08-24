#!/bin/bash

echo "🚀 开始构建叨叨电竞管理系统生产版本..."

# 检查Node.js版本
NODE_VERSION=$(node -v)
echo "📦 Node.js版本: $NODE_VERSION"

# 清理之前的构建
echo "🧹 清理之前的构建文件..."
rm -rf frontend/dist backend/dist

# 安装依赖
echo "📥 安装前端依赖..."
cd frontend
npm install
if [ $? -ne 0 ]; then
    echo "❌ 前端依赖安装失败"
    exit 1
fi

# 构建前端
echo "🔨 构建前端项目..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ 前端构建失败"
    exit 1
fi
echo "✅ 前端构建完成"

# 返回根目录
cd ..

# 安装后端依赖
echo "📥 安装后端依赖..."
cd backend
npm install
if [ $? -ne 0 ]; then
    echo "❌ 后端依赖安装失败"
    exit 1
fi

# 构建后端
echo "🔨 构建后端项目..."
npm run build
if [ $? -ne 0 ]; then
    echo "❌ 后端构建失败"
    exit 1
fi
echo "✅ 后端构建完成"

# 返回根目录
cd ..

# 创建生产环境配置文件
echo "📝 创建生产环境配置..."
cat > frontend/dist/.env.production << EOF
# 生产环境配置
VITE_APP_TITLE=叨叨电竞管理系统
VITE_APP_API_BASE_URL=https://api.daodao-gaming.com
VITE_APP_VERSION=2.0.0
VITE_APP_ENV=production
EOF

# 创建部署说明文件
echo "📋 创建部署说明..."
cat > frontend/dist/DEPLOY.md << EOF
# 部署说明

## 快速启动

### 1. 启动后端服务
\`\`\`bash
cd backend
npm start
\`\`\`

### 2. 启动前端服务
\`\`\`bash
# 使用serve（推荐）
npx serve -s . -l 3000

# 或使用其他静态文件服务器
python -m http.server 3000
\`\`\`

## 访问地址
- 前端: http://localhost:3000
- 后端: http://localhost:10000

## 注意事项
- 确保后端服务已启动
- 检查端口是否被占用
- 生产环境请配置HTTPS
EOF

# 显示构建结果
echo ""
echo "🎉 构建完成！"
echo ""
echo "📁 构建结果:"
echo "  前端: frontend/dist/"
echo "  后端: backend/dist/"
echo ""
echo "🚀 启动命令:"
echo "  后端: cd backend && npm start"
echo "  前端: cd frontend/dist && npx serve -s . -l 3000"
echo ""
echo "🌐 访问地址:"
echo "  前端: http://localhost:3000"
echo "  后端: http://localhost:10000"
echo ""
echo "📋 详细部署说明请查看: frontend/dist/DEPLOY.md"
