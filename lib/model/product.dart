import './category.dart';

class Product {
  final String id;
  final String nome;
  final String cod_barras;
  final double preco;
  final int unidade;
  final Category categoria;

  const Product({
    required this.id,
    required this.nome,
    required this.cod_barras,
    required this.preco,
    required this.unidade,
    required this.categoria,
  });
}
