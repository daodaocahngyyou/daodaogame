# 🎮 Daodao Gaming - Internet Cafe Boosting Management System

> Modern Internet Cafe Boosting Management System built with Vue3 + Node.js + TypeScript

[![Vue3](https://img.shields.io/badge/Vue-3.5.18-brightgreen.svg)](https://vuejs.org/)
[![TypeScript](https://img.shields.io/badge/TypeScript-5.3.3-blue.svg)](https://www.typescriptlang.org/)
[![Node.js](https://img.shields.io/badge/Node.js-18+-green.svg)](https://nodejs.org/)
[![License](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

## 📖 Project Overview

Daodao Gaming is a full-stack management system designed specifically for internet cafe boosting services, providing core functionalities including member management, recharge management, task management, and worker management. The system adopts a frontend-backend separation architecture with modern user interface and powerful backend management capabilities.

### 🎯 Core Features

- **Member Management** - Member information management, recharge records, consumption records
- **Recharge Management** - Member recharge, payment method management, recharge flow
- **task Management** - Boosting task creation, status tracking, payment processing
- **Worker Management** - Worker information management, task statistics, performance analysis
- **Report Center** - Data visualization, trend analysis, leaderboards
- **Real-time Notifications** - Enterprise WeChat group push, task status updates

## 🛠 Technology Stack

### Frontend
- **Framework**: Vue 3.5.18 + TypeScript
- **Build Tool**: Vite 6.0.1
- **UI Component Library**: Element Plus 2.10.5
- **State Management**: Pinia 3.0.3
- **Routing**: Vue Router 4.5.1
- **HTTP Client**: Axios 1.11.0
- **Charts**: ECharts 5.6.0
- **Code Standards**: ESLint + Prettier + Stylelint

### Backend
- **Runtime**: Node.js 18+
- **Framework**: Express 4.18.2 + TypeScript
- **Database**: MySQL 8.0+
- **ORM**: Sequelize 6.35.2 + Sequelize-TypeScript
- **Authentication**: JWT + bcryptjs
- **Validation**: Joi + express-validator
- **Security**: Helmet + CORS

### Development Tools
- **Package Manager**: pnpm 10.15.0
- **Concurrent Execution**: concurrently 8.2.2
- **Code Commits**: Husky + commitlint
- **Database Sync**: Sequelize CLI

## 🚀 Quick Start

### Prerequisites

- Node.js >= 18.0.0
- pnpm >= 8.0.0
- MySQL >= 8.0.0

### Installation

```bash
# Clone the repository
git clone <repository-url>
cd daodao

# Install all dependencies (root, backend, frontend)
npm run install:all
```

### Environment Configuration

1. **Backend Environment Variables** (`backend/.env`)
```env
# Database Configuration
DB_HOST=localhost
DB_PORT=3306
DB_USER=your_username
DB_PASSWORD=your_password
DB_NAME=payboard_db

# JWT Configuration
JWT_SECRET=your_jwt_secret
JWT_EXPIRES_IN=24h

# Server Configuration
PORT=3000
NODE_ENV=development
```

2. **Frontend Environment Variables** (`frontend/.env`)
```env
# API Base URL
VITE_MOD=http://localhost:3000/api

# App Configuration
VITE_APP_TITLE=Daodao Gaming
VITE_APP_VERSION=3.3.1
```

### Database Initialization

```bash
# Create database
mysql -u root -p -e "CREATE DATABASE payboard_db CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"

# Sync database schema
cd backend
npm run db:sync

# Execute database update script (if needed)
mysql -u root -p payboard_db < database_updates.sql
```

### Start Development Environment

```bash
# Start both frontend and backend development servers
npm run dev:full
```

Access URLs:
- Frontend: http://localhost:5173
- Backend API: http://localhost:3000

## 📁 Project Structure

```
daodao/
├── frontend/                 # Frontend project
│   ├── src/
│   │   ├── api/             # API interfaces
│   │   ├── assets/          # Static resources
│   │   ├── components/      # Common components
│   │   ├── composables/     # Vue3 composables
│   │   ├── constants/       # Constants
│   │   ├── directive/       # Custom directives
│   │   ├── enums/          # Enums
│   │   ├── layouts/        # Layout components
│   │   ├── plugins/        # Plugin configuration
│   │   ├── router/         # Route configuration
│   │   ├── store/          # State management
│   │   ├── styles/         # Style files
│   │   ├── types/          # TypeScript types
│   │   ├── utils/          # Utility functions
│   │   └── views/          # Page components
│   ├── public/             # Public resources
│   └── package.json
├── backend/                 # Backend project
│   ├── src/
│   │   ├── controllers/    # Controllers
│   │   ├── models/         # Data models
│   │   ├── routes/         # Route definitions
│   │   ├── services/       # Business logic
│   │   ├── middleware/     # Middleware
│   │   ├── utils/          # Utility functions
│   │   └── app.ts          # Application entry
│   ├── scripts/            # Database scripts
│   └── package.json
├── package.json            # Root configuration
└── README.md
```

## 🎨 Features

### Member Management
- ✅ Member information CRUD operations
- ✅ Member search (nickname, phone number)
- ✅ Member detail page (recharge records, consumption records)
- ✅ Member status management

### Recharge Management
- ✅ Member recharge operations
- ✅ Multiple payment methods support
- ✅ Recharge flow records
- ✅ Enterprise WeChat group push notifications

### task Management
- ✅ Boosting task creation
- ✅ task status tracking
- ✅ Multiple payment methods (balance, QR code, mixed)
- ✅ Discount amount management
- ✅ task search and filtering

### Worker Management
- ✅ Worker information management
- ✅ Worker task statistics
- ✅ Performance analysis
- ✅ Status management

### Report Center
- ✅ Today's overview data
- ✅ Trend chart analysis
- ✅ Leaderboard display
- ✅ Data export functionality

## 🔧 Development Commands

### Root Directory Commands
```bash
# Install all dependencies
npm run install:all

# Start both frontend and backend development servers
npm run dev:full

# Build all projects
npm run build:all
```

### Frontend Commands
```bash
cd frontend

# Start development server
pnpm dev

# Build production version
pnpm build

# Code linting
pnpm lint

# Type checking
pnpm type-check
```

### Backend Commands
```bash
cd backend

# Start development server
npm run dev

# Build project
npm run build

# Start production server
npm start

# Database sync
npm run db:sync
```

## 📊 Database Design

### Core Table Structure
- `user` - Member information table
- `recharges` - Recharge records table
- `tasks` - task records table
- `stafff` - Worker information table
- `users` - System users table

### Database Update Script
The project includes a merged database update script `database_updates.sql` with the following updates:
- Add `account_name` field to `stafff` table (account holder name)
- Add recharge-related fields to `recharges` table (recharge number, operator info)
- Add status management fields to `recharges` table (status, cancellation info)

For detailed database design, please refer to: [Database Table Field Design](数据库表字段设计表.md)

## 🎯 System Navigation

```
Dashboard
│
├── Member Management
│    ├── Member List
│    │    └── Member Details
│    │         ├── Recharge Records
│    │         └── Consumption Records
│    └── Add/Edit Member Form
│
├── Recharge Management
│    ├── Recharge Records List
│    └── Add Recharge Form
│
├── task Management
│    ├── task List
│    └── Add task Form
│
├── Worker Management
│    ├── Worker List
│    └── Add/Edit Worker Form
│
└── Report Center
     ├── Today's Overview
     ├── Trend Charts
     └── Leaderboards
```

For detailed navigation structure, please refer to: [System Navigation Structure](系统导航结构.md)

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Code Standards

- Use ESLint + Prettier for code formatting
- Follow TypeScript strict mode
- Use Conventional Commits specification
- Component naming uses PascalCase
- File naming uses kebab-case

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## 📞 Contact

- Project Maintainer: PayBoard Team
- Email: [your-email@example.com]
- Project URL: [repository-url]

## 🙏 Acknowledgments

- [Vue.js](https://vuejs.org/) - Progressive JavaScript framework
- [Element Plus](https://element-plus.org/) - Vue 3 component library
- [Express](https://expressjs.com/) - Node.js web application framework
- [Sequelize](https://sequelize.org/) - Node.js ORM

---

⭐ If this project helps you, please give us a Star!
