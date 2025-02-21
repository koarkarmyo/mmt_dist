import 'package:flutter/foundation.dart';

import '../../model/price_list/product_price_list_item.dart';
import '../../model/product/product_product.dart';
import '../../model/product/uom_lines.dart';
import '../../src/enum.dart';
import '../base_db_repo.dart';
import '../db_constant.dart';

class ProductDBRepo extends BaseDBRepo {
  static final ProductDBRepo instance = ProductDBRepo._();

  ProductDBRepo._();

  Future<List<ProductPriceListItem>> getPriceList(
      {required int productId, required int groupId}) async {
    final List<ProductPriceListItem> priceList = await dataObject.getPriceList(
        where:
            '${DBConstant.productTmplId} =? AND ${DBConstant.priceListId} =?',
        arg: [productId.toString(), groupId.toString()]);
    priceList.sort((a, b) => a.minQuantity!.compareTo(b.minQuantity!));
    return priceList;
  }

  Future<ProductProduct?> getProductById({required int productId}) async {
    List<Map<String, dynamic>> productJsonList = await helper
        .readDataByWhereArgs(
            tableName: DBConstant.productProductTable,
            orderBy: DBConstant.name,
            where: '${DBConstant.id} =? ',
            whereArgs: [productId]);

    ProductProduct? product;

    for (Map<String, dynamic> jsonData in productJsonList) {
      product = ProductProduct.fromJsonDB(jsonData);
    }

    if (product != null) {
      List<Map<String, dynamic>> uomJsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.uomUomTable,
          where: '${DBConstant.uomCategoryId} =? ',
          whereArgs: [product.uomCategoryId]);

      product.uomLines = [];

      for (Map<String, dynamic> json in uomJsonList) {
        product.uomLines?.add(UomLine.fromJson(json));
      }
    }

    return product;
  }

  Future<List<ProductProduct>> getProductList() async {
    List<ProductProduct> products = [];

    // List<Map<String, dynamic>> productJsonList =
    //     await helper.readDataByWhereArgs(
    //   tableName: DBConstant.productProductTable,
    //   orderBy: DBConstant.name,
    //   where: '${DBConstant.type} =? ',
    //   whereArgs: [ProductTypes.consu.name],
    // );
    List<Map<String, dynamic>> productJsonList = await helper.readAllData(
        tableName: DBConstant.productProductTable, orderBy: DBConstant.name);
    List<Map<String, dynamic>> uomMapList =
        await helper.readAllData(tableName: DBConstant.productUomTable);

    List<UomLine> uomList = [];

    uomMapList.forEach((element) {
      UomLine uomLine = UomLine.fromJsonDB(element);
      uomList.add(uomLine);
    });

    for (Map<String, dynamic> element in productJsonList) {
      ProductProduct product = ProductProduct.fromJsonDB(element);
      List<UomLine> lines = uomList
          .where((uom) => uom.productId == product.id)
          .toList(growable: true);
      product.uomLines = lines;
      debugPrint(
          'uomLiness:::${uomList.where((uom) => uom.productId == product.id).length}');
      products.add(product);
    }

    return products;
  }

  Future<List<ProductProduct>> getProductByCategory({int? categoryId}) async {
    List<ProductProduct> productList = [];
    List<Map<String, dynamic>> jsonList = [];

    if (categoryId != null) {
      jsonList = await helper.readDataByWhereArgs(
          tableName: DBConstant.productProductTable,
          where: '${DBConstant.categId}=?',
          whereArgs: [categoryId]);
    } else {
      jsonList =
          await helper.readAllData(tableName: DBConstant.productProductTable);
    }

    for (final json in jsonList) {
      productList.add(ProductProduct.fromJsonDB(json));
    }
    return productList;
  }

// Future<List<Product>> getDiscountProduct() async {
//   List<Product> products = [];
//   List<Map<String, dynamic>> jsonList = await helper.readDataByWhereArgs(
//       tableName: DBConstant.productTable,
//       orderBy: DBConstant.name,
//       where: '${DBConstant.detialType} =?',
//       whereArgs: [ProductDetailTypes.service.name]);
//
//   jsonList.forEach((element) {
//     products.add(Product.fromJsonDB(element));
//   });
//   List<Product> productTemp = [];
//   List<UomLine> uomLines = await ProductUomRepo()
//       .getProductUomLineByProduct(productId: products.first.id ?? 0);
//   products.forEach((product) {
//     product.uomLines = uomLines
//         .where((element) => element.productId == product.productId)
//         .toList();
//     productTemp.add(product);
//   });

//   return products;
// }
}
