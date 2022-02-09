import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class UpdateUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Update Rapport'),
          leading: null,
          toolbarHeight: 70,
        ),
        body: FormUpdate());
  }
}

class FormUpdate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormUpdateState();
  }
}

class FormUpdateState extends State {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    TextEditingController sujet =
        TextEditingController(text: "${user['sujet']}");
    TextEditingController cin = TextEditingController(text: "${user['cin']}");
    TextEditingController filiere =
        TextEditingController(text: "${user['filiere']}");
    TextEditingController annee =
        TextEditingController(text: "${user['annee']}");
    TextEditingController encadreur =
        TextEditingController(text: "${user['encadreur']}");
    TextEditingController entreprise =
        TextEditingController(text: "${user['entreprise']}");
    return Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: sujet,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Sujet',
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (int.tryParse(value) == null) {
                    return ('Please enter numbers');
                  } else if (value.length != 8) {
                    return 'Please enter 8 digits';
                  }
                  return null;
                },
                controller: cin,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'CIN'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: filiere,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Filiere'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (int.tryParse(value) == null) {
                    return ('Please enter numbers');
                  } else if (value.length != 4) {
                    return 'Please enter 4 digits ';
                  }
                  return null;
                },
                controller: annee,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Annee'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: encadreur,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Encadreur'),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                controller: entreprise,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'Entreprise'),
              ),
            ),
            Container(
                height: 80,
                padding: EdgeInsets.fromLTRB(50, 25, 50, 0),
                child: RaisedButton(
                    textColor: Colors.white,
                    color: Colors.deepPurpleAccent,
                    child: Text(
                      'Modify',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.w600),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await updateUser(
                            int.parse(user["id"]),
                            int.parse(cin.text),
                            int.parse(annee.text),
                            sujet.text,
                            filiere.text,
                            encadreur.text,
                            entreprise.text);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('User updated')),
                        );
                        Navigator.pushNamed(context, "/index");
                      }
                    })),
          ],
        ));
  }

  Future<http.Response> updateUser(int id, int cin, int annee, String sujet,
      String filiere, String encadreur, String entreprise) {
    return http.put(
      Uri.parse('http://10.0.2.2:8585/GestionPFE/rest/rapport/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'sujet': sujet,
        'cin': cin,
        'filiere': filiere,
        'annee': annee,
        'encadreur': encadreur,
        'entreprise': entreprise,
      }),
    );
  }
}
