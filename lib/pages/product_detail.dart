import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/src/go_router.dart';

class ProductDetail extends StatefulWidget {
  final String id;

  const ProductDetail({Key? key, required this.id}) : super(key: key);

  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: kIsWeb
            ? null
            : BackButton(
                onPressed: () => context.goNamed('home'),
              ),
        title: Text('Product Item ${widget.id}'),
      ),
      body: Center(
        child: Card(
          child: Text('Product Detail'),
        ),
      ),
    );
  }
}
