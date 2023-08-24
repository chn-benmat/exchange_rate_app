import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// สร้าง container ต้นแบบ
class ExchangeRateBox extends StatelessWidget {
  String title; //ชื่อสกุลเงิน
  double? amount; //จำนวนเงิน
  Color color; //สีbox
  double size; //ขนาดbox
  String currency; //สกุลเงิน
  ExchangeRateBox(
      this.title, this.amount, this.currency, this.color, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      height: size,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Text(
                '${NumberFormat("#,###.##").format(amount)}',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                    textAlign:TextAlign.right,
              ),
            ),
          ),Text(
            currency,
            style: TextStyle(
                fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold,overflow: TextOverflow.ellipsis),
          ),
        ],
      ),
    );
  }
}
