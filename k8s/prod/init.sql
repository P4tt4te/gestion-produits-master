-- Création de la table utilisateurs
CREATE TABLE IF NOT EXISTS utilisateurs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insertion de l'utilisateur admin (mot de passe: 'password')
-- Le mot de passe est hashé avec password_hash() en PHP, donc nous utilisons un hash pré-calculé
INSERT INTO utilisateurs (username, password) 
VALUES ('admin', '$2y$10$YourPreCalculatedHash') 
ON DUPLICATE KEY UPDATE username=username; 