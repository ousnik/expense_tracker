import 'package:expense_tracker/home_page.dart';
import 'package:flutter/material.dart';
import 'values.dart';
import 'expense_item.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;


  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  String _validateEmail(String value) {

    if (value.isEmpty) 
      return "Enter email address";

    String p = "[a-zA-Z0-9\+\.\_\%\-\+]{1,256}" +
        "\\@" +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" +
        "(" + 
        "\\." +
        "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" +
        ")+";

    RegExp regExp = new RegExp(p);

    if (regExp.hasMatch(value)) {
      return null;
    }

    return 'Email is not valid';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expense Tracker'),
      ),
      body: Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
                key: _formKey,
                autovalidate: _autoValidate,
                child: Column(
                children: <Widget>[
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      icon: const Icon(Icons.email),
                      labelText: 'E-mail',   
                      hintText: 'Enter a email address'
                    ),
                    validator: _validateEmail,
                    autovalidate: _autoValidate,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: MaterialButton(
                      child: Text(
                        "Next",
                        style: new TextStyle(
                          color: Colors.white
                        )
                      ),
                      color: Theme.of(context).accentColor,
                      elevation: 4.0,
                      onPressed: () async {
                         final form = _formKey.currentState;
                         if (form.validate()) {
                            expenseList.clear();
                            String email = emailController.text.replaceAll('.', '-');
                            dbReference = dbReference.child(email);
                            await expenseListPopulator();
                            manageExpenseFunc();
                            Navigator.push(
                              context, 
                              MaterialPageRoute(
                                builder: (context) => MyHomePage(
                                  title: 'Expense Tracker',
                                )
                              )
                            );
                         }
                      },
                    ),
                  ),
                ],
              ),
          ),
      ),
      ),
    );
  }
}