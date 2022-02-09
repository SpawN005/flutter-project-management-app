import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class rapport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 70,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back),
          ),
          title: Text('Rapport: ${user["sujet"]}')),
      body: Padding(
          padding: EdgeInsets.all(10),
          child: ListView(children: <Widget>[
            Container(
                margin: const EdgeInsets.only(top: 50.0),
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Sujet:  ${user["sujet"]}',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'CIN:  ${user["cin"]}',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Filiere:  ${user["filiere"]}',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Encadreur:  ${user["encadreur"]}',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Entreprise:  ${user["entreprise"]}',
                  style: TextStyle(fontSize: 20),
                )),
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Annee:  ${user["annee"]}',
                  style: TextStyle(fontSize: 20),
                )),
            Wrap(
              alignment: WrapAlignment.spaceAround,
              children: <Widget>[
                Container(
                  height: 90,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Expanded(
                      child: ElevatedButton(
                          onPressed: () async {
                            await deleteUser(user["id"]);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('User Deleted')),
                            );
                            Navigator.pushNamed(context, "/index");
                          },
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ), // insert your font size here
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent)),
                    ),
                  ),
                ),
                Container(
                  height: 90,
                  width: 100,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Expanded(
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "/update", arguments: {
                              "id": "${user['id']}",
                              "sujet": "${user['sujet']}",
                              "cin": "${user["cin"]}",
                              "filiere": "${user["filiere"]}",
                              "annee": "${user["annee"]}",
                              "encadreur": "${user["encadreur"]}",
                              "entreprise": "${user["entreprise"]}",
                            });
                          },
                          child: Text(
                            'Update',
                            style: TextStyle(
                              fontSize: 18.0,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent)),
                    ),
                  ),
                ),
              ],
            )
          ])),
    );
  }

  Future<http.Response> deleteUser(String id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://10.0.2.2:8585/GestionPFE/rest/rapport/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }
}
