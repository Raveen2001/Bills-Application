import 'package:flutter/material.dart';

class MinusDialog extends StatefulWidget {
  @override
  _MinusDialogState createState() => _MinusDialogState();
}

class _MinusDialogState extends State<MinusDialog> {


  int amount;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            color: Colors.redAccent[700],
            height: 60,
            child: Center(child: Text("Subtract Amount", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700))),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              key: formKey,
              child: TextFormField(

              // focusNode: nameFocus,
              onSaved: (value) {
                amount = int.parse(value);
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
              cursorColor: Colors.red,
              maxLines: 1,
              decoration: InputDecoration(
                  labelText: "Name",
                  labelStyle: TextStyle(color: Colors.redAccent),
                  border: OutlineInputBorder(),
                  focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent, width: 2.0),
              )),
            ),),
          ),
          SizedBox(height: 20,),
          Row(
            children: [
              Spacer(),
              FlatButton(onPressed: (){
                Navigator.pop(context);
              }, child: Text("Cancel"), textColor: Colors.red,),
              FlatButton(onPressed: (){
                if(formKey.currentState.validate()){
                  formKey.currentState.save();
                  print(amount);
                  Navigator.pop(context);
                }
              }, child: Text("Subtract"),textColor: Colors.green,)
            ],
          )
        ],
      ),
    );
  }
}
