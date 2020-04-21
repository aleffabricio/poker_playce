import 'dart:async';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CartaBloc implements BlocBase {
  var _cartas1Bloc = BehaviorSubject<List<String>>();
  var _cartas2loc = BehaviorSubject<List<String>>();

  var _numerosCarta1Bloc = BehaviorSubject<List<int>>();
  var _numerosCarta2Bloc = BehaviorSubject<List<int>>();



  Map<int, String> jogada = Map<int, String>();

  Stream<List<String>> get outCartasJogador1 => _cartas1Bloc.stream;
  Sink<List<String>> get inCartasJogador1 => _cartas1Bloc.sink;
  List<String> get cartasJogador1 => _cartas1Bloc.stream.value;

  Stream<List<String>> get outCartasJogador2 => _cartas2loc.stream;
  Sink<List<String>> get inCartasJogador2 => _cartas2loc.sink;
  List<String> get cartasJogador2 => _cartas2loc.stream.value;

  Stream<List<int>> get outNumerosCarta1 => _numerosCarta1Bloc.stream;
  Sink<List<int>> get inNumerosCarta1 => _numerosCarta1Bloc.sink;
  List<int> get numerosJogador1 => _numerosCarta1Bloc.stream.value;

  Stream<List<int>> get outNumerosCarta2 => _numerosCarta2Bloc.stream;
  Sink<List<int>> get inNumerosCarta2 => _numerosCarta2Bloc.sink;
  List<int> get numerosJogador2 => _numerosCarta2Bloc.stream.value;

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _cartas1Bloc.close();
    _cartas2loc.close();
    _numerosCarta1Bloc.close();
    _numerosCarta2Bloc.close();
  }

  @override
  // TODO: implement hasListeners
  bool get hasListeners => null;

  @override
  void notifyListeners() {
    // TODO: implement notifyListeners
  }

  @override
  void removeListener(listener) {
    // TODO: implement removeListener
  }

  gerarCartasJogador() {
    Random rng = Random();
    List<int> listJogador1 = List<int>();
    List<int> listJogador2 = List<int>();

    List<String> cartasJogador1 = List<String>();
    List<String> cartasJogador2 = List<String>();

    for (var i = 0; i < 10; i++) {
      if (i < 5) {
        listJogador1.add(rng.nextInt(13));
      } else {
        listJogador2.add(rng.nextInt(13));
      }
    }

    listJogador1.forEach((cartaJogador1) {
      cartasJogador1.add(vincularCartaJogador(numeroCarta: cartaJogador1));
    });
    inCartasJogador1.add(cartasJogador1);


    listJogador2.forEach((cartaJogador2) {
      cartasJogador2.add(vincularCartaJogador(numeroCarta: cartaJogador2));
    });
    inCartasJogador2.add(cartasJogador2);

    inNumerosCarta1.add(listJogador1);
    inNumerosCarta2.add(listJogador2);
  }

  String vincularCartaJogador({@required int numeroCarta}) {
    switch (numeroCarta) {
      case 0:
        return "assets/images/dois.jpg";
      case 1:
        return "assets/images/tres.jpg";
      case 2:
        return "assets/images/quatro.jpg";
      case 3:
        return "assets/images/cinco.jpg";
      case 4:
        return "assets/images/seis.png";
      case 5:
        return "assets/images/sete.png";
      case 6:
        return "assets/images/oito.png";
      case 7:
        return "assets/images/nove.png";
      case 8:
        return "assets/images/dez.png";
      case 9:
        return "assets/images/valete.jpg";
      case 10:
        return "assets/images/dama.jpg";
      case 11:
        return "assets/images/rei.png";
      case 12:
        return "assets/images/as.png";
    }
  }
}
