import '../model/category.dart';
import '../model/order.dart';
import '../model/product.dart';
import '../model/sale.dart';
import '../model/shift.dart';
import '../model/supplier.dart';
import '../model/taker.dart';
import '../model/user.dart';

final List<Shift> shiftsData = [
  Shift(
    id: 1,
    userId: 2,
    startTime: DateTime.now(),
    startCash: 100.00,
    endCash: 135.00,
    endTime: DateTime.now().add(Duration(days: 1)),
    isOpened: false,
  ),
];

final List<User> usersData = [
  User(
    id: 2,
    name: 'John Doe',
    role: 'manager',
  ),
  User(
    id: 3,
    name: 'teste',
    role: 'employee',
  ),
];

final List<Supplier> supplierData = [
  Supplier(
    id: 1,
    name: 'Supplier 1',
    email: 'teste@mail.com',
    phone: '(34) 99999-9999',
  ),
  Supplier(
    id: 2,
    name: 'Supplier 2',
    email: 'teste2@gmail.com',
    phone: '(34) 99999-9999',
  ),
  Supplier(
    id: 3,
    name: 'Supplier 3',
    email: 'teste3@gmail.com',
  ),
];

final List<Category> categoriesData = [
  Category(
    id: 1,
    name: 'Category 1',
  ),
  Category(
    id: 2,
    name: 'Category 2',
  ),
  Category(
    id: 3,
    name: 'Category 3',
  ),
];

final List<Product> productsData = [
  Product(
    id: 1,
    barCode: '123456789',
    name: 'Product 1',
    price: 10.00,
    costPrice: 5.00,
    unit: 1,
    urlImage:
        "https://naturaldaterra.com.br/media/catalog/product/1/0/104192---7894900010015---refrigerante-coca-cola-lata-350ml.jpg?auto=webp&format=pjpg&width=640&height=800&fit=cover",
    categoryId: 1,
    supplierId: 1,
  ),
  Product(
    id: 2,
    barCode: '123456789',
    name: 'Product 2',
    price: 10.00,
    costPrice: 5.00,
    unit: 1,
    urlImage:
        "https://img.megaboxatacado.com.br/produto/1000X1000/2017712_21322.jpg",
    categoryId: 2,
    supplierId: 2,
  ),
  Product(
    id: 3,
    barCode: '123456789',
    name: 'Product 3',
    price: 10.00,
    costPrice: 5.00,
    unit: 1,
    urlImage:
        "https://images-americanas.b2w.io/produtos/104896376/imagens/refrigerante-fanta-laranja-lata-350-ml/104896378_1_xlarge.jpg",
    categoryId: 3,
    supplierId: 3,
  ),
  Product(
    id: 4,
    barCode: '123456789',
    name: 'Product 4',
    price: 10.00,
    costPrice: 5.00,
    unit: 1,
    categoryId: 3,
    supplierId: 3,
  ),
];

final List<Taker> takersData = [
  Taker(
    id: 1,
    name: 'Taker 1',
    total_price: 10.00,
    phone: '(34) 99999-9999',
  ),
  Taker(
    id: 2,
    name: 'Taker 2',
    total_price: 10.00,
    phone: '(34) 99999-9999',
  ),
  Taker(
    id: 3,
    name: 'Taker 3',
    phone: '(34) 99999-9999',
  ),
];

final List<Order> ordersData = [
  Order(
    id: 1,
    shiftId: 1,
    paymentType: 'cash',
    orderTime: DateTime.now(),
  ),
  Order(
    id: 2,
    shiftId: 1,
    paymentType: 'credit',
    orderTime: DateTime.now(),
  ),
  Order(
    id: 3,
    shiftId: 1,
    paymentType: 'debit',
    orderTime: DateTime.now(),
  ),
];

final List<Sale> salesData = [
  Sale(
    id: 1,
    orderId: 1,
    productId: 1,
    quantity: 1,
  ),
  Sale(
    id: 2,
    orderId: 2,
    productId: 2,
    quantity: 2,
  ),
  Sale(id: 3, orderId: 3, productId: 3, quantity: 3),
];
