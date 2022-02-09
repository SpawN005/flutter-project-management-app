import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class index extends StatefulWidget {
  @override
  indexState createState() => indexState();
}

class indexState extends State<index> {
  late Future<List<User>> users;
  String searchString = "";
  @override
  void initState() {
    super.initState();
    this.setState(() {
      users = fetchUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rapports'),
        toolbarHeight: 70,
        leading: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/");
          },
          child: Icon(Icons.home),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.pushNamed(context, "/addUser");
        },
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchString = value.toLowerCase();
                });
              },
              decoration: InputDecoration(
                  labelText: 'Search', suffixIcon: Icon(Icons.search)),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<User>> snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: ListView.separated(
                      padding: const EdgeInsets.all(8),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return snapshot.data![index].sujet
                                .toLowerCase()
                                .contains(searchString)
                            ? ListTile(
                                onTap: () {
                                  Navigator.pushNamed(context, "/rapport",
                                      arguments: {
                                        "id": "${snapshot.data?[index].id}",
                                        "cin": "${snapshot.data?[index].cin}",
                                        "sujet":
                                            "${snapshot.data?[index].sujet}",
                                        "encadreur":
                                            "${snapshot.data?[index].encadreur}",
                                        "entreprise":
                                            "${snapshot.data?[index].entreprise}",
                                        "filiere":
                                            "${snapshot.data?[index].filiere}",
                                        "annee":
                                            "${snapshot.data?[index].annee}",
                                      });
                                },
                                leading: Icon(Icons.person),
                                title: Text('${snapshot.data?[index].sujet}'),
                                subtitle:
                                    Text('CIN: ${snapshot.data?[index].cin}'),
                              )
                            : Container();
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return snapshot.data![index].sujet
                                .toLowerCase()
                                .contains(searchString)
                            ? Divider()
                            : Container();
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text('Something went wrong :('));
                }
                return CircularProgressIndicator();
              },
              future: users,
            ),
          ),
        ],
      ),
    );
  }

  Future<List<User>> fetchUsers() async {
    final response = await http
        .get(Uri.parse('http://10.0.2.2:8585/GestionPFE/rest/rapport'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((user) => User.fromJson(user)).toList();
    } else {
      throw Exception('Failed to load shows');
    }
  }
}

class User {
  final int id;
  final int cin;
  final int annee;
  final String encadreur;
  final String entreprise;
  final String sujet;
  final String filiere;

  User({
    required this.id,
    required this.cin,
    required this.annee,
    required this.entreprise,
    required this.encadreur,
    required this.sujet,
    required this.filiere,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        annee: json['annee'],
        cin: json['cin'],
        encadreur: json['encadreur'],
        entreprise: json['entreprise'],
        sujet: json['sujet'],
        filiere: json['filiere']);
  }
}
