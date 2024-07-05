import 'package:app_with_local_database/components/CustomButton.dart';
import 'package:app_with_local_database/components/CustomInputField.dart';
import 'package:app_with_local_database/components/PasswordField.dart';
import 'package:app_with_local_database/constants/constant.dart';
import 'package:app_with_local_database/db/_database.dart';
import 'package:app_with_local_database/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Projects extends StatefulWidget {
  const Projects({super.key});

  @override
  State<Projects> createState() => _ProjectsState();
}

class _ProjectsState extends State<Projects> {
  final db = DatabaseHelper();
  final Product product = Product();
  final nameCon = TextEditingController();
  final descCon = TextEditingController();
  final quantityCon = TextEditingController();
  final priceCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
      ),
      body: Column(
        children: [
          Text("Create New User"),
          Form(
              child: Column(
            children: [
              CustomInputField(
                label: "Name",
                controller: nameCon,
              ),
              CustomInputField(
                label: "Description",
                controller: descCon,
              ),
              CustomInputField(
                label: "Quantity",
                controller: quantityCon,
              ),
              CustomInputField(
                label: "Price",
                controller: priceCon,
                icon: Icons.currency_bitcoin,
              ),
              CustomButton(
                  title: "Add Product",
                  onTap: () {
                    EasyLoading.show(status: 'Saving...');
                    product.name = nameCon.text.trim();
                    product.description = descCon.text.trim();
                    product.quantity = int.parse(quantityCon.text.trim());
                    product.price = double.parse(priceCon.text.trim());

                    print(product.name);
                    db.insertProduct(product).then((value) {
                      EasyLoading.showSuccess("Product added successfully");
                      setState(() {});
                    }).onError((error, stackTrace) {
                      EasyLoading.showError(error.toString());
                    });
                  },
                  color: Colors.green),
              SizedBox(
                height: 10,
              ),
              Text("Available Users"),
              Container(
                height: 300,
                color: lightBg,
                child: StreamBuilder<List<Product>>(
                  stream: db.getProductStream(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return Center(child: Text('No users found'));
                    }

                    // Data is available, build your UI with the snapshot.data
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final product = snapshot.data![index];
                        return ListTile(
                          title: Text(product.name.toString()),
                          subtitle: Text(product.description.toString()),
                          // Add more details or customize as needed
                        );
                      },
                    );
                  },
                ),

                // child: ,
              )
            ],
          ))
        ],
      ),
    );
  }
}
