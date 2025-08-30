<?php
// NEGOCIO/CardapioServico.php

require_once dirname(__DIR__) . '/DAO/CardapioDAO.php';

class CardapioServico {
    private $cardapioDAO;

    public function __construct() {
        $this->cardapioDAO = new CardapioDAO();
    }

    public function getCategorias() {
        return $this->cardapioDAO->listarCategorias();
    }

    public function getProdutosPorCategoria($id_categoria) {
        return $this->cardapioDAO->listarProdutosPorCategoria($id_categoria);
    }

    public function getDetalhesProduto($id_produto) {
        return $this->cardapioDAO->buscarDetalhesProduto($id_produto);
    }

    public function getTodosOsProdutosParaAdmin() {
        return $this->cardapioDAO->listarTodosOsProdutos();
    }

    public function getPedidosParaAdmin() {
        return $this->cardapioDAO->listarPedidos();
    }
}
?>