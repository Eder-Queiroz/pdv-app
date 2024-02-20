import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart';

class DbUtil {
  DbUtil._();
  static final DbUtil instance = DbUtil._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  _initDatabase() async {
    return await sql.openDatabase(
      path.join(await sql.getDatabasesPath(), 'pdv_database.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  _onCreate(Database db, version) async {
    await db.execute(_users);
    await db.execute(_categories);
    await db.execute(_suppliers);
    await db.execute(_products);
    await db.execute(_purchases);
    await db.execute(_shifts);
    await db.execute(_takers);
    await db.execute(_sales);
    await db.execute(_orders);
    await db.execute(_changeds);
    await db.execute(_insertUser);
  }

  String get _users => '''
    CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY,
        name varchar(255) NOT NULL,
        password varchar(255) NOT NULL,
        role varchar(255) NOT NULL
    );
    ''';

  String get _categories => '''
  CREATE TABLE IF NOT EXISTS categories (
        id INTEGER PRIMARY KEY,
        name varchar(255) NOT NULL
  );
  ''';

  String get _suppliers => '''
  CREATE TABLE if NOT EXISTS suppliers(
        id INTEGER PRIMARY KEY,
        name varchar(255) NOT NULL,
        email varchar(255),
        phone varchar(255)
  );
  ''';

  String get _products => '''
  CREATE TABLE IF NOT EXISTS products (
        id INTEGER PRIMARY KEY,
        bar_code varchar(255) NOT NULL,
        name varchar(255) NOT NULL,
        price TEXT NOT NULL,
        cost_price TEXT NOT NULL,
        unit INTEGER NOT NULL,
        url_image TEXT,
        category_id INTEGER NOT NULL,
        supplier_id INTEGER NOT NULL,
        CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES categories (id),
        CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES suppliers (id)
  );
  ''';

  String get _purchases => '''
  CREATE TABLE  IF NOT EXISTS purchases(
        id INTEGER PRIMARY KEY,
        price TEXT NOT NULL,
        amount INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        purchase_date TIMESTAMP NOT NULL,
        CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products (id)
  );
  ''';

  String get _shifts => '''
  CREATE TABLE IF NOT EXISTS shifts(
        id INTEGER PRIMARY KEY,
        user_id INTEGER NOT NULL,
        start_time TIMESTAMP NOT NULL,
        end_time TIMESTAMP,
        start_cash TEXT NOT NULL,
        end_cash TEXT,
        is_opened BOOLEAN NOT NULL,
        CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES users (id)
  );
  ''';

  String get _takers => '''
  CREATE TABLE IF NOT EXISTS takers(
        id INTEGER PRIMARY KEY,
        name varchar(255) NOT NULL,
        total_price numeric(10,2) NOT NULL,
        phone varchar(255)
  );
  ''';

  String get _sales => '''
  CREATE TABLE IF NOT EXISTS sales(
        id INTEGER PRIMARY KEY,
        order_id INTEGER NOT NULL,
        product_id INTEGER NOT NULL,
        quantity INTEGER NOT NULL,
        CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES products (id),
        CONSTRAINT fk_order_id FOREIGN KEY (order_id) REFERENCES orders (id)
  );
  ''';

  String get _orders => '''
  CREATE TABLE IF NOT EXISTS orders(
        id INTEGER PRIMARY KEY,
        shift_id INTEGER NOT NULL,
        taker_id INTEGER,
        payment_method VARCHAR(255) NOT NULL,
        order_time TIMESTAMP NOT NULL,
        CONSTRAINT fk_shift_id FOREIGN KEY (shift_id) REFERENCES shifts (id),
        CONSTRAINT fk_taker_id FOREIGN KEY (taker_id) REFERENCES takers (id)
  );
  ''';

  String get _changeds => '''
  CREATE TABLE IF NOT EXISTS changeds(
        id INTEGER PRIMARY KEY,
        shift_id INTEGER NOT NULL,
        value TEXT NOT NULL,
        changed_time TIMESTAMP NOT NULL,
        CONSTRAINT fk_shift_id FOREIGN KEY (shift_id) REFERENCES shifts (id)
  );
  ''';

  String get _insertUser => '''
  INSERT INTO users (name, password, role) VALUES ('admin', 'admin', 'manager');
  ''';
}
