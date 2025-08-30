<?php
// admin/api_produtos_admin.php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);

require_once '../NEGOCIO/CardapioServico.php';

header("Content-Type: application/json");

$servico = new CardapioServico();
$produtos = $servico->getTodosOsProdutosParaAdmin();

echo json_encode($produtos);
?>