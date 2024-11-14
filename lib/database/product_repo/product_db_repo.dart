import 'package:collection/collection.dart';

import '../../model/price_list/product_price_list_item.dart';
import '../../model/product/product.dart';
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

  Future<Product?> getProductById({required int productId}) async {
    List<Map<String, dynamic>> productJsonList = await helper
        .readDataByWhereArgs(
            tableName: DBConstant.productProductTable,
            orderBy: DBConstant.name,
            where: '${DBConstant.id} =? ',
            whereArgs: [productId]);

    Product? product;

    for (Map<String, dynamic> jsonData in productJsonList) {
      product = Product.fromJsonDB(jsonData);
      print("Fetch Product : ${product.toJson()}");
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

  Future<List<Product>> getProductList() async {
    List<Product> products = [];

    List<Map<String, dynamic>> productJsonList = await helper
        .readDataByWhereArgs(
            tableName: DBConstant.productProductTable,
            orderBy: DBConstant.name,
            where: '${DBConstant.detialType} =? ',
            whereArgs: [ProductDetailTypes.product.name]);
    // List<Map<String, dynamic>> productUomList =
    //     await helper.readAllData(tableName: DBConstant.productUomTable);
    List<Map<String, dynamic>> uomMapList =
        await helper.readAllData(tableName: DBConstant.uomUomTable);

    List<UomLine> uomList = [];

    uomMapList.forEach(
      (element) => uomList.add(UomLine.fromJson(element)),
    );

    for (Map<String, dynamic> element in productJsonList) {
      Product product = Product.fromJsonDB(element);
      product.uomLines = [];
      product.uomLines?.addAll(uomList.where(
        (element) => element.uomCategoryId == product.uomCategoryId,
      ));
      products.add(product);
    }

    products.forEach(
      (element) => print("Product : ${element.toJson()}"),
    );

    return products;
  }

  Future<List<Product>> getProductByCategory({int? categoryId}) async {
    List<Product> productList = [];
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
      productList.add(Product.fromJsonDB(json));
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
