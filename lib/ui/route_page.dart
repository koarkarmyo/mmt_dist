import 'package:flutter/material.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/route/route_list.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/ui/widgets/cust_mini_dialog.dart';
import 'package:mmt_mobile/ui/widgets/customer_filter_widget.dart';
import 'package:mmt_mobile/ui/widgets/date_picker_button.dart';
import 'package:mmt_mobile/ui/widgets/responsive.dart';

import '../model/partner.dart';
import '../model/tag.dart';
import '../on_clicked_listener.dart';
import '../src/const_dimen.dart';
import '../src/enum.dart';
import '../utils/date_time_utils.dart';

class RoutePage extends StatefulWidget {
  const RoutePage({super.key});

  @override
  State<RoutePage> createState() => _RoutePageState();
}

class _RoutePageState extends State<RoutePage> {
  // late CustomerBloc _customerBloc;
  // CustomerViewTypes viewType = CustomerViewTypes.list;
  // late GlobalKey<RouteListWidgetState> _routeListKey = GlobalKey();
  // late GlobalKey<CustomerVisitFilterWidgetState> _customerFilterKey =
  //     GlobalKey<CustomerVisitFilterWidgetState>();

  // late String _title = ConstantStrings.customer;
  late Icon customIcon = const Icon(Icons.search);
  late bool canReturnData = false;

  // late String _searchedCustomer = '%';
  late CustomerFilterType _customerFilterType = CustomerFilterType.MISSED;

  // late String _selectedCustType = '%';
  // late int _selectedRouteId = 0;

  // late String _selectedRouteId = '%';
  // late String _selectedRouteName = "Today Route";
  late final TextEditingController _searchController = TextEditingController();

  // late CustVisitBloc _custVisitBloc;
  // late RouteBloc _routeBloc;
  // late LocationData? position;
  // late List<Partner> _customerList = [];
  int length = 2;
  DateTime _selectedDate = DateTime.now();
  int counter = 1;


  Partner selectedCustomer = Partner(
    id: 1,
    name: "John Doe",
    name2: "JD Enterprises",
    customerRank: 5,
    street: "123 Main St",
    street2: "Suite 101",
    city: "Metropolis",
    stateId: 23,
    zip: "54321",
    phone: "+1234567890",
    mobile: "+0987654321",
    email: "john.doe@example.com",
    image512: "https://example.com/image.png",
    partnerLatitude: 40.7128,
    partnerLongitude: -74.0060,
    writeDate: "2024-10-29T12:34:56",
    stateName: "New York",
    pricelistName: "Standard",
    pricelistId: 101,
    wardId: 5,
    wardName: "Downtown",
    townshipId: 3,
    townshipName: "Old Town",
    partnerGradeId: 2,
    outletTypeId: 4,
    partnerState: PartnerState.Regular,
    categoryIds: [
      Tag(id: 1, name: "VIP"),
      Tag(id: 2, name: "Frequent Buyer"),
    ],
    supplierRank: 3,
    isVisited: true,
    number: 456789,
    reasonCode: "N/A",
    lastSaleOrder: 1001,
    lastSaleOrderName: "SO1001",
    lastSaleAmount: 2500.75,
    lastSaleOrderDate: "2024-09-25",
    lastSaleCurrencyId: 840,
    lastSaleCurrencyName: "USD",
    totalOrdered: 10,
    totalDue: 10.00,
    totalInvoiced: 100.00,
    saleOrderCount: 25,
    invoiceCount: 20,
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
            height: 60,
            alignment: Alignment.center,
            child: TextFormField(
              controller: _searchController,
              autofocus: false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search Customer',
                prefixIcon: const BackButton(color: Colors.black),
              ),
              onChanged: (value) {
                // _searchedCustomer = value.trim().isEmpty ? '%' : value;
                // _filteredCalled(context);
                // _customerBloc.add(CustomerFilterByNameEvent(name: value));
              },
            )),
        actions: [
          _showCustomerFilter(),
        ],
        bottom: DatePickerPreferredSizeWidget(
            context: context,
            onChange: (DateTime value) {
              _selectedDate = value;
              _filteredCalled(context);
            },
            initDate: DateTime.now()),
      ),
      floatingActionButton:
          // BlocListener<CustVisitBloc, CustVisitState>(
          //   listener: (context, state) {
          //     // cust visit send success or fail close dialog
          //     if (state.state == BlocCRUDProcessState.fetchFail ||
          //         state.state == BlocCRUDProcessState.fetchSuccess)
          //       Navigator.pop(context);
          //     // fetch background service
          //     BackgroundServiceUtils.startLocationFetchProcess();
          //   },
          //   child: viewType == ViewTypes.list
          //       ?
          FloatingActionButton(
            backgroundColor: Colors.white,
        onPressed: () {
          // Navigator.pushNamed(context, RouteList.customerCreateRoute)
          //     .then((value) {
          //   if (value != null) {
          //     _filteredCalled(context);
          //   }
          // }
          // );
          // Navigator.pushNamed(context, RouteList.custVisitReportRoute);
        },
        child: const Icon(Icons.person_add_alt_1_outlined),
      ),
      // : Container(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GridView.builder(
                itemCount: 10, // Replace with your desired item count
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  childAspectRatio: 4 / 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            icon: const Icon(
                              Icons.account_box_rounded,
                              size: 80,
                            ),
                            title: const Text(
                              "Clock In",
                              style: TextStyle(fontSize: 24),
                            ),
                            content: const Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "Are you sure to clock in?",
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Icon(
                                  Icons.camera_alt_outlined,
                                  size: 80,
                                )
                              ],
                            ),
                            actions: [
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigator.of(context)
                                    //     .pop(); // Close the dialog
                                    // Navigator.push(
                                    //   context,
                                    //   MaterialPageRoute(
                                    //     builder: (context) => NextPage(), // Replace with your next page
                                    //   ),
                                    // );

                                    Navigator.pushNamed(context, RouteList.customerDashboardPage);
                                  },
                                  child: const Text("Clock In"),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: Card(
                      shadowColor: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10.0,vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                _customerInfo(context,selectedCust: selectedCustomer);
                              },
                              child: Container(
                                height: 140,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.grey,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  size: 90,
                                ),
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 12.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Wai Lin Naing",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("09-777789648",
                                      style: TextStyle(fontSize: 14)),
                                  Text("location",
                                      style: TextStyle(fontSize: 14)),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Last Order : Can't Define",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightBlueAccent)),
                                  Text("Last Order Amount: 0",
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.lightBlueAccent)),
                                  Text("Amount Due: 0",
                                      style: TextStyle(
                                          fontSize: 14, color: Colors.red)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: const Text(
        "Total Count : 1444",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  void _filteredCalled(BuildContext context) {
    final date = DateTimeUtils.yMmDd.format(_selectedDate);
    // _customerBloc.add(CustomerFilterByRouteEvent(
    //     searchName: _searchedCustomer,
    //     customerTypeId: _customerFilterType,
    //     date: date));
    // Navigator.pop(context);
  }

  _showCustomerFilter() {
    return Padding(
      padding: const EdgeInsets.only(
        right: 15.0,
      ),
      child: PopupMenuButton(
          icon: const Icon(
            Icons.filter_list,
            color: Colors.black,
            size: 30,
          ),
          offset: const Offset(0, 56),
          itemBuilder: (context) {
            return [
              PopupMenuItem(
                padding: const EdgeInsets.all(0.0),
                child: RadioListTile<CustomerFilterType>(
                  title: const Text('Visited customer'),
                  value: CustomerFilterType.VISITED,
                  groupValue: _customerFilterType,
                  onChanged: (type) {
                    _customerFilterType = type!;
                    Navigator.pop(context);
                    _filteredCalled(context);
                  },
                ),
              ),
              PopupMenuItem(
                onTap: () {},
                padding: const EdgeInsets.all(0.0),
                child: RadioListTile<CustomerFilterType>(
                  title: const Text('Missed customer'),
                  value: CustomerFilterType.MISSED,
                  groupValue: _customerFilterType,
                  onChanged: (type) {
                    _customerFilterType = type!;
                    Navigator.pop(context);
                    _filteredCalled(context);
                  },
                ),
              ),
              PopupMenuItem(
                onTap: () {},
                padding: const EdgeInsets.all(0.0),
                child: RadioListTile<CustomerFilterType>(
                  title: const Text('Plan customer'),
                  value: CustomerFilterType.PLAN,
                  groupValue: _customerFilterType,
                  onChanged: (type) {
                    _customerFilterType = type!;
                    Navigator.pop(context);
                    _filteredCalled(context);
                  },
                ),
              ),
              PopupMenuItem(
                onTap: () {},
                padding: const EdgeInsets.all(0.0),
                child: RadioListTile<CustomerFilterType>(
                  title: const Text('All'),
                  value: CustomerFilterType.ALL,
                  groupValue: _customerFilterType,
                  onChanged: (type) {
                    _customerFilterType = type!;
                    Navigator.pop(context);
                    _filteredCalled(context);
                  },
                ),
              ),
            ];
          }),
    );
  }

// Widget _createCustomerList() {
//   return StatefulBuilder(builder: (context, innerState) {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 IconButton(
//                     onPressed: () {
//                       // viewType = CustomerViewTypes.list;
//                       innerState(() {});
//                     },
//                     icon: Icon(Icons.list)),
//                 // IconButton(
//                 //     onPressed: () {
//                 //       viewType = CustomerViewTypes.grid;
//                 //       innerState(() {});
//                 //     },
//                 //     icon: Icon(Icons.grid_view_sharp)),
//                 IconButton(
//                     onPressed: () {
//                       // viewType = CustomerViewTypes.map;
//                       innerState(() {});
//                     },
//                     icon: Icon(Icons.map))
//               ],
//             ),
//             Expanded(
//               child: CustomerListWidget(
//                 viewType: viewType,
//                 callBack: (value) {
//                   if (value) {
//                     _filteredCalled(context);
//                   }
//                 },
//                 onClickCallBack: (customer) async {
//                   if (canReturnData) {
//                     Navigator.pop(context, customer.toJson());
//                   } else {
//                     showCircularProgressLabelDialog(
//                         context: context, label: 'Getting Location...');
//                     position = await LocationUtils.getCurrentLocation();
//                     // position = LocationUtils.locationData;
//                     // position = await LocationUtils.determineCurrentLocation();
//                     // position = await LocationUtils.determinePosition();
//                     Navigator.pop(context);
//                     MMTApplication.currentSelectedCustomer = customer;
//                     FocusScope.of(context).unfocus();
//                     await showDialog(
//                       context: context,
//                       builder: (context) => ClocKInOutDialog(
//                         avatarImage: customer.image512.toString(),
//                         descriptions: 'Are you sure to clock in?',
//                         dialogType: ClockDialogType.ClockIn,
//                         btnText: 'Clock in',
//                         callBack: (imageUint, reason) async {
//                           MMTApplication.currentSelectedCustomer = customer;
//                           LoginResponse loginResponse =
//                           MMTApplication.loginResponse!;
//                           CustVisit custVisit = CustVisit(
//                               customerId: customer.id!,
//                               customerName: customer.name,
//                               docDate: DateTimeUtils.yMmDdHMS
//                                   .format(DateTime.now()),
//                               docType: CustVisitTypes.clock_in,
//                               employeeId: loginResponse.id!,
//                               remarks: reason,
//                               // vehicleId: loginResponse.deviceId!.vehicleId!.id!,
//                               vehicleId: loginResponse.currentLocationId,
//                               deviceId: loginResponse.deviceId!.id!,
//                               latitude: position?.latitude ?? 0.0,
//                               photo: imageUint == null
//                                   ? ''
//                                   : base64Encode(imageUint),
//                               longitude: position?.longitude ?? 0.0,
//                               isUpload: 0);
//                           bool b = false;
//                           if (customer.partnerState != PartnerState.New)
//                             b = await DataObject.instance
//                                 .insertCustVisit(custVisit);
//                           if (b) {
//                             //Fetch Stock Quant
//                             StockQuantApiRepo().fetchStockQuant();
//
//                             // Navigator.pushNamed(
//                             //     context, RouteList.customerDashboardRoute)
//                             //     .whenComplete(() {
//                             //   _filteredCalled(context);
//                               Navigator.pop(context);
//                               // _sendCustVisitProcess(context);
//                             });
//                           } else {
//                             Navigator.pop(context);
//                             SnackBar snackBar = SnackBar(
//                               content: Text(
//                                 "Can't clock in! You are new partner",
//                                 style: TextStyle(color: Colors.white),
//                               ),
//                               duration: Duration(seconds: 1),
//                               backgroundColor: Colors.red,
//                             );
//                             _showSnackBar(snackBar);
//                           }
//                         },
//                       ),
//                     );
//                   }
//                 },
//               ),
//             ),
//           ],
//         ),
//         if (viewType == CustomerViewTypes.list)
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: const EdgeInsets.all(ConstantDimens.pagePadding),
//               child: BlocListener<CustVisitBloc, CustVisitState>(
//                 listener: (context, state) {
//                   // cust visit send success or fail close dialog
//                   if (state.state == BlocCRUDProcessState.fetchFail ||
//                       state.state == BlocCRUDProcessState.fetchSuccess)
//                     Navigator.pop(context);
//                   // fetch background service
//                   BackgroundServiceUtils.startLocationFetchProcess();
//                 },
//                 child: FloatingActionButton(
//                   onPressed: () {
//                     Navigator.pushNamed(
//                         context, RouteList.customerCreateRoute)
//                         .then((value) {
//                       if (value != null) {
//                         _filteredCalled(context);
//                       }
//                     });
//                     // Navigator.pushNamed(context, RouteList.custVisitReportRoute);
//                   },
//                   child: Icon(Icons.person_add_alt_1_outlined),
//                 ),
//               ),
//             ),
//           )
//       ],
//     );
//   });

  _customerInfo(BuildContext context,
      {required Partner selectedCust,
        OnClickCallBack<bool>? callback}) async {
    bool? success = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustDialog.createDialog(context, selectedCustomer);
        });
    if (success ?? false) {
      if (callback != null) callback(success!);
    }
  }
}

class DatePickerPreferredSizeWidget extends StatefulWidget
    implements PreferredSizeWidget {
  final DateTime initDate;
  final ValueChanged<DateTime> onChange;
  final BuildContext context;

  const DatePickerPreferredSizeWidget(
      {super.key,
      required this.initDate,
      required this.onChange,
      required this.context});

  @override
  State<DatePickerPreferredSizeWidget> createState() =>
      _DatePickerPreferredSizeWidgetState();

  @override
  Size get preferredSize =>
      Size(Responsive.currentWidth(context), ConstantDimens.listDefaultHeight);
}

class _DatePickerPreferredSizeWidgetState
    extends State<DatePickerPreferredSizeWidget> {
  final GlobalKey<DatePickerBtnState> _datePickerKey =
      GlobalKey<DatePickerBtnState>();
  DateTime _currentDate = DateTime.now();

  @override
  void initState() {
    _currentDate = widget.initDate;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConstantDimens.listDefaultHeight,
      alignment: Alignment.center,
      padding:
          const EdgeInsets.symmetric(vertical: ConstantDimens.normalPadding),
      child: Row(
        children: [
          IconButton(
              onPressed: () => _onChange(false),
              icon: const Icon(Icons.arrow_back_ios_sharp)),
          Expanded(
            child: DatePickerBtn(
                key: _datePickerKey,
                onChange: widget.onChange,
                defaultDate: widget.initDate),
          ),
          IconButton(
              onPressed: () => _onChange(true),
              icon: const Icon(Icons.arrow_forward_ios_sharp)),
        ],
      ),
    );
  }

  void _onChange(bool isPlus) {
    if (isPlus) {
      _currentDate = _currentDate.add(const Duration(days: 1));
    } else {
      _currentDate = _currentDate.add(const Duration(days: -1));
    }
    _datePickerKey.currentState?.setDate(_currentDate);
    widget.onChange.call(_currentDate);
  }
}
