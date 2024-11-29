import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/models/model.dart';
import 'package:listar_flutter_pro/screens/screen.dart';

abstract class ListingStyleFactory {
  StatefulWidget createProductDetail(ProductModel item);
  StatelessWidget createProduct(ProductModel item);
  StatelessWidget createCategory(CategoryModel item);
}

class ListingCreator {
  final String type;

  ListingCreator(this.type);

  ListingStyleFactory create() {
    switch (type) {
      case 'professional_1':
        return Professional1();
      case 'professional_2':
        return Professional2();
      case 'professional_3':
        return Professional3();
      default:
        return BasicStyle();
    }
  }
}

class BasicStyle implements ListingStyleFactory {
  @override
  StatelessWidget createCategory(CategoryModel item) {
    return Container();
  }

  @override
  StatelessWidget createProduct(ProductModel item) {
    return Container();
  }

  @override
  StatefulWidget createProductDetail(item) {
    return ProductDetail(item: item);
  }
}

class Professional1 implements ListingStyleFactory {
  @override
  StatelessWidget createCategory(CategoryModel item) {
    throw UnimplementedError();
  }

  @override
  StatelessWidget createProduct(ProductModel item) {
    throw UnimplementedError();
  }

  @override
  StatefulWidget createProductDetail(item) {
    return ProductDetail1(item: item);
  }
}

class Professional2 implements ListingStyleFactory {
  @override
  StatelessWidget createCategory(CategoryModel item) {
    throw UnimplementedError();
  }

  @override
  StatelessWidget createProduct(ProductModel item) {
    throw UnimplementedError();
  }

  @override
  StatefulWidget createProductDetail(item) {
    return ProductDetail2(item: item);
  }
}

class Professional3 implements ListingStyleFactory {
  @override
  StatelessWidget createCategory(CategoryModel item) {
    return Container();
  }

  @override
  StatelessWidget createProduct(ProductModel item) {
    return Container();
  }

  @override
  StatefulWidget createProductDetail(item) {
    return ProductDetail3(item: item);
  }
}
