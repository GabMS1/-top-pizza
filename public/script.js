document.addEventListener('DOMContentLoaded', () => {
    const appContainer = document.getElementById('app-container');

    function fetchCategorias() {
        // Caminho corrigido para acessar a pasta TELA a partir da pasta public
        fetch('../TELA/api_categorias.php')
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro na rede ou no servidor: ' + response.statusText);
                }
                return response.json();
            })
            .then(data => renderCategorias(data))
            .catch(error => {
                console.error('Erro ao buscar categorias:', error);
                appContainer.innerHTML = `<p class="error-message">Não foi possível carregar o cardápio. Verifique a conexão com o banco de dados e o caminho da API.</p>`;
            });
    }

    function renderCategorias(categorias) {
        appContainer.innerHTML = '<h2>Categorias</h2><div class="card-list"></div>';
        const cardList = appContainer.querySelector('.card-list');

        categorias.forEach(categoria => {
            const card = document.createElement('div');
            card.className = 'card';
            card.innerHTML = `<h2>${categoria.nome_categoria}</h2>`;
            card.addEventListener('click', () => fetchProdutos(categoria.id_categoria, categoria.nome_categoria));
            cardList.appendChild(card);
        });
    }

    function fetchProdutos(idCategoria, nomeCategoria) {
        // Caminho corrigido
        fetch(`../TELA/api_produtos.php?id_categoria=${idCategoria}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro na rede ou no servidor: ' + response.statusText);
                }
                return response.json();
            })
            .then(data => renderProdutos(data, nomeCategoria))
            .catch(error => {
                console.error('Erro ao buscar produtos:', error);
                appContainer.innerHTML = `<button class="back-button">Voltar</button><p class="error-message">Não foi possível carregar os produtos.</p>`;
                appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);
            });
    }

    function renderProdutos(produtos, nomeCategoria) {
        appContainer.innerHTML = `<button class="back-button">Voltar</button><h2>${nomeCategoria}</h2><div class="card-list"></div>`;
        const cardList = appContainer.querySelector('.card-list');
        appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);

        produtos.forEach(produto => {
            const card = document.createElement('div');
            card.className = 'card';
            card.innerHTML = `<h2>${produto.nome_produto}</h2>`;
            card.addEventListener('click', () => fetchDetalhesProduto(produto.id_produto));
            cardList.appendChild(card);
        });
    }

    function fetchDetalhesProduto(idProduto) {
        // Caminho corrigido
        fetch(`../TELA/api_detalhes.php?id_produto=${idProduto}`)
            .then(response => {
                if (!response.ok) {
                    throw new Error('Erro na rede ou no servidor: ' + response.statusText);
                }
                return response.json();
            })
            .then(data => renderDetalhesProduto(data))
            .catch(error => {
                console.error('Erro ao buscar detalhes do produto:', error);
                appContainer.innerHTML = `<button class="back-button">Voltar</button><p class="error-message">Não foi possível carregar os detalhes do produto.</p>`;
                appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);
            });
    }

    function renderDetalhesProduto(produto) {
        if (!produto || produto.erro) {
            appContainer.innerHTML = `<button class="back-button">Voltar</button><p>Detalhes do produto não encontrados.</p>`;
            appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);
            return;
        }

        let precosHtml = '<ul>';
        if (produto.precos && produto.precos.length > 0) {
            produto.precos.forEach(preco => {
                precosHtml += `<li>${preco.tamanho ? preco.tamanho + ': ' : ''}R$${parseFloat(preco.valor).toFixed(2)}</li>`;
            });
        } else {
            precosHtml += '<li>Nenhum preço disponível.</li>';
        }
        precosHtml += '</ul>';

        appContainer.innerHTML = `
            <button class="back-button">Voltar</button>
            <div class="product-details">
                <h2>${produto.nome_produto}</h2>
                <p><strong>Descrição:</strong> ${produto.descricao_produto || 'N/A'}</p>
                <h3>Preços:</h3>
                ${precosHtml}
            </div>
        `;
        appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);
    }

    // Iniciar a aplicação
    fetchCategorias();
});