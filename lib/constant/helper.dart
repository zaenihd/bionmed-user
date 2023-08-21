// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:intl/intl.dart';

String priceFormat(dynamic price) {
  if (price != null) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(price);
  } else
    return 'Rp. Null';
}

String priceFormatWithoutSymbol(dynamic price) {
  return NumberFormat.currency(
    locale: 'id_ID',
    symbol: '',
    decimalDigits: 0,
  ).format(price);
}

countTotal(String v1, String v2) {
  double a = double.parse(v1);
  double b = double.parse(v2);

  return a + b;
}

String sliceDate(String num) {
  String a = num.substring(5, 10);
  String bln = a.substring(0, 2);
  String tgl = a.substring(3, 5);
  String c = '$tgl/$bln';
  return c;
}

newLine(text) {
  if (text != null) {
    var a = text.split("/n").join("\n");
    var b = a.split("\n\n\n\n\n\n\n\n\n\n").join("");
    return b;
  } else
    return '';
}

tagihanPLN(str) {
  var a = str[0];
  if (a == '0') {
    var b = str.substring(1);
    return b;
  } else
    return str;
}

goldPriceSLice(text) {
  if (text != null) {
    var a = text.substring(0, 4);
    return priceFormatWithoutSymbol(int.parse(a));
  } else
    return '';
}
