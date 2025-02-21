--创建用户表
CREATE TABLE users (
    id SERIAL PRIMARY KEY,          -- 用户ID
    username VARCHAR(255) NOT NULL, -- 用户名
    password_hash VARCHAR(255) NOT NULL, -- 密码哈希
    email VARCHAR(255) UNIQUE,     -- 邮箱
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- 创建时间
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 更新时间
);
--创建角色表
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,          -- 角色ID
    name VARCHAR(255) NOT NULL,     -- 角色名称
    description TEXT                -- 角色描述
);
--创建用户角色关联表
CREATE TABLE user_roles (
    user_id INT REFERENCES users(id) ON DELETE CASCADE, -- 用户ID
    role_id INT REFERENCES roles(id) ON DELETE CASCADE, -- 角色ID
    PRIMARY KEY (user_id, role_id)
);
--创建权限表
CREATE TABLE permissions (
    id SERIAL PRIMARY KEY,          -- 权限ID
    name VARCHAR(255) NOT NULL,     -- 权限名称
    resource VARCHAR(255) NOT NULL, -- 资源（如接口路径）
    action VARCHAR(255) NOT NULL    -- 操作（如GET、POST）
);
--创建角色权限关联表
CREATE TABLE role_permissions (
    role_id INT REFERENCES roles(id) ON DELETE CASCADE, -- 角色ID
    permission_id INT REFERENCES permissions(id) ON DELETE CASCADE, -- 权限ID
    PRIMARY KEY (role_id, permission_id)
);
--创建黑名单表
CREATE TABLE blacklist (
    id SERIAL PRIMARY KEY,          -- 黑名单ID
    user_id INT REFERENCES users(id) ON DELETE CASCADE, -- 用户ID
    reason TEXT,                    -- 封禁原因
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- 封禁时间
);