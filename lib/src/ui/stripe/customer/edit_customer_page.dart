import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stripe_sdk/stripe_sdk.dart';

final logger = Logger();

@RoutePage()
class EditCustomerPage extends StatelessWidget {
  const EditCustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Customer'),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: CustomerSession.instance.retrieveCurrentCustomer(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final map = snapshot.data!;
            logger.i(map);
            final customerData = CustomerData(
              map['id'].toString(),
              map['email'].toString(),
              map['description'].toString(),
              map['shipping']?['name'].toString(),
              map['shipping']?['phone'].toString(),
            );
            return EditCustomerForm(data: customerData);
          }
          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

class CustomerData {
  CustomerData(this.id, this.email, this.description, this.name, this.phone);
  final String? id;
  final String? email;
  final String? description;
  final String? name;
  final String? phone;
}

class EditCustomerForm extends StatelessWidget {
  const EditCustomerForm({super.key, required this.data});
  final CustomerData data;

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController(text: data.name);
    final emailController = TextEditingController(text: data.email);
    final phoneController = TextEditingController(text: data.phone);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          child: Column(
            children: <Widget>[
              TextField(
                controller: nameController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: emailController,
                readOnly: true,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              TextField(
                controller: phoneController,
                readOnly: true,
                enableInteractiveSelection: false,
                decoration: const InputDecoration(labelText: 'Phone'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
