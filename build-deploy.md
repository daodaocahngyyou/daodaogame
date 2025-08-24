# 构建和部署指南

## 🚀 构建生产版本

### 1. 前端构建
```bash
cd frontend
npm run build
```
这会在 `frontend/dist/` 目录生成生产版本文件。

### 2. 后端构建
```bash
cd backend
npm run build
```
这会在 `backend/dist/` 目录生成编译后的JavaScript文件。

### 3. 一键构建所有项目
```bash
# 在根目录执行
npm run build:all
```

## 📁 构建后的目录结构

```
项目根目录/
├── frontend/
│   ├── dist/                    # 前端生产版本
│   │   ├── index.html          # 主页面
│   │   ├── assets/             # 静态资源
│   │   └── ...
│   └── ...
├── backend/
│   ├── dist/                    # 后端编译版本
│   │   ├── app.js              # 主应用文件
│   │   ├── middleware/         # 中间件
│   │   └── ...
│   └── ...
└── ...
```

## 🎯 部署选项

### 选项1：本地部署（推荐用于诱饵）
```bash
# 启动后端服务
cd backend
npm start

# 启动前端服务（使用任何静态文件服务器）
cd frontend/dist
npx serve -s . -l 3000
```

### 选项2：Docker部署
```bash
# 使用提供的docker-compose.yml
docker-compose up -d
```

### 选项3：传统服务器部署
```bash
# 将dist文件夹复制到服务器
# 配置Nginx反向代理
# 启动Node.js服务
```

## 🔧 构建配置说明

### 前端构建配置
- 生产环境变量自动注入
- 代码压缩和优化
- 静态资源哈希化
- 自动生成sourcemap（可选）

### 后端构建配置
- TypeScript编译为JavaScript
- 移除开发依赖
- 优化代码结构
- 生成可执行文件

## ⚠️ 注意事项

1. **构建前检查**：确保所有依赖已安装
2. **环境变量**：生产环境变量需要正确配置
3. **文件权限**：确保dist目录有正确的读写权限
4. **端口冲突**：检查端口是否被占用

## 🎭 诱饵效果增强

构建后的dist版本具有以下优势：
- 看起来更专业，像真实的生产系统
- 代码已编译，难以直接查看源码
- 可以部署到任何静态文件服务器
- 更容易伪装成真实的业务系统
