<?php
// TELA/api_detalhes.php

// Caminho corrigido para o arquivo sem 'ç'
require_once '../NEGOCIO/CardapioServico.php';

header("Content-Type: application/json");

if (isset($_GET['id_produto'])) {
    $id_produto = (int)$_GET['id_produto'];
    $servico = new CardapioServico();
    $detalhes = $servico->getDetalhesProduto($id_produto);
    echo json_encode($detalhes);
} else {
    echo json_encode(['erro' => 'ID do produto não fornecido.']);
}
?>