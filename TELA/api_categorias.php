<?php
// TELA/api_categorias.php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once '../NEGOCIO/CardapioServiço.php';
// Caminho corrigido para o arquivo com 'ç'
require_once '../NEGOCIO/CardapioServiço.php';

header("Content-Type: application/json");

$servico = new CardapioServico();
$categorias = $servico->getCategorias();

echo json_encode(value: $categorias);
?>