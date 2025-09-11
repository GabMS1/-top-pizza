<?php
// DAO/Conexao.php

class Conexao {
    private $host = 'db'; // Alterado para o nome do serviço no Docker Compose
    private $dbname = 'maistoppizza';
    private $user = 'root';
    private $password = 'docker'; // Mesma senha definida no docker-compose.yml
    private $pdo_con;

    public function get_connection() {
        if ($this->pdo_con === null) {
            try {
                $dsn = "mysql:host=$this->host;dbname=$this->dbname;charset=utf8mb4";
                $this->pdo_con = new PDO($dsn, $this->user, $this->password);
                $this->pdo_con->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
                $this->pdo_con->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
            } catch (PDOException $e) {
                // Interrompe a execução e envia um erro claro em JSON
                http_response_code(500);
                header('Content-Type: application/json');
                echo json_encode([
                    'erro' => 'Falha na conexão com o banco de dados.',
                    'detalhes' => 'Verifique as credenciais no arquivo DAO/conexao.php e se o banco de dados `toppizza` existe.',
                    'mensagem_original' => $e->getMessage()
                ]);
                exit; // Interrompe o script
            }
        }
        return $this->pdo_con;
    }

    public function close() {
        $this->pdo_con = null;
    }
}
?>