import 'package:flutter/material.dart';

class AddDialog extends StatefulWidget {
  @override
  _AddDialogState createState() => _AddDialogState();
}

class _AddDialogState extends State<AddDialog> {


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
            color: Theme.of(context).primaryColor,
            height: 60,
            child: Center(child: Text("Add Amount", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w700))),
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
                cursorColor: Theme.of(context).primaryColor,
                maxLines: 1,
                decoration: InputDecoration(
                    labelText: "Name",
                    labelStyle: TextStyle(color: Theme.of(context).primaryColor),
                    border: OutlineInputBorder(),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2.0),
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
              }, child: Text("Add"),textColor: Colors.green,)
            ],
          )
        ],
      ),
    );
  }
}
