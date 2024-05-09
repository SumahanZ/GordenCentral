import 'package:tugas_akhir_project/models/cartitem.dart';
import 'package:tugas_akhir_project/models/customer.dart';
import 'package:tugas_akhir_project/models/toko.dart';

class Invoice {
  final Customer? customer;
  final Toko? toko;
  final CartItem? cartItem;

  Invoice({this.customer, this.toko, this.cartItem});
}
