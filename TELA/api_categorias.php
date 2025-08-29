<?php
// TELA/api_categorias.php

require_once '../NEGOCIO/CardapioServico.php';

header("Content-Type: application/json");

$servico = new CardapioServico();
$categorias = $servico->getCategorias();

echo json_encode(value: $categorias);
?>