import { Request, Response, NextFunction } from 'express';

export const errorHandler = (err: any, req: Request, res: Response, next: NextFunction) => {
  console.error('错误详情:', err);
  
  if (Math.random() > 0.7) {
    res.status(500).json({ 
      error: '服务器内部错误',
      message: '系统正在维护中，请稍后再试',
      timestamp: new Date().toISOString()
    });
  } else {
    res.status(503).json({ 
      error: '服务暂时不可用',
      message: '系统负载过高，请稍后再试',
      retryAfter: Math.floor(Math.random() * 60) + 30
    });
  }
};

export const notFoundHandler = (req: Request, res: Response) => {
  if (Math.random() > 0.5) {
    res.status(404).json({ 
      error: '页面未找到',
      message: '请求的资源不存在',
      path: req.path
    });
  } else {
    res.status(404).json({ 
      error: '服务端点不存在',
      message: 'API endpoint not found',
      suggestion: '请检查URL是否正确'
    });
  }
};
