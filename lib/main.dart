import 'package:flutter/material.dart';


void main() {
  runApp(MaterialApp(
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  String _inforText = "Informe seus dados";
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  void _resetField() {

    weightController.text = "";
    heightController.text = "";

    setState(() {
      _inforText = "Informe seus dados";
       _formKey = GlobalKey<FormState>();
    });
    
  }

  void calculate() {
    double weight = double.parse(weightController.text);
    double height = double.parse(heightController.text)/100;

    double ibm = weight / (height * height);

    setState(() {
      if(ibm < 18.6){
        _inforText = "Abaixo do Peso (${ibm.toStringAsPrecision(4)})";
      } else if(ibm >= 18.6 && ibm < 24.9){
        _inforText = "Peso Ideal (${ibm.toStringAsPrecision(4)})";
      } else if(ibm >= 24.9 && ibm < 29.9){
        _inforText = "Levemente Acima do Peso (${ibm.toStringAsPrecision(4)})";
      } else if(ibm >= 29.9 && ibm < 34.9){
        _inforText = "Obesidade Grau I (${ibm.toStringAsPrecision(4)})";
      } else if(ibm >= 34.9 && ibm < 39.9){
        _inforText = "Obesidade Grau II (${ibm.toStringAsPrecision(4)})";
      } else if(ibm >= 40){
        _inforText = "Obesidade Grau III (${ibm.toStringAsPrecision(4)})";
      }
    });
   
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IBM calculator"), centerTitle: true, backgroundColor: Colors.green,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.refresh), onPressed: () {_resetField();},)
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Form(
          key: _formKey,
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Icon(Icons.person_outline, size: 120, color: Colors.green,),
          TextFormField(keyboardType: TextInputType.number, 
                    decoration: InputDecoration(labelText: "Weight (Kg)", 
                                                labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: weightController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira seu peso";
                      }
                      return null;
                    }),
          TextFormField(keyboardType: TextInputType.number, 
                    decoration: InputDecoration(labelText: "Height (cm)", 
                                                labelStyle: TextStyle(color: Colors.green)),
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green, fontSize: 25),
                    controller: heightController,
                    validator: (value){
                      if(value.isEmpty){
                        return "Insira sua altura";
                      }
                      return null;
                    }),
          Padding(padding: EdgeInsets.only(top:10, bottom: 10),
                  child: Container(height: 50,
                                   child: RaisedButton(onPressed: (){
                                                          if(_formKey.currentState.validate()){
                                                            calculate();
                                                          }
                                                       }, 
                                                       child: Text("Compute", style: TextStyle(color: Colors.white, 
                                                                                               fontSize: 25),), 
                                                       color: Colors.green,)),),
          Text(_inforText, textAlign: TextAlign.center, style: TextStyle(color: Colors.green, fontSize: 25),)
        ],),)),
    );
  }
}