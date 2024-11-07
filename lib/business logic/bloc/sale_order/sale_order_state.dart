part of 'sale_order_cubit.dart';

 class SaleOrderState {
   List<SaleOrderLine> saleOrderLineList ;


   SaleOrderState({required this.saleOrderLineList});


   SaleOrderState copyWith({List<SaleOrderLine>? saleOrderLineList}){
     return SaleOrderState(
         saleOrderLineList: saleOrderLineList ?? this.saleOrderLineList
     );

   }
 }

