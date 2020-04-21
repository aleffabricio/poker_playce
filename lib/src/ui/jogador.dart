import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pokerplayce/src/bloc/jogador_bloc.dart';
import 'package:pokerplayce/src/ui/partida_poker.dart';

class Jogador extends StatefulWidget {
  @override
  _JogadorState createState() => _JogadorState();
}

class _JogadorState extends State<Jogador> {
  final _formKey = GlobalKey<FormState>();
  final JogadorBloc blocHome =
  BlocProvider.tag('blocHome').getBloc<JogadorBloc>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black87,
        centerTitle: true,
        title: Text(
          "Poker Playce",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Form(
        key: _formKey,
        child: StreamBuilder<bool>(
          initialData: false,
          stream: blocHome.outAutoValidate,
          builder: (context, snapshot) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    autovalidate: snapshot.data,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black87,
                      ),
                      labelText: 'Jogador playce 1',
                      labelStyle: TextStyle(color: Colors.black45)
                    ),
                    onSaved: (String value) {
                      blocHome.inNomeJogador1.add(value);
                    },
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return "Defina o nome do jogador";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: TextFormField(
                    autovalidate: snapshot.data,
                    decoration: const InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: Colors.black87,
                      ),
                      labelText: 'Jogador playce 2',
                        labelStyle: TextStyle(color: Colors.black45)
                    ),
                    onSaved: (String value) {
                      blocHome.inNomeJogador2.add(value);
                    },
                    validator: (String value) {
                      if (value == null || value.isEmpty) {
                        return "Defina o nome do jogador";
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: RaisedButton(
                    color: Colors.black87,
                    child: Container(
                        child: const Text('Iniciar Partida',
                            style: TextStyle(fontSize: 15, color: Colors.white))
                    ),
                    onPressed: () {
                      if(_formKey.currentState.validate()){
                        _formKey.currentState.save();
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (BuildContext context) => PartidaPoker()));
                      }else{
                        blocHome.inAutoValidate.add(true);
                      }
                    },
                  ),
                ),
              ],
            );
          }
        ),
      ),
    );
  }
}
