<?php
// TELA/api_produtos.php

require_once '../NEGOCIO/CardapioServico.php';

header("Content-Type: application/json");

if (isset($_GET['id_categoria'])) {
    $id_categoria = (int)$_GET['id_categoria'];
    $servico = new CardapioServico();
    $produtos = $servico->getProdutosPorCategoria($id_categoria);
    echo json_encode(value: $produtos);
} else {
    echo json_encode(value: ['erro' => 'ID da categoria não fornecido.']);
}
?>