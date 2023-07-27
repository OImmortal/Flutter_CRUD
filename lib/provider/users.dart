import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_user.dart';

import '../models/user.dart';

class Users with ChangeNotifier {
  final Map<String, User> _itens = {...DUMMY_USER};

  List<User> get all {
    return [..._itens.values];
  }

  int get count {
    return _itens.length;
  }

  User ByIndex(int i) {
    return _itens.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }
    //Adicionar
    if (user.id != null &&
        user.id!.trim().isNotEmpty &&
        _itens.containsKey(user.id)) {
      _itens.update(
        user.id!,
        (_) => User(
          id: user.id,
          email: user.email,
          nome: user.nome,
          avatarUrl: user.avatarUrl,
        ),
      );
    } else {
      final id = Random().nextDouble().toString();
      if (user.id == null) {
        _itens.putIfAbsent(
          id,
          () => User(
              id: id,
              email: user.email,
              nome: user.nome,
              avatarUrl: user.avatarUrl),
        );
      }
    }

    notifyListeners();
  }

  void remove(User user) {
    if (user != null && user.id != null) {
      _itens.remove(user.id);
      notifyListeners();
    }
  }
}
