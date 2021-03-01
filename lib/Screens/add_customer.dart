import 'package:anbu_stores_bills/Store/CustomerStore.dart';
import 'package:anbu_stores_bills/util/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class AddCustomer extends StatefulWidget {
  @override
  _AddCustomerState createState() => _AddCustomerState();
}

class _AddCustomerState extends State<AddCustomer> {
  final formKey = GlobalKey<FormState>();
  final key = GlobalKey<ScaffoldState>();

  final nameFocus = FocusNode(),
      phoneFocus = FocusNode(),
      balanceFocus = FocusNode();
  String name;
  int phone, balance;
  bool isFirst = true;
  CustomerStore customerStore;

  @override
  Widget build(BuildContext context) {
    if(isFirst){
      customerStore = Provider.of(context);
      isFirst = false;
    }
    return Scaffold(
      key: key,
      appBar: AppBar(
        title: Text("Add Customer"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: formKey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              TextFormField(
                focusNode: nameFocus,
                onSaved: (value) {
                  name = value;
                },
                validator: (value) {
                  if (value.length > 2) return null;
                  return "Enter atleast 3 characters";
                },
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  Focus.of(context).requestFocus(phoneFocus);
                },
                style: TextStyle(
                  fontSize: 15,
                ),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: "Name", border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (value) {
                  phone = int.parse(value);
                },
                validator: (value) {
                  try {
                    if (value.length == 10) {
                      int.parse(value);
                      return null;
                    } else {
                      return "Enter a valid number";
                    }
                  } catch (e) {
                    return "Enter a valid number";
                  }
                },
                focusNode: phoneFocus,
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_){
                  Focus.of(context).requestFocus(balanceFocus);
                },
                maxLength: 10,
                style: TextStyle(
                  fontSize: 15,
                ),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: false),
                decoration: InputDecoration(
                    counterText: "",
                    prefixText: "+ 91",
                    labelText: "Phone",
                    border: OutlineInputBorder()),
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                onSaved: (value) {
                  balance = int.parse(value);
                },
                focusNode: balanceFocus,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_){
                  submitForm();
                },
                validator: (value) {
                  try {
                    final val = int.parse(value);
                    if (val >= 0) {
                      return null;
                    } else
                      return "Enter a valid balance";
                  } catch (e) {
                    return "Enter a valid balance";
                  }
                },
                keyboardType: TextInputType.numberWithOptions(
                    signed: false, decimal: true),
                style: TextStyle(
                  fontSize: 15,
                ),
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: "Balance", border: OutlineInputBorder()),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: submitForm,
        label: Text("Save"),
        icon: Icon(Icons.done),
      ),
    );
  }

  void submitForm() {
    if (formKey.currentState.validate()) {
      formKey.currentState.save();
      Navigator.of(context).pop();
      customerStore.addCustomers(Utils.capitalize(name).trim(), phone, balance);

    }
  }
}
