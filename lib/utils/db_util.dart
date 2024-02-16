import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'pdv.db'),
      onCreate: (db, version) {
        return db.execute(
            'CREATE TABLE IF NOT EXISTS public."users" (id serial NOT NULL, name varchar(255) NOT NULL, password varchar(255) NOT NULL, role VARCHAR(255) NOT NULL, CONSTRAINT user_pkey PRIMARY KEY (id)); CREATE TABLE IF NOT EXISTS public."categories" (id serial NOT NULL, name varchar(255) NOT NULL, CONSTRAINT category_pkey PRIMARY KEY (id)); CREATE TABLE if NOT EXISTS public."suppliers"(id serial NOT NULL, name varchar(255) NOT NULL, email varchar(255), phone varchar(255), CONSTRAINT supplier_pkey PRIMARY KEY(id)); CREATE TABLE IF NOT EXISTS public."products" (id serial NOT NULL, bar_code varchar(255) NOT NULL, name varchar(255) NOT NULL, price numeric(10, 2) NOT NULL, cost_price numeric(10, 2) NOT NULL, unit INTEGER NOT NULL, category_id INTEGER NOT NULL, supplier_id INTEGER NOT NULL, CONSTRAINT product_pkey PRIMARY KEY (id)); ALTER TABLE public."products" ADD CONSTRAINT fk_category_id FOREIGN KEY (category_id) REFERENCES public."categories" (id); ALTER TABLE public."products" ADD CONSTRAINT fk_supplier_id FOREIGN KEY (supplier_id) REFERENCES public."suppliers" (id); CREATE TABLE IF NOT EXISTS public."purchases"( id serial NOT NULL, price numeric(10, 2) NOT NULL, amount INTEGER NOT NULL, product_id INTEGER NOT NULL, purchase_date TIMESTAMP NOT NULL, CONSTRAINT purchase_pkey PRIMARY KEY(id)); ALTER TABLE public."purchases" ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES public."products" (id); CREATE TABLE IF NOT EXISTS public."shifts" ( id serial NOT NULL, user_id INTEGER NOT NULL, start_time TIMESTAMP NOT NULL, end_time TIMESTAMP, start_cash numeric(10, 2) NOT NULL, end_cash numeric(10, 2), is_opened BOOLEAN NOT NULL, CONSTRAINT shift_pkey PRIMARY KEY (id)); ALTER TABLE public."shifts" ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES public."users" (id); CREATE TABLE if NOT EXISTS public."takers"( id serial NOT NULL, name varchar(255) NOT NULL, total_price numeric(10,2) NOT NULL, phone varchar(255), CONSTRAINT taker_pkey PRIMARY KEY (id) ); CREATE TABLE IF NOT EXISTS public."sales" ( id serial NOT NULL, shift_id INTEGER NOT NULL, product_id INTEGER NOT NULL, taker_id INTEGER, quantity INTEGER NOT NULL, payment_method VARCHAR(255) NOT NULL, sale_time TIMESTAMP NOT NULL, CONSTRAINT sale_pkey PRIMARY KEY (id)); ALTER TABLE public."sales" ADD CONSTRAINT fk_shift_id FOREIGN KEY (shift_id) REFERENCES public."shifts" (id); ALTER TABLE public."sales" ADD CONSTRAINT fk_taker_id FOREIGN KEY (taker_id) REFERENCES public."takers" (id); ALTER TABLE public."sales" ADD CONSTRAINT fk_product_id FOREIGN KEY (product_id) REFERENCES public."products" (id); CREATE TABLE IF NOT EXISTS public."changeds" ( id serial NOT NULL, shift_id INTEGER NOT NULL, value numeric(10, 2) NOT NULL, changed_time TIMESTAMP NOT NULL, CONSTRAINT changed_pkey PRIMARY KEY (id)); ALTER TABLE public."changeds" ADD CONSTRAINT fk_shift_id FOREIGN KEY (shift_id) REFERENCES public."shifts" (id);');
      },
      version: 1,
    );
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DbUtil.database();
    await db.insert(
      table,
      data,
      conflictAlgorithm: sql.ConflictAlgorithm.replace,
    );
  }
}
