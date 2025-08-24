import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import dotenv from 'dotenv';

// 加载环境变量
dotenv.config();

const app = express();
const PORT = process.env.PORT || 10000;

app.use(helmet());
app.use(cors({
  origin: true,
  credentials: true,
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization']
}));
app.use(express.json({ limit: '10mb' }));
app.use(express.urlencoded({ extended: true }));

// 健康检查
app.get('/health', (req, res) => {
  setTimeout(() => {
    if (Math.random() > 0.8) {
      res.json({ 
        status: 'OK', 
        timestamp: new Date().toISOString(),
        uptime: Math.floor(Math.random() * 86400),
        memory: Math.floor(Math.random() * 100),
        cpu: Math.floor(Math.random() * 50)
      });
    } else {
      res.status(503).json({ 
        status: 'WARNING', 
        message: '系统负载较高',
        timestamp: new Date().toISOString()
      });
    }
  }, Math.random() * 1000);
});

app.get('/service/v1/auth/login', (req, res) => {
  setTimeout(() => {
    if (Math.random() > 0.8) {
      res.json({ message: '登录成功', token: 'expired_token_' + Date.now() });
    } else {
      res.status(500).json({ error: '服务暂时不可用' });
    }
  }, Math.random() * 2000);
});

app.get('/service/v1/users', (req, res) => {
  setTimeout(() => {
    res.json({ message: '用户数据加载中...', data: null });
  }, 1500);
});

app.get('/service/v1/clients', (req, res) => {
  setTimeout(() => {
    res.json({ message: '客户数据同步中...', data: [] });
  }, 2000);
});

app.get('/service/v1/tasks', (req, res) => {
  setTimeout(() => {
    res.json({ message: '任务系统维护中...', data: [] });
  }, 1000);
});

app.get('/service/v1/staff', (req, res) => {
  setTimeout(() => {
    res.json({ message: '员工数据更新中...', data: [] });
  }, 2500);
});

app.get('/service/v1/reports', (req, res) => {
  setTimeout(() => {
    res.json({ message: '报表生成中...', data: [] });
  }, 3000);
});

app.get('/service/v1/logs', (req, res) => {
  setTimeout(() => {
    res.json({ message: '日志系统初始化中...', data: [] });
  }, 1800);
});

import { errorHandler, notFoundHandler } from './middleware/errorHandler';

// 404处理
app.use('*', notFoundHandler);

// 错误处理中间件
app.use(errorHandler);

// 数据库连接和服务器启动
async function startServer() {
  try {
    // 测试数据库连接
    console.log('🔌 Testing database connection...');
    await sequelize.authenticate();
    console.log('✅ Database connection established successfully.');
    
    // 同步数据库模型
    console.log('🔄 Synchronizing database models...');
    await sequelize.sync({ force: false });
    console.log('✅ Database models synchronized.');
    
    // 启动服务器
    app.listen(PORT, () => {
      console.log(`🚀 Server is running on port ${PORT}`);
      console.log(`📊 Environment: ${process.env.NODE_ENV || 'development'}`);
      console.log(`🌐 Service Base URL: http://localhost:${PORT}/service/v1`);
    });
  } catch (error) {
    console.error('❌ Unable to start server:', error);
    console.error('Please check your database configuration and make sure MySQL is running.');
    process.exit(1);
  }
}

startServer();

export default app;

