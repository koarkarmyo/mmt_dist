import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mmt_mobile/business%20logic/bloc/location/location_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/ui/widgets/ke_bottom_sheet_choice_widget.dart';

import '../../common_widget/text_widget.dart';
import '../../model/stock_location.dart';
import '../../route/route_list.dart';
import '../../src/const_string.dart';
import '../../src/mmt_application.dart';
import '../../src/style/app_styles.dart';

class StockRequestListPage extends StatefulWidget {
  const StockRequestListPage({super.key});

  @override
  State<StockRequestListPage> createState() => _StockRequestListPageState();
}

class _StockRequestListPageState extends State<StockRequestListPage> {
  late LocationCubit _locationCubit;

  StockLocation? _selectedLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _locationCubit = context.read<LocationCubit>()..getAllStockLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const TextWidget("Stock Request Page"),
        actions: [
          IconButton(
              onPressed: () {
                context.pushTo(route: RouteList.stockRequestAddPage);
              },
              icon: const Icon(Icons.add_circle))
        ],
      ),
      body: Column(
        children: [
          _locationChoiceWidget(),
          const SizedBox(
            height: 20,
          ),
          _productTableHeaderWidget()
        ],
      ).padding(padding: 16.allPadding),
    );
  }

  Widget _locationChoiceWidget() {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(ConstString.location, style: AppStyles.miniTitle,),
            KESingleChoiceWidget<StockLocation>(
              valueList: state.locationList,
              getDisplayString: (value) => value.name ?? '',
              onSelected: (value) {
                if (value != null) {
                  _selectedLocation = value;
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _productTableHeaderWidget() {
    List<TableRow> tableRows = [
      TableRow(
        decoration: BoxDecoration(color: Colors.grey[200]),
        children: [
          _tableItem(ConstString.name, align: Alignment.centerLeft),
          _tableItem(ConstString.balance),
          _tableItem(ConstString.uom),
          _tableItem(ConstString.qty),
        ],
      )
    ];

    return Table(
      border: TableBorder.all(),
      columnWidths: const {
        0: FlexColumnWidth(4),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(2)
      },
      children: tableRows,
    );
  }

  Widget _tableItem(String text, {Alignment align = Alignment.centerRight}) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Align(
        alignment: align,
        child: Text(text, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
