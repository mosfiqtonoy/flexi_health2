CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    full_name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    phone TEXT UNIQUE NOT NULL,
    password_hash TEXT NOT NULL,
    role TEXT NOT NULL DEFAULT 'user',
    balance REAL NOT NULL DEFAULT 0.0,
    is_active INTEGER NOT NULL DEFAULT 1,
    reset_token TEXT,
    reset_token_expiry INTEGER,
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now'))
);

CREATE TABLE IF NOT EXISTS health_records (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    weight REAL,
    height REAL,
    blood_pressure_systolic INTEGER,
    blood_pressure_diastolic INTEGER,
    blood_type TEXT,
    notes TEXT,
    recorded_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS recharge_history (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    saved_amount REAL NOT NULL,
    operator TEXT NOT NULL,
    status TEXT NOT NULL DEFAULT 'completed',
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

CREATE TABLE IF NOT EXISTS service_requests (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INTEGER NOT NULL,
    service_type TEXT NOT NULL,
    description TEXT,
    status TEXT NOT NULL DEFAULT 'pending',
    amount_used REAL DEFAULT 0.0,
    created_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    updated_at INTEGER NOT NULL DEFAULT (strftime('%s', 'now')),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT OR IGNORE INTO users (full_name, email, phone, password_hash, role)
VALUES (
    'Admin',
    'admin@flexihealth.com',
    '01700000000',
    'pbkdf2:sha256:260000$166bdc56766735cde62bfcafcb3c856a$4aa52339bfb87f691cdfa13b0d0d3f5fde9dd19527edc25281d23d8444fec306',
    'admin'
);
