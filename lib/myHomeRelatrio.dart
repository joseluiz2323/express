import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';

class MyHomeRelatorio extends StatefulWidget {
  @override
  _MyHomeRelatorioState createState() => _MyHomeRelatorioState();
}

class _MyHomeRelatorioState extends State<MyHomeRelatorio> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
            appBar: AppBar(
              title: Text('Estoque'),
              backgroundColor: Color(0xff5808e5),
              actions: [
                RaisedButton(
                  color: Color(0xff5808e5),
                  child: Icon(Icons.more_vert),
                  onPressed: () {},
                ),
              ],
              bottom: TabBar(
                indicatorColor: Colors.white,
                tabs: [
                  Tab(text: 'Todas'),
                  Tab(text: 'Entrada'),
                  Tab(text: 'Saidas'),
                  Tab(
                    text: '',
                    icon: Column(
                      children: [
                        SizedBox(
                          height: 22,
                        ),
                        Icon(Icons.settings_applications),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Container(child: ExpandableListPage()),
                Center(),
                Center(child: Text('BIRDS')),
                Center(child: Text('BIRDS')),
              ],
            )));
  }
}

class ExpandableListPage extends StatelessWidget {
  var array = [
    {
      'expanded': true,
      'category_Name': "  02\nSeg\nAbri",
      'categoria': '-       produçao\n produto  retirado do estoque  ',
      'sub_Category': [
        {'id': 3, 'name': 'mario  1 un de açai  05:10:20'},
        {'id': 3, 'name': 'mario  1 un de açai  05:10:20'},
        {'id': 3, 'name': 'mario  1 un de açai  05:10:20'},
      ]
    },
    {
      'expanded': true,
      'category_Name': " 02\n\seg\nabri",
      'categoria': '+   descartáveis \n produto  adicionado ao estoque',
      'sub_Category': [
        {'id': 2, 'name': 'Produtos  6'},
        {'id': 3, 'name': ''},
        {'id': 3, 'name': ''},
      ]
    },
  ];

  ListView generateItems() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: array.length,
      itemBuilder: (BuildContext context, int index) {
        return ExpandableWidget(array[index]);
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              child: RaisedButton(
                child: const Text('7 dias'),
                color: Colors.red,
                elevation: 4.0,
                splashColor: Colors.yellow,
                onPressed: () {
                  // faz alguma coisa
                },
              ),
            ),
            Expanded(
              child: RaisedButton(
                child: const Text('15 dias'),
                color: Colors.red,
                elevation: 4.0,
                splashColor: Colors.yellow,
                onPressed: () {
                  // faz alguma coisa
                },
              ),
            ),
            Expanded(
              child: RaisedButton(
                child: const Text('30 dias'),
                color: Colors.red,
                elevation: 4.0,
                splashColor: Colors.yellow,
                onPressed: () {
                  // faz alguma coisa
                },
              ),
            )
          ],
        ),
        ExpandableTheme(
          data: ExpandableThemeData(iconColor: Colors.blue, useInkWell: false),
          child: generateItems(),
        ),
      ],
    );
  }
}

class ExpandableWidget extends StatelessWidget {
  var subcategoryList;
  var category;
  var descri;
  ExpandableWidget(entry) {
    category = entry['category_Name'];
    subcategoryList = entry['sub_Category'];
    descri = entry['categoria'];
  }

  @override
  Widget build(BuildContext context) {
    buildHeader() {
      return Builder(
        builder: (context) {
          var controller = ExpandableController.of(context);
          return Container(
            width: double.infinity,
            height: 50.0,
            alignment: Alignment.center,
            child: Stack(children: [
              Container(
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Row(
                  children: [
                    Text(category, style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 40,
                    ),
                    Column(
                      children: [
                        Text(
                          descri,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: double.infinity,
                child: FlatButton(
                  onPressed: () {
                    controller.toggle();
                  },
                ),
              ),
            ]),
          );
        },
      );
    }

    buildExpanded() {
      return ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: subcategoryList.length,
        itemBuilder: (BuildContext context, int index) {
          var subcategoryName = subcategoryList[index]['name'];
          return Container(
            height: 30,
            child: Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                ),
                child: Center(child: Text('${subcategoryName}'))),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      );
    }

    return ExpandableNotifier(
        child: Container(
      color: Colors.white,
      padding: const EdgeInsets.only(left: 10.0, right: 0, bottom: 0),
      child: ScrollOnExpand(
        child: ExpandablePanel(
          header: buildHeader(),
          expanded: buildExpanded(),
        ),
      ),
    ));
  }
}
