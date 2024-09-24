import 'package:flutter/material.dart';

class Paginausuario extends StatefulWidget {
  const Paginausuario({super.key});

  @override
  State<Paginausuario> createState() => _PaginausuarioState();
}

class _PaginausuarioState extends State<Paginausuario> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: CircleAvatar(
            radius: 56,
            backgroundColor: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset("assets/avatar.png"),
              ),
            ),
          ),
        ),
      ),
      Center(
        child: Text(
          'Usuário',
          style: TextStyle(
              fontSize: 26, color: Colors.white, fontFamily: 'Katibeh'),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            '300 seguindo',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.all(40),
      ),
      Padding(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: Text(
            'Histórico de doações',
            style: TextStyle(
                fontSize: 20, color: Colors.white, fontFamily: 'Katibeh'),
          ),
        ),
      ),
      Center(
        child: Padding(
          padding: EdgeInsets.all(3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Card(
                child: SizedBox(
                  width: 300,
                  child: Padding(
                    padding: EdgeInsets.all(2),
                    child: Column(children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(3),
                          child: Row(
                            children: [
                              Text(
                                'ONG 1',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      75, 0, 0, 0)),
                              Text(
                                '23/02',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(2),
                          child: Text("R\$ XX,##"),
                        ),
                      ),
                    ]),
                  ),
                ),
              )
            ],
          ),
        ),
      )
    ]);
  }
}
