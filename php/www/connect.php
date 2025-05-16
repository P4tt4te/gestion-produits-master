<?php
// Déterminer quelle base de données utiliser en fonction de l'URL
$db_type = (strpos($_SERVER['HTTP_HOST'], 'dev.') === 0) ? 'postgres' : 'mysql';

if ($db_type === 'postgres') {
    // Configuration PostgreSQL
    $host = getenv('DB_POSTGRES_HOST') ?: 'db-postgres';
    $username = getenv('DB_POSTGRES_USER') ?: 'gestion_produits';
    $password = getenv('DB_POSTGRES_PASSWORD') ?: 'gestion_produits';
    $db_name = getenv('DB_POSTGRES_NAME') ?: 'gestion_produits';
    
    try {
        // Connexion PostgreSQL
        $db = new PDO("pgsql:host=$host;dbname=$db_name", $username, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    } catch(PDOException $e) {
        die("Erreur de connexion PostgreSQL: " . $e->getMessage());
    }
} else {
    // Configuration MySQL
    $host = getenv('DB_MYSQL_HOST') ?: 'db-mysql';
    $username = getenv('DB_MYSQL_USER') ?: 'root';
    $password = getenv('DB_MYSQL_PASSWORD') ?: 'root';
    $db_name = getenv('DB_MYSQL_NAME') ?: 'gestion_produits';
    
    try {
        // Connexion MySQL
        $db = new PDO("mysql:host=$host;dbname=$db_name", $username, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    } catch(PDOException $e) {
        die("Erreur de connexion MySQL: " . $e->getMessage());
    }
}
?>