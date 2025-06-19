
CREATE TYPE upload_type_enum AS ENUM ('user_profile', 'product_image', 'product_video');
CREATE TYPE order_status_enum AS ENUM ('confirm', 'pending', 'paid');
CREATE TYPE notification_type_enum AS ENUM ('email', 'sms');
CREATE TYPE user_role_enum AS ENUM ('user', 'admin');


CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    country_code VARCHAR(10),
    phone_number VARCHAR(20),
    email VARCHAR(100) UNIQUE,
    password TEXT,
    dob DATE,
    role user_role_enum DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    archived_at TIMESTAMP
);


CREATE TABLE address (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    address TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    archived_at TIMESTAMP
);


CREATE TABLE uploads (
    id SERIAL PRIMARY KEY,
    path TEXT NOT NULL,
    upload_type upload_type_enum,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    archived_at TIMESTAMP
);


CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    product_name VARCHAR(100),
    description text,
    price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    archived_at TIMESTAMP
);


CREATE TABLE product_uploads (
    product_id INT REFERENCES products(id),
    upload_id INT REFERENCES uploads(id),
    PRIMARY KEY (product_id, upload_id)
);


CREATE TABLE inventory (
    id SERIAL PRIMARY KEY,
    product_id INT REFERENCES products(id),
    quantity INT
);


CREATE TABLE cart (
     id SERIAL PRIMARY KEY,
     user_id INT REFERENCES users(id),
     created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
     updated_at TIMESTAMP,
     archived_at TIMESTAMP
);


CREATE TABLE cart_items (
     id SERIAL PRIMARY KEY,
     cart_id INT REFERENCES cart(id),
     product_id INT REFERENCES products(id),
     quantity INT,
     price DECIMAL(10, 2)
);


CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    address_id INT REFERENCES address(id),
    order_status order_status_enum,
    total_price DECIMAL(10, 2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP,
    archived_at TIMESTAMP
);


CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(id),
    product_id INT REFERENCES products(id),
    quantity INT,
    price DECIMAL(10, 2)
);


CREATE TABLE payment (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    order_id INT REFERENCES orders(id),
    amount DECIMAL(10, 2),
    method VARCHAR(50),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);


CREATE TABLE session (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    started_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expired_at TIMESTAMP,
    archived_at TIMESTAMP
);


CREATE TABLE notification_tracker (
    id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id),
    type notification_type_enum,
    message TEXT,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
