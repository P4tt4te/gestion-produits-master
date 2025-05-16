<?php
    $host = getenv('DB_HOST') ?: "db";
    $username = getenv('DB_USERNAME') ?: "root";
    $password = getenv('DB_PASSWORD') ?: "root";
    $db = getenv('DB_NAME') ?: "gestion_produits";
    // pgsql or mysql
    $db_type = getenv('DB_TYPE') ?: "mysql";

    // Connexion avec pdo mysql
    $db = new PDO("$db_type:host=$host;dbname=$db", $username, $password);
    $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    
?>