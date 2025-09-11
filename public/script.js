document.addEventListener('DOMContentLoaded', () => {
    const appContainer = document.getElementById('app-container');

    function handleFetchError(error) {
        console.error('Erro na requisição:', error);
        let errorMessage = `<p class="error-message">Não foi possível carregar o cardápio. Verifique a conexão com a internet.</p>`;
        
        // Se o erro for um objeto com detalhes (vindo do nosso backend)
        if (error && error.detalhes) {
            errorMessage = `
                <div class="error-message">
                    <strong>Erro no Servidor:</strong> ${error.erro}<br>
                    <strong>Detalhes:</strong> ${error.detalhes}
                </div>
            `;
        }
        
        appContainer.innerHTML = errorMessage;
    }

    function fetchCategorias() {
        fetch('/TELA/api_categorias.php')
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw err; });
                }
                return response.json();
            })
            .then(data => {
                if (data.erro) { throw data; }
                renderCategorias(data);
            })
            .catch(handleFetchError);
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
        fetch(`/TELA/api_produtos.php?id_categoria=${idCategoria}`)
            .then(response => {
                if (!response.ok) {
                    return response.json().then(err => { throw err; });
                }
                return response.json();
            })
            .then(data => {
                if (data.erro) { throw data; }
                renderProdutos(data, nomeCategoria);
            })
            .catch(error => {
                console.error('Erro ao buscar produtos:', error);
                let errorMessage = `<p class="error-message">Não foi possível carregar os produtos.</p>`;
                if (error && error.detalhes) {
                    errorMessage = `
                        <div class="error-message">
                            <strong>Erro no Servidor:</strong> ${error.erro}<br>
                            <strong>Detalhes:</strong> ${error.detalhes}
                        </div>
                    `;
                }
                appContainer.innerHTML = `<button class="back-button">Voltar</button>${errorMessage}`;
                appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);
            });
    }

    function renderProdutos(produtos, nomeCategoria) {
        appContainer.innerHTML = `<button class="back-button">Voltar</button><h2>${nomeCategoria}</h2><div class="card-list"></div>`;
        const cardList = appContainer.querySelector('.card-list');
        appContainer.querySelector('.back-button').addEventListener('click', fetchCategorias);

        produtos.forEach(produto => {
            const card = document.createElement('div');
            card.className = 'card product-card';
            
            const buttonText = nomeCategoria.toLowerCase().includes('bebidas') ? 'Pedir esta bebida' : 'Pedir este sabor';

            card.innerHTML = `
                <h3>${produto.nome_produto}</h3>
                <p class="card-description">${produto.descricao_produto || 'Sem descrição'}</p>
                <p class="card-price">A partir de R$${parseFloat(produto.menor_preco).toFixed(2)}</p>
                <button class="confirm-button">${buttonText}</button>
            `;
            card.querySelector('.confirm-button').addEventListener('click', (e) => {
                e.stopPropagation();
                mostrarConfirmacao(produto);
            });
            cardList.appendChild(card);
        });
    }

    function mostrarConfirmacao(produto) {
        const oldOverlay = document.querySelector('.modal-overlay');
        if (oldOverlay) oldOverlay.remove();

        const overlay = document.createElement('div');
        overlay.className = 'modal-overlay';

        const modal = document.createElement('div');
        modal.className = 'card';
        modal.style.maxWidth = '400px';
        modal.style.cursor = 'default';
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

    fetchCategorias();
});