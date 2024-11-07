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

  Future<List<Product>> getProductList() async {
    List<Product> products = [];

    List<Map<String, dynamic>> productJsonList = await helper
        .readDataByWhereArgs(
            tableName: DBConstant.productTable,
            orderBy: DBConstant.name,
            where: '${DBConstant.detialType} =? ',
            whereArgs: [ProductDetailTypes.product.name]);
    List<Map<String, dynamic>> productUomList =
        await helper.readAllData(tableName: DBConstant.productUomTable);

    for (Map<String, dynamic> element in productJsonList) {
      Product product = Product.fromJsonDB(element);
      product.uomLines = [];
      productUomList.forEach(
        (uomLine) {
          if (uomLine[DBConstant.productId] == product.id) {
            product.uomLines?.add(UomLine.fromJsonDB(uomLine));
          }
        },
      );
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
          tableName: DBConstant.productTable,
          where: '${DBConstant.categId}=?',
          whereArgs: [categoryId]);
    } else {
      jsonList = await helper.readAllData(tableName: DBConstant.productTable);
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
