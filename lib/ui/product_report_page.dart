

import 'package:flutter/material.dart';

class ProductReportPage extends StatefulWidget {
  const ProductReportPage({super.key});

  @override
  State<ProductReportPage> createState() => _ProductReportPageState();
}

class _ProductReportPageState extends State<ProductReportPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Report"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            TextFormField(
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
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(onPressed: () {
                  debugPrint("Scanner On");
                }, icon: const Icon(Icons.qr_code_scanner)),
              ),
              onChanged: (value) {
                // _searchedCustomer = value.trim().isEmpty ? '%' : value;
                // _filteredCalled(context);
                // _customerBloc.add(CustomerFilterByNameEvent(name: value));
              },
            )
          ],
        ),
      ),
    );
  }
}
