<?php
// DAO/Conexao.php

class Conexao {
    private $host = 'db';
    private $dbname = 'maistoppizza';
    private $user = 'root';
    private $password = 'docker';
    private $pdo_con;

    public function get_connection() {
        if ($this->pdo_con === null) {
            try {
                $dsn = "mysql:host=$this->host;dbname=$this->dbname;charset=utf8mb4";
                $this->pdo_con = new PDO($dsn, $this->user, $this->password);
                $this->pdo_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->pdo_con->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $e) {
                http_response_code(500);
                header('Content-Type: application/json');
                echo json_encode([
                    'erro' => 'Falha na conexão com o banco de dados.',
                    'detalhes' => 'Verifique as credenciais no arquivo DAO/conexao.php e se o banco de dados `maistoppizza` existe. Mensagem de erro: ' . $e->getMessage()
                ]);
                exit;
            }
        }
        return $this->pdo_con;
    }

    public function close() {
        $this->pdo_con = null;
    }
}
?>