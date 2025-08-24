# API关键词替换指南

## 替换映射表

| 原关键词 | 替换为 | 说明 |
|---------|--------|------|
| `api` / `API` / `Api` | `service` | 将API替换为service |
| `endpoint` | `gateway` | 将endpoint替换为gateway |
| `接口` | `服务` | 将中文接口替换为服务 |
| `request` | `call` | 将request替换为call |
| `axios` | `http` | 将axios替换为http |
| `/api/v1/` | `/service/v1/` | 将API路径替换为service路径 |
| `VITE_API_BASE_URL` | `VITE_SERVICE_BASE_URL` | 环境变量名替换 |
| `API Base URL` | `Service Base URL` | 文档中的描述替换 |
| `接口文档` | `服务说明` | 中文文档替换 |
| `API Documentation` | `Service Documentation` | 英文文档替换 |
| `auth/admin` | `user/signin` | 具体接口路径替换 |
| `user` | `clients` | 业务模块名替换 |
| `stafff` | `staff` | 业务模块名替换 |
| `tasks` | `tasks` | 业务模块名替换 |
| `json` | `result` | 响应相关词汇替换 |
| `json` | `data` | 数据格式相关替换 |

## 批量替换命令

### 1. 替换API为service
```bash
# Windows PowerShell
Get-ChildItem -Recurse -Include "*.ts","*.js","*.vue","*.json","*.md" | ForEach-Object {
    (Get-Content $_.FullName) -replace 'api', 'service' -replace 'API', 'Service' -replace 'Api', 'Service' | Set-Content $_.FullName
}

# Linux/Mac
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" -o -name "*.json" -o -name "*.md" \) -exec sed -i 's/api/service/g; s/API/Service/g; s/Api/Service/g' {} \;
```

### 2. 替换endpoint为gateway
```bash
# Windows PowerShell
Get-ChildItem -Recurse -Include "*.ts","*.js","*.vue","*.json","*.md" | ForEach-Object {
    (Get-Content $_.FullName) -replace 'endpoint', 'gateway' | Set-Content $_.FullName
}

# Linux/Mac
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" -o -name "*.json" -o -name "*.md" \) -exec sed -i 's/endpoint/gateway/g' {} \;
```

### 3. 替换axios为http
```bash
# Windows PowerShell
Get-ChildItem -Recurse -Include "*.ts","*.js","*.vue","*.json","*.md" | ForEach-Object {
    (Get-Content $_.FullName) -replace 'axios', 'http' | Set-Content $_.FullName
}

# Linux/Mac
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" -o -name "*.json" -o -name "*.md" \) -exec sed -i 's/axios/http/g' {} \;
```

### 4. 替换路径前缀
```bash
# Windows PowerShell
Get-ChildItem -Recurse -Include "*.ts","*.js","*.vue","*.json","*.md" | ForEach-Object {
    (Get-Content $_.FullName) -replace '/api/v1/', '/service/v1/' | Set-Content $_.FullName
}

# Linux/Mac
find . -type f \( -name "*.ts" -o -name "*.js" -o -name "*.vue" -o -name "*.json" -o -name "*.md" \) -exec sed -i 's|/api/v1/|/service/v1/|g' {} \;
```

## 注意事项

1. **备份文件**：替换前请备份整个项目
2. **测试验证**：替换后需要测试项目是否能正常编译
3. **逐步替换**：建议分批替换，避免一次性替换过多导致问题
4. **检查依赖**：某些关键词可能是第三方库的固定用法，需要保留

## 替换后的效果

替换完成后，您的项目将：
- 看起来更像一个普通的服务模块
- 隐藏了API相关的技术特征
- 保持了代码的功能性
- 增加了代码的迷惑性
