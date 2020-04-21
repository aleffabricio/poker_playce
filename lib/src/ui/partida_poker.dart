import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:pokerplayce/src/bloc/cartas_bloc.dart';
import 'package:pokerplayce/src/bloc/jogador_bloc.dart';
import 'package:pokerplayce/src/bloc/partida_poker_bloc.dart';

class PartidaPoker extends StatefulWidget {
  @override
  _PartidaPokerState createState() => _PartidaPokerState();
}

class _PartidaPokerState extends State<PartidaPoker> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final JogadorBloc blocHome =
  BlocProvider.tag('blocHome').getBloc<JogadorBloc>();
  final CartaBloc blocCartas =
  BlocProvider.tag('blocHome').getBloc<CartaBloc>();
  final PartidaPokerBloc blocPartida =
  BlocProvider.tag('blocHome').getBloc<PartidaPokerBloc>();
  String nomeJogador1 = '';
  String nomeJogador2 = '';


  @override
  void initState() {
    blocCartas.gerarCartasJogador();
    nomeJogador1 = blocHome.nomeJogador1;
    nomeJogador2 = blocHome.nomeJogador2;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          centerTitle: true,
          title: Text(
            "Que vença o melhor :)",
            style: TextStyle(color: Colors.white, ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Card(
                color: Colors.grey.shade100,
                elevation: 8,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.45,
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                          initialData: "",
                          stream: blocHome.outNomeJogador1,
                          builder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                snapshot.data,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 20),
                              ),
                            );
                          }),
                      Expanded(
                        child: StreamBuilder<List<String>>(
                            initialData: [],
                            stream: blocCartas.outCartasJogador1,
                            builder: (context, snapshot) {
                              return GridView.builder(
                                itemCount: snapshot.data.length,
                                scrollDirection: Axis.vertical,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 3),
                                itemBuilder: (BuildContext context, int index) {
                                  return Card(
                                      elevation: 8,
                                      child: Container(
                                        child: Image(
                                            image: AssetImage(
                                                snapshot.data[index])),
                                      ));
                                },
                              );
                            }),
                      )
                    ],
                  ),
                ),
              ),
              Card(
                color: Colors.grey.shade100,
                elevation: 8,
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height * 0.45,
                  child: Column(
                    children: <Widget>[
                      StreamBuilder<String>(
                          initialData: "",
                          stream: blocHome.outNomeJogador2,
                          builder: (context, snapshot) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(snapshot.data,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20)),
                            );
                          }),
                      Expanded(
                        child: Container(
                          child: StreamBuilder<List<String>>(
                              initialData: [],
                              stream: blocCartas.outCartasJogador2,
                              builder: (context, snapshot) {
                                return GridView.builder(
                                  itemCount: snapshot.data.length,
                                  scrollDirection: Axis.vertical,
                                  gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3),
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Card(
                                      elevation: 8,
                                      child: Container(
                                        child: Image(
                                            image: AssetImage(
                                                snapshot.data[index])),
                                      ),
                                    );
                                  },
                                );
                              }),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                height: 100,
              )
            ],
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            elevation: 0.0,
            icon: Icon(Icons.sentiment_very_satisfied),
            label: Text("Toque e descubra quem ganhou !!"),
            backgroundColor: Colors.black87,
            onPressed: () {
              int ganhador = 0;
              ganhador = blocPartida.buscarGanhador(
                  cartasJogador1: blocCartas.numerosJogador1,
                  cartasJogador2: blocCartas.numerosJogador2);

              final snackBar = SnackBar(backgroundColor: ganhador == 1 || ganhador == 2 ? Colors.green : Colors.red,
                  content: ganhador == 1 || ganhador == 2 ? Text(
                      'Parabéns ao jogador ${ganhador == 1
                          ? nomeJogador1
                          : nomeJogador2}, você fez um ${blocPartida
                          .tipoJogada} !!') : Text('Ops, Ocorreu um empate :('));
              _scaffoldKey.currentState.showSnackBar(snackBar);
            }));
  }
}

