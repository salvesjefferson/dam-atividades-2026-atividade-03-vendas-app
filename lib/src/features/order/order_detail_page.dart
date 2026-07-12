import 'package:flutter/material.dart';
import 'package:vendas_app/src/models/order_model.dart';

class OrderDetailPage extends StatelessWidget
{
    const OrderDetailPage({super.key});

    @override
    Widget build(BuildContext context)
    {
        // Pegando o pedido passado via argumentos de rota
        final order = ModalRoute.of(context)!.settings.arguments as OrderModel;

        return Scaffold(
            appBar: AppBar(
                title: Text('Pedido #${order.id.substring(0, 8)}'),
                backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            ),
            body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        const Text(
                            'Informações do Cliente',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text('Nome: ${order.client.name}'),
                        Text('E-mail: ${order.client.email}'),
                        Text('Telefone: ${order.client.phone}'),
                        const Divider(height: 32),
                        const Text(
                            'Itens do Pedido',
                            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),

                        Expanded(
                            child: SingleChildScrollView(
                                child: DataTable(
                                    columnSpacing: 5,
                                    horizontalMargin: 10,
                                    columns: [

                                        DataColumn(label: Expanded(child: Text('Produto', style: TextStyle(fontStyle: .italic)),
                                        ),),
                                        DataColumn(label: Expanded(child: Text('Qtd', style: TextStyle(fontStyle: .italic)),
                                        ),),
                                        DataColumn(label: Expanded(child: Text('Preço Unitário', style: TextStyle(fontStyle: .italic)),
                                        ),),
                                        DataColumn(label: Expanded(child: Text('Subtotal', style: TextStyle(fontStyle: .italic)),
                                        ),),
                                    ], rows: order.items.map((order)
                                        {
                                            return DataRow(cells: [

                                                DataCell(
                                                    Text(order.product.name),),
                                                DataCell(
                                                    Container(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(order.quantity.toString(),),
                                                    ),
                                                ),
                                                DataCell(
                                                    Container(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(order.product.price.toStringAsFixed(2), textAlign: TextAlign.end,),
                                                    ),
                                                ),
                                                DataCell(
                                                    Container(
                                                        alignment: Alignment.centerRight,
                                                        child: Text(order.total.toStringAsFixed(2),),
                                                    ),
                                                ),
                                            ]);
                                        }
                                    ).toList(),
                                ),
                            ),
                        ),

                        const Divider(),
                        Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                    const Text(
                                        'Valor Total Geral:',
                                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                        'R\$ ${order.totalAmount.toStringAsFixed(2)}',
                                        style: TextStyle(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                            color: Theme.of(context).colorScheme.primary,
                                        ),
                                    ),
                                ],
                            ),
                        ),
                    ],
                ),
            ),
        );
    }
}
