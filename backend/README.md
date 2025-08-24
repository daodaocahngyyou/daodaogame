# PayBoard 后端服务

基于 Node.js + TypeScript + Express + Sequelize 的网吧代练管理系统后端服务。

## 功能特性

- 🔐 JWT 用户认证与授权
- 👥 会员管理（注册、充值、消费记录）
- 🎮 陪玩管理（信息管理、订单分配）
- 📋 订单管理（下单、支付、统计）
- 💰 充值管理（余额充值、支付方式）
- 📊 报表统计（今日概览、趋势分析、排行榜）
- 🤖 企业微信通知（充值、订单、异常提醒）
- 🛡️ 数据安全（敏感信息脱敏、参数验证）

## 技术栈

- **运行环境**: Node.js 16+
- **开发语言**: TypeScript
- **Web框架**: Express.js
- **数据库**: MySQL 8.0+
- **ORM**: Sequelize
- **认证**: JWT (jsonwebtoken)
- **密码加密**: bcryptjs
- **参数验证**: express-validator
- **安全防护**: helmet, cors
- **HTTP客户端**: axios
- **开发工具**: nodemon, ts-node

## 项目结构

```
payboard-backend/
├── src/
│   ├── config/          # 配置文件
│   │   └── database.ts  # 数据库配置
│   ├── middleware/      # 中间件
│   │   └── auth.ts      # 认证中间件
│   ├── models/          # 数据模型
│   │   ├── Member.ts    # 会员模型
│   │   ├── Worker.ts    # 陪玩模型
│   │   ├── task.ts     # 订单模型
│   │   ├── Recharge.ts  # 充值模型
│   │   ├── User.ts      # 用户模型
│   │   └── index.ts     # 模型入口
│   ├── routes/          # 路由控制器
│   │   ├── auth.ts      # 认证路由
│   │   ├── user.ts   # 会员路由
│   │   ├── stafff.ts   # 陪玩路由
│   │   ├── tasks.ts    # 订单路由
│   │   ├── recharges.ts # 充值路由
│   │   ├── reports.ts   # 报表路由
│   │   └── index.ts     # 路由入口
│   ├── services/        # 业务服务
│   │   └── wechat.ts    # 企业微信服务
│   ├── utils/           # 工具函数
│   │   └── index.ts     # 工具函数集合
│   └── app.ts           # 应用入口
├── .env.example         # 环境变量示例
├── package.json         # 项目配置
├── tsconfig.json        # TypeScript配置
└── README.md           # 项目说明
```

## 快速开始

### 1. 环境要求

- Node.js 16.0+
- MySQL 8.0+
- npm 或 yarn

### 2. 安装依赖

```bash
cd payboard-backend
npm install
```

### 3. 配置环境变量

复制环境变量示例文件并修改配置：

```bash
cp .env.example .env
```

编辑 `.env` 文件，配置数据库连接和其他参数：

```env
# 服务器配置
PORT=3000
NODE_ENV=development

# 数据库配置
DB_HOST=localhost
DB_PORT=3306
DB_NAME=payboard
DB_USER=root
DB_PASSWORD=your_password

# JWT配置
JWT_SECRET=your_jwt_secret_key_here
JWT_EXPIRES_IN=24h

# 企业微信配置（可选）
WECHAT_WEBHOOK_URL=https://qyapi.weixin.qq.com/cgi-bin/webhook/send?key=your_key

# CORS配置
CORS_ORIGIN=http://localhost:5173
```

### 4. 创建数据库

在 MySQL 中创建数据库：

```sql
CREATE DATABASE payboard CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
```

### 5. 启动开发服务器

```bash
# 开发模式（自动重启）
npm run dev

# 或者构建后启动
npm run build
npm start
```

服务器将在 `http://localhost:3001` 启动。

### 6. 验证安装

访问健康检查接口：

```bash
curl http://localhost:3001/health
```

应该返回：

```json
{
  "code": 200,
  "message": "PayBoard API服务运行正常",
  "data": {
    "timestamp": "2024-01-01T00:00:00.000Z",
    "version": "1.0.0",
    "environment": "development"
  }
}
```

## API 文档

### 基础信息

- **Base URL**: `http://localhost:3001/api/v1`
- **认证方式**: Bearer Token (JWT)
- **请求头**: `Authorization: Bearer <token>`

### 主要接口

#### 认证相关

- `POST /auth/admin` - 用户登录
- `GET /auth/me` - 获取当前用户信息
- `PUT /auth/password` - 修改密码
- `POST /auth/logout` - 用户登出

#### 会员管理

- `GET /user` - 获取会员列表
- `POST /user` - 创建会员
- `GET /user/:id` - 获取会员详情
- `PUT /user/:id` - 更新会员
- `DELETE /user/:id` - 删除会员

#### 订单管理

- `GET /tasks` - 获取订单列表
- `POST /tasks` - 创建订单
- `GET /tasks/:id` - 获取订单详情
- `POST /tasks/calculate-price` - 计算订单价格

#### 充值管理

- `GET /recharges` - 获取充值记录
- `POST /recharges` - 创建充值记录
- `GET /recharges/stats/summary` - 充值统计

#### 陪玩管理

- `GET /stafff` - 获取陪玩列表
- `POST /stafff` - 创建陪玩
- `GET /stafff/available` - 获取可用陪玩

#### 报表统计

- `GET /reports/today-overview` - 今日概览
- `GET /reports/trends` - 趋势图表
- `GET /reports/member-ranking` - 会员排行榜
- `GET /reports/worker-ranking` - 陪玩排行榜

### 响应格式

成功响应：

```json
{
  "code": 200,
  "message": "操作成功",
  "data": {}
}
```

错误响应：

```json
{
  "code": 400,
  "message": "错误信息",
  "data": null,
  "errors": []
}
```

## 数据库设计

### 主要数据表

- `users` - 系统用户（管理员/操作员）
- `user` - 会员信息
- `stafff` - 陪玩信息
- `tasks` - 订单记录
- `recharges` - 充值记录

### 关系说明

- 会员 1:N 订单
- 会员 1:N 充值记录
- 陪玩 1:N 订单
- 订单包含支付信息和服务时长

## 开发指南

### 添加新的API接口

1. 在 `src/routes/` 目录下创建或修改路由文件
2. 在 `src/models/` 目录下定义数据模型（如需要）
3. 在 `src/routes/index.ts` 中注册新路由
4. 添加必要的参数验证和错误处理

### 数据库迁移

项目使用 Sequelize 自动同步数据库结构。在开发环境中，模型变更会自动应用到数据库。

生产环境建议使用 Sequelize CLI 进行数据库迁移管理。

### 企业微信通知

在 `src/services/wechat.ts` 中配置企业微信机器人，可以发送：

- 充值成功通知
- 订单完成通知
- 系统异常通知
- 每日统计报告

## 部署说明

### 生产环境部署

1. 设置环境变量 `NODE_ENV=production`
2. 配置生产数据库连接
3. 使用 PM2 或 Docker 部署
4. 配置 Nginx 反向代理
5. 启用 HTTPS

### Docker 部署（推荐）

```dockerfile
FROM node:16-alpine

WORKDIR /app

COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

EXPOSE 3000

CMD ["npm", "start"]
```

### PM2 部署

```bash
npm install -g pm2
npm run build
pm2 start dist/app.js --name payboard-backend
```

## 安全注意事项

- 定期更新依赖包
- 使用强密码和复杂的 JWT 密钥
- 启用 HTTPS
- 配置防火墙和访问控制
- 定期备份数据库
- 监控系统日志和异常

## 故障排除

### 常见问题

1. **数据库连接失败**
   - 检查数据库服务是否启动
   - 验证连接参数是否正确
   - 确认数据库用户权限

2. **JWT 认证失败**
   - 检查 JWT_SECRET 配置
   - 验证 token 是否过期
   - 确认请求头格式正确

3. **企业微信通知失败**
   - 检查 WECHAT_WEBHOOK_URL 配置
   - 验证网络连接
   - 查看企业微信机器人设置

### 日志查看

开发环境日志会输出到控制台。生产环境建议配置日志文件：

```bash
# 查看 PM2 日志
pm2 logs payboard-backend

# 查看错误日志
pm2 logs payboard-backend --err
```

## 贡献指南

1. Fork 项目
2. 创建功能分支
3. 提交代码变更
4. 推送到分支
5. 创建 Pull Request

## 许可证

MIT License

## 联系方式

如有问题或建议，请提交 Issue 或联系开发团队。