import 'package:mmt_mobile/database/base_db_repo.dart';

import '../../model/category.dart';
import '../db_constant.dart';

class ProductCategoryDBRepo extends BaseDBRepo{
  static final ProductCategoryDBRepo instance = ProductCategoryDBRepo._();

  ProductCategoryDBRepo._();

  Future<List<Category>> getProductCategory() async{
    List<Map<String,dynamic>> productCategoryMapList = await helper.readAllData(tableName: DBConstant.categoryTable);

    List<Category> categoryList = [];

    productCategoryMapList.forEach((element) {
      categoryList.add(Category.fromJson(element));
    },);

    return categoryList;
  }
}