<?php
    if (isset($_POST['US_login']) and isset($_POST['US_password'])) {
        session_start();
        include 'connect.php';

        $hashedPassword = hash('sha256', $_POST['US_password']);
        
        // Utiliser la bonne casse pour les colonnes selon le type de base de données
        $login_column = $db_type == "pgsql" ? "us_login" : "US_login";
        $password_column = $db_type == "pgsql" ? "us_password" : "US_password";
        
        $sql = "SELECT * FROM utilisateurs WHERE $login_column = ? AND $password_column = ?";
        
        try {
            $stmt = $db->prepare($sql);
            $stmt->bindParam(1, $_POST['US_login']);
            $stmt->bindParam(2, $hashedPassword);
            $stmt->execute();
            $res = $stmt->fetchAll(PDO::FETCH_ASSOC);
            
            if ($res != false) {
                if (count($res) > 0) {
                    // Utilisateur trouvé dans la base
                    $utilisateur = $res[0];
                    $_SESSION['login'] = $utilisateur[$login_column];
                    header("Location: home.php");
                } else {
                    header("Location: index.php");
                }
            } else {
                header("Location: BADUSER.html");
            }
        } catch (PDOException $e) {
            header("Location: index.php");
        }
    } else {
        header("Location: index.php");
    }
?>