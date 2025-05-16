<?php
    $host = "db-postgres";
    $username = "gestion_produits";
    $password = "gestion_produits";
    $db = "gestion_produits";

    try {
        // Connexion avec PDO PostgreSQL
        $db = new PDO("pgsql:host=$host;dbname=$db", $username, $password);
        $db->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        $db->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    } catch(PDOException $e) {
        die("Erreur de connexion à la base de données: " . $e->getMessage());
    }
?>