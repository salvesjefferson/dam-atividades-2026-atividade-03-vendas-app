import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/cart/widgets/cart_bottom_banner.dart';

class ProductListPage extends StatelessWidget
{
    const ProductListPage({super.key});

    @override
    Widget build(BuildContext context)
    {
        final productViewModel = context.watch<ProductViewModel>();
        final cartViewModel = context.read<CartViewModel>();

        return Scaffold(
            appBar: AppBar(
                title: const Text('Produtos'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
                actions: [
                    //botão de ordenação
                    IconButton(
                        icon: const Icon(Icons.sort),
                        onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                    return SimpleDialog(
                                        //opções de ordenação
                                        title: const Text('Ordenar por:'),
                                        children: <Widget>[
                                            SimpleDialogOption(
                                                onPressed: () {
                                                    Navigator.pop(context, 'Nome (A-Z)');
                                                    productViewModel.sortByName(ascending: true);
                                                },
                                                child: const Text('Nome (A-Z)'),
                                            ),
                                            SimpleDialogOption(
                                                onPressed: () {
                                                    Navigator.pop(context, 'Nome (Z-A)');
                                                    productViewModel.sortByName(ascending: false);
                                                },
                                                child: const Text('Nome (Z-A)'),
                                            ),
                                            SimpleDialogOption(
                                                onPressed: () {
                                                    Navigator.pop(context, 'Preço (Menor para Maior)');
                                                    productViewModel.sortByPrice(ascending: true);
                                                },
                                                child: const Text('Preço (Menor para Maior)'),
                                            ),
                                            SimpleDialogOption(
                                                onPressed: () {
                                                    Navigator.pop(context, 'Preço (Maior para Menor)');
                                                    productViewModel.sortByPrice(ascending: false);
                                                },
                                                child: const Text('Preço (Maior para Menor)'),
                                            ),
                                        ],
                                    );
                                },
                            );
                        },
                        tooltip: 'Ordernar Produtos',
                    ),
                    IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => Navigator.pushNamed(context, '/products/form'),
                        tooltip: 'Adicionar Produto',
                    ),
                ],
            ),
            body: Column(
                children: [
                    // Filtros de Categoria (Chips horizontais)
                    SizedBox(
                        height: 60,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                            itemCount: productViewModel.categories.length,
                            itemBuilder: (context, index)
                            {
                                final category = productViewModel.categories[index];
                                final isSelected = productViewModel.currentCategory == category;
                                return Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                                    child: FilterChip(
                                        label: Text(category),
                                        selected: isSelected,
                                        onSelected: (_)
                                        {
                                            productViewModel.filterByCategory(category);
                                        },
                                    ),
                                );
                            },
                        ),
                    ),
                    // Lista de Produtos
                    Expanded(
                        child: productViewModel.products.isEmpty
                            ? const Center(child: Text('Nenhum produto cadastrado.'))
                            : GridView.builder(
                            //mudança de listview pra gridview
                                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 10,
                                    crossAxisSpacing: 10,
                                    childAspectRatio: 0.75,
                                ),
                                itemCount: productViewModel.products.length,
                                itemBuilder: (context, index)
                                {
                                    final product = productViewModel.products[index];
                                    return Card(
                                        clipBehavior: .hardEdge,
                                        child: Center(
                                            child: Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                children: [
                                                    SizedBox(
                                                        child: product.imageUrl.isNotEmpty
                                                            ? Image.network(
                                                                product.imageUrl,
                                                                fit: BoxFit.cover,
                                                                errorBuilder: (context, error, stackTrace) =>
                                                                const Icon(Icons.broken_image, size: 40),
                                                            )
                                                            : const Icon(Icons.image, size: 40),
                                                    ),
                                                    Text(product.name),
                                                    Text(
                                                        'R\$ ${product.price.toStringAsFixed(2)} | ${product.category}',
                                                    ),
                                                    Row(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                            IconButton(
                                                                icon: Icon(
                                                                    product.isFavorite
                                                                        ? Icons.favorite
                                                                        : Icons.favorite_border,
                                                                    color: product.isFavorite ? Colors.red : null,
                                                                ),
                                                                tooltip: 'Adicionar aos Favoritos',
                                                                onPressed: () =>
                                                                productViewModel.toggleFavorite(product.id),
                                                            ),
                                                            IconButton(
                                                                icon: const Icon(Icons.add_shopping_cart, color: Colors.blue),
                                                                tooltip: 'Adicionar ao Carrinho',
                                                                onPressed: ()
                                                                {
                                                                    cartViewModel.addToCart(product);
                                                                },
                                                            ),
                                                        ],
                                                    ),
                                                ],
                                            ),
                                        ),
                                    );
                                },
                            ),
                    ),
                ],
            ),
            bottomNavigationBar: const CartBottomBanner(),
        );
    }
}

