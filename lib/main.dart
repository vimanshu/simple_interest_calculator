import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main(){
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Simple Interest Calci',
    home: SIform(),

    theme:ThemeData(
      primaryColor: Colors.tealAccent,
      accentColor: Colors.tealAccent,

    ),

  ));
}

class SIform extends StatefulWidget{


  //override create state func
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIformState();
  }
}

class _SIformState extends State<SIform>{

//  var _currencies = ['rupees', 'Dollar','Euro'];
  var dropdownValue = 'Rupees';
  var displayResult ='';
  var _formKey = GlobalKey<FormState>(); //using the super class of form state // now this _formKey will act as key for our form

  // text controller is used to control the user input in the text field.
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
          // 1st child is the image for the image, getImageAsset has been defined

            getImageAsset(),

            Padding(
               padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
                child :TextFormField(

              // in textField  numerical keypad can be popped using KeyboardType: TextInputType
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: principalController,
              //use the validator as a function and define the logic for the form validation
              validator: (String value){
                if(value.isEmpty){
                  return 'Please enter the principal amount';
                }
              },
              decoration: InputDecoration(
                labelText: 'Principal',
                hintText:'Enter the amount e.g- 12000',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                ),
                //We can also add border to the textField
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

                //errorText: 'Please input the amount'
              ),

            )),

           Padding(
               padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
               child: TextFormField(

              // in textField  numerical keypad can be popped using KeyboardType: TextInputType
              keyboardType: TextInputType.number,
              style: textStyle,
              controller: roiController,
                 validator: (String value){
                   if(value.isEmpty){
                     return 'Please enter the rate of interest';
                   }
                 },
              decoration: InputDecoration(
                labelText: 'Rate Of Interest',
                hintText:'Enter rate of interest in % ',
                labelStyle: textStyle,
                errorStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.amber,
                ),
                //errorText: 'Please input the amount'
                //adding the border to the textfield
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),

              ),

            )),

            Row(



            children: <Widget>[
                Expanded(child: TextFormField(
                  // in textField  numerical keypad can be popped using KeyboardType: TextInputType
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: termController,
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter term';
                    }
                  },
                  decoration: InputDecoration(
                    labelText: 'Term',
                    hintText:'Time In Years ',
                    labelStyle: textStyle,
                    errorStyle: TextStyle(
                      fontSize: 15,
                      color: Colors.amber,
                    ),
                    //errorText: 'Please input the amount'
                    //adding the border to the textfield
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),

                  ),

                )),

//               Expanded(child: DropdownButton<String>(
//							    items: _currencies.map((String value) {
//							    	return DropdownMenuItem<String>(
//									    value: value,
//									    child: Text(value),
//								    );
//							    }).toList(),
//
//							    value: 'Rupees',
//
//							    onChanged: (String newValueSelected) {
//							    	// Your code to execute, when a menu item is selected from dropdown
//							    },
//               )),

                    Container(width: 25.0),

                                  Expanded(child:  DropdownButton<String>(
                                        value: dropdownValue,

                                        onChanged: (String newValue) {
                                          setState(() {
                                            dropdownValue = newValue;
                                          });
                                        },
                                        items: <String>['Rupees', 'Dollar', 'Euro']
                                            .map<DropdownMenuItem<String>>((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        })
                                            .toList(),
                                      )),

                                    ],
                                  ),

            Row(

              children: <Widget>[
                Expanded(child: RaisedButton(
                  child: Text('Calculate', style: TextStyle(fontSize: 25, color: Colors.deepOrange)),

                  onPressed: (){
                        setState(() {
                          // if the validation is true in this state then the result will be displayed.
                          if(_formKey.currentState.validate()){
                          this.displayResult =_calculateTotalReturns();
                        }
                        });
                  },
                )),
                Container(width: 10.0,),
                Expanded(child: RaisedButton(
                  color: Colors.black,
                  child: Text('Reset', style: TextStyle(fontSize: 25, color: Colors.deepOrange)),
                  onPressed: (){
                            setState(() {
                              _reset();
                            });
                  },
                )),
              ],
            ),



            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(this.displayResult, style: textStyle),
            ),
                                ],
                              ),
                            ),
                          );


  }
  Widget getImageAsset(){
    AssetImage assetImage = AssetImage('/Users/vimanshu/IdeaProjects/simple_interest_calculator/assets/images/SI.png');
    Image image = Image(image: assetImage, width: 125.0, height: 125.0,);
    //wrap the image into the container an return it
    return Container(child: image,margin: EdgeInsets.all(15.0),);
  }

String _calculateTotalReturns(){
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal*roi*term)/100;

    String result ='After $term years, your investment will be worth $totalAmountPayable $dropdownValue' ;
    return result;
}

void _reset(){
    principalController.text = '';
    roiController.text = '';
    termController.text= '';
    displayResult = '';
}

}





// text controller is used to control the user input in the text field.
// eg to extract something out of the TextField



// implementing form with validation
















