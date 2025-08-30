<?php
// TELA/api_categorias.php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

// Caminho corrigido para o arquivo sem 'ç'
require_once dirname(__DIR__) . '/NEGOCIO/CardapioServico.php';

header("Content-Type: application/json");

$servico = new CardapioServico();
$categorias = $servico->getCategorias();

echo json_encode($categorias);
?>