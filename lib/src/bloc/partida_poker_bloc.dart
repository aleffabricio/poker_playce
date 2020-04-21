import 'dart:async';
import 'dart:math';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

enum TipoJogada {
  RoyalFlush,
  Quadra,
  FullHouse,
  Trinca,
  DoisPares,
  Par,
}

class PartidaPokerBloc implements BlocBase {

  var _jogada = BehaviorSubject<String>();

//
  Stream<String> get outJogada=> _jogada.stream;
  Sink<String> get inJogada => _jogada.sink;

  String get tipoJogada => _jogada.stream.value;


  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _jogada.close();
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

  int buscarGanhador(
      {@required List<int> cartasJogador1,
      @required List<int> cartasJogador2}) {
      int pontuacaoJogador1 = 0;
      int pontuacaoJogador2 = 0;
      pontuacaoJogador1 = validarMaoJogador(cartasJogador1);
      pontuacaoJogador2 = validarMaoJogador(cartasJogador2);

      if(pontuacaoJogador1 > pontuacaoJogador2){
        return 1;
      }else if(pontuacaoJogador2 > pontuacaoJogador1){
        return 2;
      }else{
        return 3;
      }
  }

  int validarMaoJogador(cartasJogador){
    int pontuacao = 0;
    if(isRoyalFlush(cartasJogador)){
      inJogada.add("RoyalFlush");
      pontuacao = 7;
    }
    if(isQuadra(cartasJogador)){
      inJogada.add("Quadra");
      pontuacao = 6;
    }
    if(isFullHouse(cartasJogador)){
      inJogada.add("FullHouse");
      pontuacao = 5;
    }
    if(isTrinca(cartasJogador)){
      inJogada.add("Trinca");
      pontuacao = 4;
    }
    if(isDoisPares(cartasJogador)){
      inJogada.add("DoisPares");
      pontuacao = 3;
    }
    if(isPar(cartasJogador)){
      inJogada.add("Par");
      pontuacao = 2;
    }
    return pontuacao == 0 ? 1 : pontuacao;
  }

  bool isRoyalFlush(@required List<int> cartasJogador){
    bool isdez = cartasJogador.contains(8);
    bool isValete = cartasJogador.contains(9);
    bool isDama = cartasJogador.contains(10);
    bool isRei = cartasJogador.contains(11);
    bool as = cartasJogador.contains(12);
    return isdez && isValete && isDama &&  isRei && as ? true : false;
  }

  isQuadra(@required List<int> cartasJogador){
    int qtdCarta = 0;
    bool isQuadra = false;
    cartasJogador.forEach((numeroCarta) {
      cartasJogador.forEach((carta) {
          if(numeroCarta == carta){
            qtdCarta++;
          }
      });
      if(qtdCarta == 4){
        isQuadra = true;
      }
      qtdCarta = 0;
    });
   return isQuadra;
  }

  isFullHouse(@required List<int> cartasJogador){

    int qtdCarta = 0;
    bool isTrinca = false;
    bool cartaDupla = false;
    cartasJogador.forEach((numeroCarta) {
      cartasJogador.forEach((carta) {
        if(numeroCarta == carta){
          qtdCarta++;
        }
      });
      if(qtdCarta == 3){
        isTrinca = true;
      }else if(qtdCarta != 2){
        cartaDupla = true;
      }
      qtdCarta = 0;
    });

    return isTrinca && !cartaDupla ? true : false;
  }


  isTrinca(@required List<int> cartasJogador){

    int qtdCarta = 0;
    bool isTrinca = false;
    bool cartaDupla = false;
    cartasJogador.forEach((numeroCarta) {
      cartasJogador.forEach((carta) {
        if(numeroCarta == carta){
          qtdCarta++;
        }
      });
      if(qtdCarta == 3){
        isTrinca = true;
      }else if(qtdCarta == 2){
        cartaDupla = true;
      }
      qtdCarta = 0;
    });
    return isTrinca && !cartaDupla ? true : false;
  }

  isDoisPares(@required List<int> cartasJogador){
    int qtdCarta = 0;
    int qtdPar = 0;
    bool isPar = false;
    cartasJogador.forEach((numeroCarta) {
      cartasJogador.forEach((carta) {
        if(numeroCarta == carta){
          qtdCarta++;
        }
      });
      if(qtdCarta == 2){
        isPar = true;
        qtdPar++;
      }
      qtdCarta = 0;
    });
    return isPar && qtdPar == 4  ? true : false;
  }

  isPar(@required List<int> cartasJogador){
    int qtdCarta = 0;
    int qtdPar = 0;
    bool isPar = false;
    cartasJogador.forEach((numeroCarta) {
      cartasJogador.forEach((carta) {
        if(numeroCarta == carta){
          qtdCarta++;
        }
      });
      if(qtdCarta == 2){
          isPar = true;
          qtdPar++;
      }
      qtdCarta = 0;
    });
    return isPar && qtdPar == 2  ? true : false;
  }

}
