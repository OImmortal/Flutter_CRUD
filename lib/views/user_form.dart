import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crud/models/user.dart';
import 'package:flutter_crud/routes/app_routes.dart';
import 'package:provider/provider.dart';

import '../provider/users.dart';

class UserForm extends StatelessWidget {
  final _form = GlobalKey<FormState>();
  final Map<String, String> _formData = {};

  UserForm({Key? key}) : super(key: key);

  void _loadFormData(User user) {
    _formData['id'] = user.id!;
    _formData['email'] = user.email;
    _formData['nome'] = user.nome;
    if (user.avatarUrl == null) {
      _formData['avatarURL'] = '';
    } else {
      _formData['avatarURL'] = user.avatarUrl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;

    // Check if the arguments are of type User
    if (arguments is User) {
      _loadFormData(arguments);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Formulário de usuário"),
        actions: [
          IconButton(
            onPressed: () {
              final isValid = _form.currentState!.validate();
              if (isValid) {
                _form.currentState!.save();

                Provider.of<Users>(context, listen: false).put(
                  User(
                    id: _formData['id'],
                    email: _formData['email']!,
                    nome: _formData['nome']!,
                    avatarUrl: _formData['avatarURL'],
                  ),
                );
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _form,
          child: Column(
            children: [
              TextFormField(
                initialValue: _formData['nome'],
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Informe um nome";
                  }

                  if (value.trim().length < 3) {
                    return "Muito curto, informe um nome maior";
                  }
                },
                onSaved: (value) => _formData['nome'] = value!,
              ),
              TextFormField(
                initialValue: _formData['email'],
                decoration: InputDecoration(labelText: "E-mail"),
                onSaved: (value) => _formData['email'] = value!,
              ),
              TextFormField(
                initialValue: _formData['avatarURL'],
                decoration: InputDecoration(labelText: "URL do Avatar"),
                onSaved: (value) => _formData['avatarURL'] = value!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
