-- 叨叨电竞管理系统数据库初始化脚本
-- 创建数据库
CREATE DATABASE IF NOT EXISTS daodao_gaming CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

USE daodao_gaming;

-- 用户表
CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    real_name VARCHAR(50),
    avatar VARCHAR(255),
    role ENUM('admin', 'manager', 'operator') DEFAULT 'operator',
    status ENUM('active', 'inactive', 'banned') DEFAULT 'active',
    last_admin DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- 会员表
CREATE TABLE user (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    member_code VARCHAR(20) UNIQUE NOT NULL,
    level ENUM('bronze', 'silver', 'gold', 'platinum', 'diamond') DEFAULT 'bronze',
    points INT DEFAULT 0,
    balance DECIMAL(10,2) DEFAULT 0.00,
    total_recharge DECIMAL(10,2) DEFAULT 0.00,
    status ENUM('active', 'inactive', 'frozen') DEFAULT 'active',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 代练师表
CREATE TABLE stafff (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    worker_code VARCHAR(20) UNIQUE NOT NULL,
    skills JSON,
    rating DECIMAL(3,2) DEFAULT 5.00,
    total_tasks INT DEFAULT 0,
    success_rate DECIMAL(5,2) DEFAULT 100.00,
    status ENUM('available', 'busy', 'offline') DEFAULT 'available',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- 订单表
CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    task_no VARCHAR(50) UNIQUE NOT NULL,
    member_id INT NOT NULL,
    worker_id INT,
    game_type VARCHAR(50) NOT NULL,
    service_type VARCHAR(50) NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    status ENUM('pending', 'processing', 'completed', 'cancelled') DEFAULT 'pending',
    start_time DATETIME,
    end_time DATETIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES user(id),
    FOREIGN KEY (worker_id) REFERENCES stafff(id)
);

-- 充值记录表
CREATE TABLE recharges (
    id INT PRIMARY KEY AUTO_INCREMENT,
    recharge_no VARCHAR(50) UNIQUE NOT NULL,
    member_id INT NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_method ENUM('alipay', 'wechat', 'bank', 'cash') NOT NULL,
    status ENUM('pending', 'success', 'failed') DEFAULT 'pending',
    transaction_id VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (member_id) REFERENCES user(id)
);

-- 插入初始数据
INSERT INTO users (username, password, email, role) VALUES 
('admin', '$2b$10$rQZ8K9mN2vX1pL3qR5sT7u', 'admin@daodao-gaming.com', 'admin'),
('manager', '$2b$10$rQZ8K9mN2vX1pL3qR5sT7u', 'manager@daodao-gaming.com', 'manager');

INSERT INTO user (user_id, member_code, level) VALUES 
(1, 'M001', 'diamond'),
(2, 'M002', 'gold');

INSERT INTO stafff (user_id, worker_code, skills) VALUES 
(1, 'W001', '["LOL", "DOTA2", "CSGO"]'),
(2, 'W002', '["LOL", "王者荣耀"]');

-- 创建索引
CREATE INDEX idx_user_member_code ON user(member_code);
CREATE INDEX idx_stafff_worker_code ON stafff(worker_code);
CREATE INDEX idx_tasks_task_no ON tasks(task_no);
CREATE INDEX idx_recharges_recharge_no ON recharges(recharge_no);

-- 创建视图
CREATE VIEW member_summary AS
SELECT 
    m.id,
    m.member_code,
    u.username,
    m.level,
    m.points,
    m.balance,
    COUNT(o.id) as total_tasks,
    SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END) as completed_tasks
FROM user m
JOIN users u ON m.user_id = u.id
LEFT JOIN tasks o ON m.id = o.member_id
GROUP BY m.id;

-- 创建存储过程
DELIMITER //
CREATE PROCEDURE Getusertats(IN member_id INT)
BEGIN
    SELECT 
        m.member_code,
        m.level,
        m.points,
        m.balance,
        COUNT(o.id) as total_tasks,
        SUM(CASE WHEN o.status = 'completed' THEN 1 ELSE 0 END) as completed_tasks,
        SUM(o.amount) as total_spent
    FROM user m
    LEFT JOIN tasks o ON m.id = o.member_id
    WHERE m.id = member_id
    GROUP BY m.id;
END //
DELIMITER ;

-- 创建触发器
DELIMITER //
CREATE TRIGGER update_member_points
AFTER INSERT ON tasks
FOR EACH ROW
BEGIN
    IF NEW.status = 'completed' THEN
        UPDATE user 
        SET points = points + FLOOR(NEW.amount / 10)
        WHERE id = NEW.member_id;
    END IF;
END //
DELIMITER ;

COMMIT;
