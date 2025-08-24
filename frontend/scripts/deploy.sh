#!/bin/bash

echo "🚀 开始部署叨叨电竞管理系统..."

# 检查环境
if [ ! -f ".env.production" ]; then
    echo "❌ 缺少生产环境配置文件"
    exit 1
fi

# 构建项目
echo "📦 构建项目..."
npm run build

if [ $? -ne 0 ]; then
    echo "❌ 构建失败"
    exit 1
fi

# 上传到服务器
echo "📤 上传到服务器..."
rsync -avz --delete dist/ user@daodao-gaming.com:/var/www/daodao-gaming/

if [ $? -ne 0 ]; then
    echo "❌ 上传失败"
    exit 1
fi

# 重启Nginx
echo "🔄 重启Nginx..."
ssh user@daodao-gaming.com "sudo systemctl reload nginx"

echo "✅ 部署完成！"
echo "🌐 访问地址: https://daodao-gaming.com"
