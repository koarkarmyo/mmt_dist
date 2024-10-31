import 'package:flutter/material.dart';

class ProductReportPage extends StatefulWidget {
  const ProductReportPage({super.key});

  @override
  State<ProductReportPage> createState() => _ProductReportPageState();
}

class _ProductReportPageState extends State<ProductReportPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedValue;
  final List<String> items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];

  final List<List<String>> products = [
    ["Product1", "0 Pcs"],
    ["Product2", "12 Pcs"],
    ["Product3", "13 Pcs"],
  ];

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
                // filled: true,
                // fillColor: Colors.grey.withOpacity(0.3),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                hintText: 'Search Customer',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                    onPressed: () {
                      debugPrint("Scanner On");
                    },
                    icon: const Icon(Icons.qr_code_scanner)),
              ),
              onChanged: (value) {
                // _searchedCustomer = value.trim().isEmpty ? '%' : value;
                // _filteredCalled(context);
                // _customerBloc.add(CustomerFilterByNameEvent(name: value));
              },
            ),
            const SizedBox(
              height: 10,
            ),
            DropdownButtonFormField(
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                  labelText: "Category",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              value: _selectedValue,
              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                );
              }).toList(),
              onChanged: (value) {},
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemExtent: 80,
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        children: [
                          Icon(
                            Icons.shopping_bag_rounded,
                            size: 50,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(products[index][0]),
                              Text("Available Qty : ${products[index][1]}",style: TextStyle(color: products[index][1]=="0 Pcs" ?Colors.red :Colors.green),),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
