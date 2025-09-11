document.addEventListener('DOMContentLoaded', () => {
    const productListContainer = document.getElementById('product-management-list');
    const orderListContainer = document.getElementById('order-list');

    function fetchAdminProducts() {
        fetch('api_produtos_admin.php')
            .then(response => response.json())
            .then(data => {
                renderAdminProducts(data);
            })
            .catch(error => {
                console.error('Erro ao buscar produtos para admin:', error);
                productListContainer.innerHTML = '<p>Erro ao carregar produtos.</p>';
            });
    }

    function renderAdminProducts(products) {
        if (!products || products.length === 0) {
            productListContainer.innerHTML = '<p>Nenhum produto encontrado.</p>';
            return;
        }

        const groupedProducts = products.reduce((acc, product) => {
            const category = product.nome_categoria;
            if (!acc[category]) {
                acc[category] = [];
            }
            acc[category].push(product);
            return acc;
        }, {});

        productListContainer.innerHTML = '';

        for (const category in groupedProducts) {
            const categorySection = document.createElement('div');
            categorySection.className = 'category-management-section';

            const categoryTitle = document.createElement('h3');
            categoryTitle.className = 'category-title';
            categoryTitle.textContent = category;
            categorySection.appendChild(categoryTitle);

            const productsGrid = document.createElement('div');
            productsGrid.className = 'card-list';

            groupedProducts[category].forEach(product => {
                const card = document.createElement('div');
                card.className = 'card admin-card';

                const isVisible = product.visivel == 1;
                const visibilityClass = isVisible ? 'visible' : 'hidden';
                const visibilityText = isVisible ? 'Ocultar do Cardápio' : 'Exibir no Cardápio';
                const photoUrl = product.foto_url || 'https://via.placeholder.com/280x150.png?text=Sem+Foto';

                card.innerHTML = `
                    <h4>${product.nome_produto}</h4>
                    <img src="../public/img/${photoUrl}" alt="${product.nome_produto}" class="product-photo" onerror="this.src='https://via.placeholder.com/280x150.png?text=Sem+Foto'">
                    
                    <label class="form-label">Alterar Foto:</label>
                    <input type="file" class="file-input" accept="image/*" data-id="${product.id_produto}">
                    
                    <button class="toggle-visibility-btn ${visibilityClass}" data-id="${product.id_produto}" data-visible="${isVisible ? '1' : '0'}">
                        ${visibilityText}
                    </button>
                `;
                productsGrid.appendChild(card);
            });

            categorySection.appendChild(productsGrid);
            productListContainer.appendChild(categorySection);
        }

        document.querySelectorAll('.toggle-visibility-btn').forEach(button => {
            button.addEventListener('click', handleVisibilityToggle);
        });
    }

    function handleVisibilityToggle(event) {
        const button = event.target;
        const productId = button.dataset.id;
        const currentVisibility = button.dataset.visible;
        const newVisibility = currentVisibility === '1' ? '0' : '1';

        const formData = new FormData();
        formData.append('id_produto', productId);
        formData.append('visivel', newVisibility);

        fetch('api_alterar_visibilidade.php', {
            method: 'POST',
            body: formData
        })
        .then(response => response.json())
        .then(data => {
            if (data.sucesso) {
                button.dataset.visible = newVisibility;
                const isVisible = newVisibility === '1';
                button.textContent = isVisible ? 'Ocultar do Cardápio' : 'Exibir no Cardápio';
                button.classList.toggle('visible', isVisible);
                button.classList.toggle('hidden', !isVisible);
            } else {
                alert('Erro ao alterar visibilidade: ' + data.erro);
            }
        })
        .catch(error => {
            console.error('Erro na requisição:', error);
            alert('Erro de comunicação com o servidor.');
        });
    }

    function fetchOrders() {
        fetch('api_pedidos_admin.php')
            .then(response => response.json())
            .then(data => {
                renderOrders(data);
            })
            .catch(error => {
                console.error('Erro ao buscar pedidos:', error);
                orderListContainer.innerHTML = '<p>Erro ao carregar pedidos.</p>';
            });
    }

    function renderOrders(orders) {
        if (!orders || orders.length === 0) {
            orderListContainer.innerHTML = '<p>Nenhum pedido recente.</p>';
            return;
        }

        orderListContainer.innerHTML = '';

        orders.forEach(order => {
            const card = document.createElement('div');
            card.className = 'card admin-card';
            const dataPedido = new Date(order.data_pedido).toLocaleString('pt-BR');

            card.innerHTML = `
                <h4>Pedido #${order.id_pedido}</h4>
                <p><strong>Produto:</strong> ${order.nome_produto}</p>
                <p><strong>Valor:</strong> R$${parseFloat(order.valor_final).toFixed(2)}</p>
                <p><strong>Data:</strong> ${dataPedido}</p>
                <p><strong>Status:</strong> ${order.status_pedido}</p>
            `;
            orderListContainer.appendChild(card);
        });
    }

    fetchAdminProducts();
    fetchOrders();
});