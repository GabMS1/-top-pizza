<?php
// TELA/api_detalhes.php

require_once '../NEGOCIO/CardapioServico.php';

header("Content-Type: application/json");

if (isset($_GET['id_produto'])) {
    $id_produto = (int)$_GET['id_produto'];
    $servico = new CardapioServico();
    $detalhes = $servico->getDetalhesProduto($id_produto);
    echo json_encode(value: $detalhes);
} else {
    echo json_encode(value: ['erro' => 'ID do produto não fornecido.']);
}
?>