import 'dart:ui';

import 'package:flutter/material.dart';

//função principal
void main() {
//Chamndo a função runApp e passando o parâmetro de widget.
  runApp(MaterialApp(
    home: Home(),
  ));
}

//Permitindo interação com a tela;
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
//Declarando objetos controladores para os cálculos
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();
//Estabelecendo obrigatoriedade de preenchimento das informações;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe os seus dados!";
//Criando função para resetar as informações;
  void _resetFields(){
    weightController.text = "";
    heightController.text = "";
//Resetando os resultados com o método setState;
    setState(() {
      _infoText = "Informe seus dados!";
    });

  }
//Criando a função para calcular o IMC.
void _calculate(){
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text);
      double imc = ((weight)/(height*height)*10000);
      print(imc);
      if(imc < 18.6){
        _infoText = "Você está abaixo do peso! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 18.6 && imc < 24.9){
        _infoText = "Você está com o peso ideal! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 24.9 && imc < 29.9){
        _infoText = "Você está levemente acima do peso! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 29.9 && imc < 34.9){
        _infoText = "Risco leve, Obesidade Grau I! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 34.9 && imc < 39.9){
        _infoText = "Risco moderado, Obesidade Grau II! (${imc.toStringAsPrecision(3)})";
      }else if(imc >= 40){
        _infoText = "Risco alto, Obesidade Grau III! (${imc.toStringAsPrecision(3)})";
      }

    });
}
  @override
  Widget build(BuildContext context) {
//
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC", style: TextStyle(fontSize: 27.0)),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetFields,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(Icons.person_outlined, size: 120.0, color: Colors.green),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Olá! Informe peso (Kg):",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 23.0),
//Implementando as funcionalidades do controlador do peso;
                  controller: weightController,
//Validando os formulários passando uma função anônima;
                  validator:(value){
                    if(value.isEmpty){
                      return "Por favor, insira seu peso!";
                    }
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Informe a altura (cm):",
                      labelStyle: TextStyle(color: Colors.green)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.green, fontSize: 23.0),
//Implementando as funcionalidades do controlador da altura;
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return"Por favor, insira sua altura!";
                    }
                  },
                ),
                Padding(
                    padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                    child: Container(
                      height: 60.0,
                      child: RaisedButton(
                        //Chamando a função calculate;
                        onPressed: (){
                          if(_formKey.currentState.validate()){
                            _calculate();
                          }
                        },
                        child: Text(
                          "Calcular IMC",
                          style: TextStyle(color: Colors.white, fontSize: 25.0),
                        ),
                        color: Colors.green,
                      ),
                    )),
                Text(
                  "$_infoText",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.green,
                    fontSize: 25.0,
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
