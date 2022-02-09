import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' show jsonEncode;
import 'index.dart';

class addrapport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Report'),
          toolbarHeight: 70,
        ),
        body: FormRapport());
  }
}

class FormRapport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return FormRapportState();
  }
}

class FormRapportState extends State {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController cin = TextEditingController();
    TextEditingController sujet = TextEditingController();
    TextEditingController entreprise = TextEditingController();
    TextEditingController encadreur = TextEditingController();
    TextEditingController filiere = TextEditingController();
    TextEditingController annee = TextEditingController();
    return Form(
        key: _formKey,
        child: ListView(children: <Widget>[
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
                  border: OutlineInputBorder(), labelText: 'Sujet'),
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
                  return 'Please enter 4 digits';
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
                    'Confirm',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await CreateUser(cin.text, annee.text, sujet.text,
                          encadreur.text, entreprise.text, filiere.text);
                      Navigator.pushNamed(context, "/index");
                    }
                  })),
        ]));
  }

  Future<http.Response> CreateUser(String cin, String annee, String sujet,
      String encadreur, String entreprise, String filiere) async {
    final http.Response response = await http.post(
        Uri.parse('http://10.0.2.2:8585/GestionPFE/rest/rapport'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'sujet': sujet,
          'cin': cin,
          'annee': annee,
          'encadreur': encadreur,
          'entreprise': entreprise,
          'filiere': filiere
        }));
    return response;
  }
}
