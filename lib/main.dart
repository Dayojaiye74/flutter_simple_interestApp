import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Simple Interest Demo',
        theme: ThemeData(
            primaryColor: Colors.blue,
            accentColor: Colors.blueAccent,
            brightness: Brightness.dark),
        home: SIForm(),
      ),
    );

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIForm();
  }
}

class _SIForm extends State<SIForm> {
  var _currencies = ['Naira', 'Dollars', 'Pounds'];
  final _minimumPadding = 5.0;
  var _currencyItemSelected = ' ';

  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currencyItemSelected = _currencies[0];
  }

  var displayResultText = ' ';

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Demo'),
      ),
      body: Form(
        key: _formKey,
        child:Padding(
        padding: EdgeInsets.all(_minimumPadding * 2),
        child: ListView(
          children: <Widget>[
            myImage(),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                validator: (String value){
                  if(value.isEmpty){
                    return 'principal value required..';
                  }
                },
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: principalController,
                decoration: InputDecoration(
                    labelText: 'Principal',
                    hintText: 'Enter principal e.g 2000',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      color: Colors.amber, fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: TextFormField(
                validator: (String value){
                  if (value.isEmpty){
                    return 'Rate of interest required..';
                  }
                },
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: rateController,
                decoration: InputDecoration(
                    labelText: 'Rate of Interest',
                    hintText: 'Rate in percent',
                    errorStyle: TextStyle(
                      color: Colors.amber, fontSize: 15.0
                    ),
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        validator: (String value){
                          if(value.isEmpty){
                            return 'years required..';
                          }
                        },

                    keyboardType: TextInputType.number,
                    style: textStyle,
                    controller: termController,
                    decoration: InputDecoration(
                        labelText: 'Term',
                        hintText: 'Years e.g 2',
                        errorStyle: TextStyle(
                          color: Colors.amber, fontSize: 15.0,
                        ),
                        labelStyle: textStyle,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  )),
                  Container(width: (_minimumPadding * 5.0)),
                  Expanded(
                    child: DropdownButton<String>(
                      items: _currencies.map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      value: _currencyItemSelected,
                      onChanged: (String newItemSelected) {
                        _onDropDownItemSeleted(newItemSelected);
                      },
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: _minimumPadding, bottom: _minimumPadding),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).accentColor,
                      textColor: Theme.of(context).primaryColorDark,
                      child: Text(
                        'Calculate',
                        style: textStyle,
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        setState(() {
                          if(_formKey.currentState.validate()){
                            this.displayResultText = _calculateTotalReturn();
                          }
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Reset',
                        style: textStyle,
                        textScaleFactor: 1.2,
                      ),
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(_minimumPadding * 2),
              child: Text(this.displayResultText, style: textStyle),
            ),

          ],
        ),
      ),
    ));
  }

  Widget myImage() {
    AssetImage assetImage = AssetImage('images/man.png');
    Image image = Image(
      image: assetImage,
      width: 170.0,
      height: 170.0,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumPadding * 5),
    );
  }

  void _onDropDownItemSeleted(String newValueSelected) {
    setState(() {
      this._currencyItemSelected = newValueSelected;
    });
  }

  String _calculateTotalReturn() {
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);
    double total = principal + (principal * rate * term) / 100;

    String result = 'After $term years your investment will worth $total $_currencyItemSelected';
    return result;
  }
  void  _reset() {
  principalController.clear();
  rateController.clear();
  termController.clear();
  displayResultText = ' ';
  _currencyItemSelected = _currencies[0];
  }
}


