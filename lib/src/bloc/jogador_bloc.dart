import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/rxdart.dart';


class JogadorBloc implements BlocBase {

  bool autoValidadte = false;


  var _autoValidateBloc = BehaviorSubject<bool>();
  var _jogador1Bloc = BehaviorSubject<String>();
  var _jogador2Bloc = BehaviorSubject<String>();

  Stream<bool> get outAutoValidate => _autoValidateBloc.stream;
  Sink<bool> get inAutoValidate => _autoValidateBloc.sink;
  String get nomeJogador1 => _jogador1Bloc.stream.value;

  Stream<String> get outNomeJogador1 => _jogador1Bloc.stream;
  Sink<String> get inNomeJogador1 => _jogador1Bloc.sink;

  Stream<String> get outNomeJogador2 => _jogador2Bloc.stream;
  Sink<String> get inNomeJogador2 => _jogador2Bloc.sink;
  String get nomeJogador2 => _jogador2Bloc.stream.value;

  @override
  void addListener(listener) {
    // TODO: implement addListener
  }

  @override
  void dispose() {
    _autoValidateBloc.close();
    _jogador1Bloc.close();
    _jogador2Bloc.close();
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

}
