import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProductDetail extends StatefulWidget {
  final String id;

  const ProductDetail({super.key, required this.id});

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
                onPressed: () => context.go('/'),
              ),
        title: Text('Product Item ${widget.id}'),
      ),
      body: const Center(
        child: Card(
          child: Text('Product Detail'),
        ),
      ),
    );
  }
}
