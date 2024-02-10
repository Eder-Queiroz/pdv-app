import '../model/product.dart';
import 'category_data.dart';

List<Product> prodcutData = [
  Product(
    id: '1',
    nome: 'Coca-Cola',
    cod_barras: '7894900709841',
    preco: 5.80,
    unidade: 7,
    categoria: categoryData[0],
  ),
  Product(
    id: '2',
    nome: 'Pepsi 2L',
    cod_barras: '7892840813017',
    preco: 8.00,
    unidade: 12,
    categoria: categoryData[0],
  ),
];
