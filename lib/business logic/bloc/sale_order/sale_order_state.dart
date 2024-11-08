part of 'sale_order_cubit.dart';

 class SaleOrderState {
   List<SaleOrderLine> saleOrderLineList ;
   BlocCRUDProcessState state;


   SaleOrderState({required this.saleOrderLineList, required this.state});


   SaleOrderState copyWith({List<SaleOrderLine>? saleOrderLineList, BlocCRUDProcessState? state}){
     return SaleOrderState(
         saleOrderLineList: saleOrderLineList ?? this.saleOrderLineList,
       state: state ?? this.state
     );

   }
 }

