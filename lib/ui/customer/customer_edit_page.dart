import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmt_mobile/business%20logic/bloc/bloc_crud_process_state.dart';
import 'package:mmt_mobile/business%20logic/bloc/customer/customer_cubit.dart';
import 'package:mmt_mobile/business%20logic/bloc/login/login_bloc.dart';
import 'package:mmt_mobile/common_widget/alert_dialog.dart';
import 'package:mmt_mobile/common_widget/bottom_choice_sheet_widget.dart';
import 'package:mmt_mobile/model/res_partner.dart';
import 'package:mmt_mobile/src/extension/navigator_extension.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';
import 'package:mmt_mobile/src/extension/widget_extension.dart';
import 'package:mmt_mobile/src/mmt_application.dart';
import 'package:mmt_mobile/ui/widgets/textfield_custom_widget.dart';

import '../../common_widget/text_widget.dart';
import '../../src/const_string.dart';
import '../../src/style/app_color.dart';

class CustomerEditPage extends StatefulWidget {
  const CustomerEditPage({super.key});

  @override
  State<CustomerEditPage> createState() => _CustomerEditPageState();
}

class _CustomerEditPageState extends State<CustomerEditPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNoController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _streetController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  final ValueNotifier<XFile?> _profilePhoto = ValueNotifier(null);

  late ResPartner _customer;
  late CustomerCubit _customerCubit;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _customerCubit = context.read<CustomerCubit>();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    Map<String, dynamic>? data =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (data != null) {
      _customer = data['customer'];
      // _profilePhoto.value = _customer.image;
      _firstNameController.text = _customer.name ?? '';
      _phoneNoController.text = _customer.phone ?? '';
      _streetController.text = _customer.street ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text("Create Customer"),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<CustomerCubit, CustomerState>(
            builder: (context, state) {
              return TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Set the desired border radius
                    ),
                    backgroundColor: AppColors.successColor,
                    // Background color of the button
                    foregroundColor: Colors.white, // Text color
                  ),
                  onPressed: () {
                    if (state.state != BlocCRUDProcessState.updating) {
                      _customerCubit.updateCustomerProfile();
                    }
                  },
                  child: (state.state == BlocCRUDProcessState.updating)
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                           strokeWidth: 5,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          ConstString.save,
                          style: TextStyle(color: Colors.white),
                        ));
            },
          ),
        )
      ],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(children: [
                ValueListenableBuilder(
                  valueListenable: _profilePhoto,
                  builder: (context, value, child) {
                    return CircleAvatar(
                      radius: 70,
                      backgroundImage: (value != null)
                          ? FileImage(File(value.path))
                          : MemoryImage(
                              base64Decode(MMTApplication.defaultUserImage)),
                    );
                  },
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: IconButton(
                      style: IconButton.styleFrom(
                        backgroundColor: Colors.grey.shade100,
                      ),
                      onPressed: () async {
                        ImageSource? imageSource = await showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: TextWidget(
                                ConstString.pickImageFrom,
                                style: TextStyle(fontSize: 20),
                              ),
                              actions: [
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        context.pop(ImageSource.camera);
                                      },
                                      child: const Text("Camera")),
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: TextButton(
                                      onPressed: () {
                                        context.pop(ImageSource.gallery);
                                      },
                                      child: const Text("Gallery")),
                                )
                              ],
                            );
                          },
                        );

                        if (imageSource != null) {
                          XFile? photo = await _picker.pickImage(
                              source: imageSource, imageQuality: 10);

                          if (photo != null) {
                            _profilePhoto.value = photo;
                          }
                        }
                      },
                      icon: const Icon(Icons.edit)),
                )
              ]),
            ),
            const SizedBox(
              height: 30,
            ),
            const TextWidget("Full Name")
                .bold()
                .padding(padding: 8.verticalPadding),
            Row(
              children: [
                TextFieldCustomWidget(
                        hintText: "First Name",
                        controller: _firstNameController)
                    .expanded(),
                const SizedBox(
                  width: 8,
                ),
                TextFieldCustomWidget(
                        hintText: "Last Name", controller: _lastNameController)
                    .expanded()
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.phone)
                .bold()
                .padding(padding: 8.verticalPadding),
            TextFieldCustomWidget(controller: _phoneNoController),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.mobile)
                .bold()
                .padding(padding: 8.verticalPadding),
            TextFieldCustomWidget(controller: _mobileController),
            const SizedBox(
              height: 30,
            ),
            Divider(
              thickness: 20,
              color: Colors.grey.shade300.withOpacity(0.5),
            ),
            const SizedBox(
              height: 20,
            ),
            const TextWidget(ConstString.customerGrade)
                .bold()
                .padding(padding: 8.verticalPadding),
            _choiceWidget(
              name: "Customer Grade",
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomChoiceSheetWidget<String>(
                        itemList: const ['Royal', 'Normal', 'New'],
                        toItemString: (value) => value,
                        title: "Customer Grade");
                  },
                );
              },
            ),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.outletType)
                .bold()
                .padding(padding: 8.verticalPadding),
            _choiceWidget(name: "OutLet Type"),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.tag)
                .bold()
                .padding(padding: 4.verticalPadding),
            _choiceWidget(name: "Tag"),
            const SizedBox(
              height: 20,
            ),
            Divider(
              thickness: 20,
              color: Colors.grey.shade300.withOpacity(0.5),
            ),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.township)
                .bold()
                .padding(padding: 4.verticalPadding),
            _choiceWidget(
              name: "Township",
              onTap: () async {
                await showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return BottomChoiceSheetWidget<String>(itemList: const [
                      'Chan Mya Thar Si',
                      'Chan Aye Thar San',
                      'Mahar Aung Myay'
                    ], toItemString: (value) => value, title: "Customer Grade");
                  },
                );
              },
            ),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.ward)
                .bold()
                .padding(padding: 4.verticalPadding),
            _choiceWidget(name: "Ward"),
            const SizedBox(
              height: 4,
            ),
            const TextWidget(ConstString.street)
                .bold()
                .padding(padding: 4.verticalPadding),
            TextFieldCustomWidget(controller: _streetController),
          ],
        ).padding(padding: 16.allPadding),
      ),
    );
  }

  Widget _choiceWidget({required String name, void Function()? onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: double.infinity,
        padding: (8, 16).padding,
        margin: 8.verticalPadding,
        decoration:
            BoxDecoration(border: Border.all(), borderRadius: 8.borderRadius),
        child: Align(alignment: Alignment.centerLeft, child: Text(name)),
      ),
    );
  }
}
