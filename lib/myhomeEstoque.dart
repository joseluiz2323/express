import 'package:express/myHomeRelatrio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}

class _EstoquePageState extends State<EstoquePage> {
  @override
  Widget build(BuildContext context) {
    double TWO_PI = 2;
    String porcent = '10';
    var colo = Colors.red[900];
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Estoque'),
          backgroundColor: Colors.red[900],
          actions: [],
          bottom: TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'Comida', icon: Icon(Icons.fastfood)),
              Tab(text: 'Materiais', icon: Icon(Icons.content_paste_outlined)),
              Tab(text: 'BIRDS', icon: Icon(Icons.search)),
              Tab(text: 'BIRDS2', icon: Icon(Icons.search)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Container(
              child: Page1(TWO_PI, porcent, colo),
            ),
            Container(
              child: Page2(2, porcent, colo),
            ),
            Center(child: Text('BIRDS')),
            Center(child: Text('BIRDS2')),
          ],
        ),
      ),
    );
  }
}

class Page1 extends StatelessWidget {
  Page1(this.TWO_PI, this.porcent, this.colo);
  final Color colo;
  final double TWO_PI;
  final String porcent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Producao:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Comida\nComida\ncomida',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Circule(TWO_PI, porcent, colo)
                  ],
                ),
              ],
            )),
        Expanded(child: DataTableDemo())
      ],
    );
  }
}

class Page2 extends StatelessWidget {
  Page2(this.TWO_PI, this.porcent, this.colo);
  final Color colo;
  final double TWO_PI;
  final String porcent;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            width: double.infinity,
            height: 150,
            color: Colors.grey[200],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Producao:',
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          'Comida\nComida\ncomida',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    SizedBox(
                      width: 60,
                    ),
                    Circule(TWO_PI, porcent, colo)
                  ],
                ),
              ],
            )),
        Expanded(child: DataTableDemo())
      ],
    );
  }
}

class Circule extends StatelessWidget {
  Circule(this.TWO_PI, this.porcent, this.colo); /* Esse é o creator que vai receber os dados */
  final Color colo;
  final double TWO_PI;
  final String porcent;
  @override
  Widget build(BuildContext context) {
    final size = 100.0;
    return Center(
      child: Container(
        width: size,
        height: size,
        child: Stack(
          children: [
            ShaderMask(
              shaderCallback: (rect) {
                return SweepGradient(
                    startAngle: 0.0,
                    endAngle: TWO_PI,
                    stops: [0.6, 0.7],
                    // 0.0 , 0.5 , 0.5 , 1.0
                    center: Alignment.center,
                    colors: [colo, Colors.transparent]).createShader(rect);
              },
              child: Container(
                width: size,
                height: size,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              ),
            ),
            Center(
              child: Container(
                width: size - 40,
                height: size - 40,
                decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: Center(
                    child: Text(
                  "$porcent%",
                  style: TextStyle(fontSize: 25, color: colo, fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DadosComida {
  String firstName;
  String lastName;
  String nivel;
  DadosComida({this.firstName, this.lastName, this.nivel});
  static List<DadosComida> getUsers() {
    return <DadosComida>[
      DadosComida(firstName: "leite", lastName: "10/50", nivel: 'bom'),
      DadosComida(firstName: "Açúcar", lastName: "20/100", nivel: 'baixo'),
      DadosComida(firstName: "Flutter", lastName: "0/100", nivel: 'esgotado'),
    ];
  }
}

class DataTableDemo extends StatefulWidget {
  DataTableDemo() : super();

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  List<DadosComida> users;
  List<DadosComida> selectedUsers;
  bool sort;
  @override
  void initState() {
    sort = false;
    selectedUsers = [];
    users = DadosComida.getUsers();
    super.initState();
  }

  onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      if (ascending) {
        users.sort((a, b) => a.firstName.compareTo(b.firstName));
      } else {
        users.sort((a, b) => b.firstName.compareTo(a.firstName));
      }
    }
  }

  onSelectedRow(bool selected, DadosComida user) async {
    setState(() {
      if (selected) {
        selectedUsers.add(user);
      } else {
        selectedUsers.remove(user);
      }
    });
  }

  deleteSelected() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<DadosComida> temp = [];
        temp.addAll(selectedUsers);
        for (DadosComida user in temp) {
          print(selectedUsers.toSet());
          users.remove(user);
          selectedUsers.remove(user);
        }
      }
    });
  }

  SingleChildScrollView dataBody() {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
        sortAscending: sort,
        sortColumnIndex: 0,
        columns: [
          DataColumn(
              label: Text("produto"),
              numeric: false,
              tooltip: "Language",
              onSort: (columnIndex, ascending) {
                setState(() {
                  sort = !sort;
                });
                onSort(columnIndex, ascending);
              }),
          DataColumn(
            label: Text("quantidade"),
            numeric: false,
            tooltip: "Name",
          ),
          DataColumn(
            label: Text("nivel"),
            numeric: false,
            tooltip: "nivel",
          ),
        ],
        rows: users
            .map((user) => DataRow(
                    selected: selectedUsers.contains(user),
                    onSelectChanged: (b) {
                      print("Onselect");
                      onSelectedRow(b, user);
                    },
                    cells: [
                      DataCell(
                        Text(user.firstName),
                        onTap: () {
                          print('Selected ${user.firstName}');
                        },
                      ),
                      DataCell(
                        Text(user.lastName),
                      ),
                      DataCell(
                        Text(user.nivel),
                      )
                    ]))
            .toList(),
      ),
    );
  }

  String aa;
  aparece() async {
    setState(() {
      if (selectedUsers.isNotEmpty) {
        List<DadosComida> temp = [];
        temp.addAll(selectedUsers);
        for (DadosComida user in temp) {
          aa = user.firstName;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        verticalDirection: VerticalDirection.down,
        children: <Widget>[
          Expanded(
            child: dataBody(),
          ),
          /*Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('SELECTED ${selectedUsers.length}'),
                  onPressed: () {
                    aparece();
                    print(aa);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20.0),
                child: OutlineButton(
                  child: Text('DELETE SELECTED'),
                  onPressed: selectedUsers.isEmpty
                      ? null
                      : () {
                          deleteSelected();
                        },
                ),
              ),
            ],
          ),*/
        ],
      ),
      floatingActionButton: SpeedDial(
        //Speed dial menu
        icon: Icons.menu, //icon on Floating action button
        activeIcon: Icons.close, //icon when menu is expanded on button
        backgroundColor: Colors.red[900], //background color of button
        foregroundColor: Colors.black, //font color, icon color in button
        activeBackgroundColor: Colors.red[900], //background color when menu is expanded
        activeForegroundColor: Colors.black,
        buttonSize: 56.0, //button size
        visible: true,

        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: () => print('OPENING DIAL'), // action when menu opens
        onClose: () => print('DIAL CLOSED'), //action when menu closes

        elevation: 8.0, //shadow elevation of button
        shape: CircleBorder(), //shape of button

        children: [
          SpeedDialChild(
            child: Icon(Icons.picture_as_pdf_rounded),
            backgroundColor: Colors.red[900],
            foregroundColor: Colors.white,
            label: 'Gerador De PDF',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () => print('SECOND CHILD'),
            onLongPress: () => print('SECOND CHILD LONG PRESS'),
          ),
          SpeedDialChild(
            child: Icon(Icons.history),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red[900],
            label: 'Historico',
            labelStyle: TextStyle(fontSize: 18.0),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomeRelatorio()),
              );
            },
            onLongPress: () => print('THIRD CHILD LONG PRESS'),
          ),

          //add more menu item childs here
        ],
      ),

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     deleteSelected2() async {
      //       setState(() {
      //         users.add(
      //           User(firstName: "Flutter", lastName: "0/100", nivel: 'esgotado'),
      //         );
      //       });
      //     }

      //     deleteSelected2();
      //   },
      //   child: Text('PDF'),
      //   backgroundColor: Colors.red,
      //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
      // ),
    );
  }
}
