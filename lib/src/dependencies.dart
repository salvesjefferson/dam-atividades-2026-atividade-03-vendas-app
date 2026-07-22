import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:vendas_app/src/data/datasources/local/category/category_memory_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/client/client_memory_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/order/order_memory_local_datasource.dart';
import 'package:vendas_app/src/data/datasources/local/product/product_memory_local_datasource.dart';
import 'package:vendas_app/src/data/repositories/category/category_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/client/client_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/order/order_repository_impl.dart';
import 'package:vendas_app/src/data/repositories/product/product_repository_impl.dart';
import 'package:vendas_app/src/features/cart/cart_viewmodel.dart';
import 'package:vendas_app/src/features/category/category_viewmodel.dart';
import 'package:vendas_app/src/features/client/client_viewmodel.dart';
import 'package:vendas_app/src/features/order/order_viewmodel.dart';
import 'package:vendas_app/src/features/product/product_viewmodel.dart';
import 'package:vendas_app/src/features/settings/settins_viewmodel.dart';

List<SingleChildWidget> get appProviders {
  // Inicialização de DataSources
  final clientDatasource = ClientMemoryLocalDatasource();
  final productDatasource = ProductMemoryLocalDatasource();
  final orderDatasource = OrderMemoryLocalDatasource();
  final categoryDatasource = CategoryMemoryLocalDatasource();

  // Inicialização de Repositories
  final clientRepository = ClientRepositoryImpl(clientDatasource);
  final productRepository = ProductRepositoryImpl(productDatasource);
  final orderRepository = OrderRepositoryImpl(orderDatasource);
  final categoryRepository = CategoryRepositoryImpl(categoryDatasource);

  return [
    ChangeNotifierProvider(
      create: (_) => ClientViewModel(clientRepository)..loadClients(),
    ),
    ChangeNotifierProvider(
      create: (_) => CategoryViewModel(categoryRepository)..loadCategories(),
    ),
    ChangeNotifierProvider(
      create: (_) => ProductViewModel(productRepository)..loadProducts(),
    ),
    ChangeNotifierProvider(
      create: (_) => OrderViewModel(orderRepository)..loadOrders(),
    ),
    ChangeNotifierProvider(
      create: (_) => CartViewModel(orderRepository),
    ),
    ChangeNotifierProvider(
      create: (_) => SettingViewModel(),
    ),
  ];
}
