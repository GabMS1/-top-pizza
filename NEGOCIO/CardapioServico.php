<?php
// NEGOCIO/CardapioServiço.php

require_once '../DAO/CardapioDAO.php';

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
}
?>