document.addEventListener('DOMContentLoaded', () => {
    const appContainer = document.getElementById('app-container');

    function fetchCategorias() {
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
            card.className = 'card product-card'; // Adiciona a classe 'product-card'
            
            const buttonText = nomeCategoria.toLowerCase().includes('bebidas') ? 'Pedir esta bebida' : 'Pedir este sabor';

            card.innerHTML = `
                <h3>${produto.nome_produto}</h3>
                <p class="card-description">${produto.descricao_produto || 'Sem descrição'}</p>
                <p class="card-price">A partir de R$${parseFloat(produto.menor_preco).toFixed(2)}</p>
                <button class="confirm-button">${buttonText}</button>
            `;
            // Ação de clique apenas no botão
            card.querySelector('.confirm-button').addEventListener('click', (e) => {
                e.stopPropagation();
                mostrarConfirmacao(produto);
            });
            cardList.appendChild(card);
        });
    }

    function mostrarConfirmacao(produto) {
        // Remove qualquer overlay/modal anterior
        const oldOverlay = document.querySelector('.modal-overlay');
        if (oldOverlay) oldOverlay.remove();

        // Cria overlay/modal com classe para estilização
        const overlay = document.createElement('div');
        overlay.className = 'modal-overlay';

        const modal = document.createElement('div');
        modal.className = 'card';
        modal.style.maxWidth = '400px';
        modal.style.cursor = 'default'; // Garante que o modal não pareça clicável
        modal.style.boxShadow = '0 8px 32px rgba(0,0,0,0.7)';
        modal.innerHTML = `
            <h3>Confirmar: ${produto.nome_produto}</h3>
            <p class="card-description">${produto.descricao_produto || 'Sem descrição'}</p>
            <p class="card-price">A partir de R$${parseFloat(produto.menor_preco).toFixed(2)}</p>
            <button class="confirm-button">Ir para Pagamento</button>
            <button class="back-button" style="margin-top:12px; width: 100%;">Cancelar</button>
        `;

        modal.querySelector('.confirm-button').addEventListener('click', () => {
            window.location.href = `pagamento.html?id_produto=${produto.id_produto}`;
        });
        modal.querySelector('.back-button').addEventListener('click', () => {
            document.body.removeChild(overlay);
        });

        overlay.appendChild(modal);
        document.body.appendChild(overlay);
    }

    // Iniciar a aplicação
    fetchCategorias();
});