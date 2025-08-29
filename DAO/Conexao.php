<?php
// DAO/Conexao.php

class Conexao {
    private $host = 'localhost';
    private $dbname = 'seu_banco_de_dados';
    private $user = 'root';
    private $password = '';
    private $pdo_con;

    public function get_connection() {
        if ($this->pdo_con === null) {
            try {
                $dsn = "mysql:host=$this->host;dbname=$this->dbname;charset=utf8mb4";
                $this->pdo_con = new PDO($dsn, $this->user, $this->password);
                $this->pdo_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->pdo_con->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $e) {
                error_log("Falha ao conectar ao banco de dados: " . $e->getMessage());
                return false;
            }
        }
        return $this->pdo_con;
    }

    public function close() {
        $this->pdo_con = null;
    }
}
?>