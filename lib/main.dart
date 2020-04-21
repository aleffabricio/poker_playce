import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pokerplayce/src/bloc/cartas_bloc.dart';
import 'package:pokerplayce/src/bloc/jogador_bloc.dart';
import 'package:pokerplayce/src/bloc/partida_poker_bloc.dart';
import 'package:pokerplayce/src/ui/jogador.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(PokerPlayce());
  });
}

class PokerPlayce extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Poker Playce",
      home: (BlocProvider(
          tagText: 'blocHome',
          child: Jogador(),
          blocs: [
            Bloc((i) => JogadorBloc()),
            Bloc((i) => PartidaPokerBloc()),
            Bloc((i) => CartaBloc()),
          ]
      )),
      debugShowCheckedModeBanner: false,
    );
  }
}
