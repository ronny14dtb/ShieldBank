-- Tabla para almacenar los usuarios del sistema (Admin, Analyst)
CREATE TABLE Users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username VARCHAR(50) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    email VARCHAR(100) NOT NULL,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    role VARCHAR(20) NOT NULL CHECK (role IN ('Admin', 'Analyst'))
);

-- Tabla para almacenar la información de los clientes bancarios
CREATE TABLE Clients (
    client_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    country VARCHAR(50),
    registration_date DATE
);

-- Tabla para definir las reglas de detección de fraude
CREATE TABLE Rules (
    rule_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(100) NOT NULL,
    threshold REAL
);

-- Tabla para almacenar los detalles de cada transacción
CREATE TABLE Transactions (
    transaction_id INTEGER PRIMARY KEY AUTOINCREMENT,
    client_id INTEGER NOT NULL,
    amount REAL NOT NULL,
    date DATE NOT NULL,
    time TIME NOT NULL,
    location VARCHAR(50),
    FOREIGN KEY (client_id) REFERENCES Clients(client_id)
);

-- Tabla para registrar las alertas generadas por el sistema
CREATE TABLE Alerts (
    alert_id INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_id INTEGER NOT NULL,
    rule_id INTEGER,
    reason VARCHAR(255) NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (status IN ('Pending', 'Reviewed', 'Confirmed Fraud', 'False Positive')),
    date_created DATETIME NOT NULL,
    FOREIGN KEY (transaction_id) REFERENCES Transactions(transaction_id),
    FOREIGN KEY (rule_id) REFERENCES Rules(rule_id)
);