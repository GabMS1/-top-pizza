<?php
// DAO/CardapioDAO.php

require_once 'Conexao.php';

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
        $sql = "SELECT id_produto, nome_produto, descricao_produto FROM produtos WHERE id_categoria = ?";
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
}
?>