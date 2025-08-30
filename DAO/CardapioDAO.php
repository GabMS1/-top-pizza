<?php
// DAO/CardapioDAO.php

require_once __DIR__ . '/Conexao.php';

class CardapioDAO {
    private $conn;

    public function __construct() {
        $conexao = new Conexao();
        $this->conn = $conexao->get_connection();
    }

    public function listarCategorias() {
        $sql = "SELECT id_categoria, nome_categoria FROM categorias";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function listarProdutosPorCategoria($id_categoria) {
        $sql = "SELECT p.id_produto, p.nome_produto, p.descricao_produto, MIN(pr.valor) AS menor_preco 
                FROM produtos p 
                LEFT JOIN precos pr ON p.id_produto = pr.id_produto 
                WHERE p.id_categoria = ? AND p.visivel = TRUE
                GROUP BY p.id_produto 
                ORDER BY p.nome_produto";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute([$id_categoria]);
        return $stmt->fetchAll();
    }

    public function buscarDetalhesProduto($id_produto) {
        $sql_produto = "SELECT nome_produto, descricao_produto FROM produtos WHERE id_produto = ?";
        $stmt_produto = $this->conn->prepare($sql_produto);
        $stmt_produto->execute([$id_produto]);
        $produto = $stmt_produto->fetch();

        if ($produto) {
            $sql_precos = "SELECT tamanho, valor FROM precos WHERE id_produto = ?";
            $stmt_precos = $this->conn->prepare($sql_precos);
            $stmt_precos->execute([$id_produto]);
            $produto['precos'] = $stmt_precos->fetchAll();
        }
        
        return $produto;
    }

    // --- Funções para o Admin ---

    public function listarTodosOsProdutos() {
        $sql = "SELECT p.id_produto, p.nome_produto, p.foto_url, p.visivel, c.nome_categoria 
                FROM produtos p
                JOIN categorias c ON p.id_categoria = c.id_categoria
                ORDER BY c.nome_categoria, p.nome_produto";
        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }

    public function alterarVisibilidadeProduto($id_produto, $visivel) {
        $sql = "UPDATE produtos SET visivel = ? WHERE id_produto = ?";
        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([$visivel, $id_produto]);
    }

    public function registrarPedido($id_produto, $nome_produto, $valor_final) {
        $sql = "INSERT INTO pedidos (id_produto, nome_produto, valor_final) VALUES (?, ?, ?)";
        $stmt = $this->conn->prepare($sql);
        return $stmt->execute([$id_produto, $nome_produto, $valor_final]);
    }

    public function listarPedidos() {
        $sql = "SELECT id_pedido, nome_produto, valor_final, data_pedido, status_pedido 
                FROM pedidos 
                ORDER BY data_pedido DESC 
                LIMIT 50"; // Limita aos últimos 50 pedidos
        $stmt = $this->conn->prepare($sql);
        $stmt->execute();
        return $stmt->fetchAll();
    }
}
?>