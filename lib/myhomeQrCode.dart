import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_files_and_screenshot_widgets/share_files_and_screenshot_widgets.dart';

class DropDown extends StatefulWidget {
  DropDown() : super();

  final String title = "DropDown Demo";

  @override
  DropDownState createState() => DropDownState();
}

class Company {
  int id;
  String name;

  Company(this.id, this.name);

  static List<Company> getCompanies() {
    return <Company>[
      Company(1, 'Guaraná '),
      Company(2, 'Leite'),
    ];
  }
}

class DropDownState extends State<DropDown> {
  List<Company> _companies = Company.getCompanies();
  List<DropdownMenuItem<Company>> _dropdownMenuItems;
  Company _selectedCompany;
  Image _image;
  GlobalKey previewContainer = new GlobalKey();
  int originalSize = 9000;

  @override
  void initState() {
    _dropdownMenuItems = buildDropdownMenuItems(_companies);
    _selectedCompany = _dropdownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<Company>> buildDropdownMenuItems(List companies) {
    List<DropdownMenuItem<Company>> items = [];
    for (Company company in companies) {
      items.add(
        DropdownMenuItem(
          value: company,
          child: Text(company.name),
        ),
      );
    }
    return items;
  }

  onChangeDropdownItem(selectedCompany) {
    setState(() {
      _selectedCompany = selectedCompany;
    });
  }

  String UserName = '';

  @override
  Widget build(BuildContext context) {
    var nameController;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: Text("Qr"),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 20.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 30,
                ),
                SizedBox(
                  width: 30,
                ),
                Column(
                  children: [
                    DropdownButton(
                      value: _selectedCompany,
                      items: _dropdownMenuItems,
                      onChanged: onChangeDropdownItem,
                    ),
                    SizedBox(
                      height: 50,
                    )
                  ],
                ),
                SizedBox(
                  width: 30,
                ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Text('Selected: ${_selectedCompany.name}'),
            RepaintBoundary(
              key: previewContainer,
              child: Container(
                color: Colors.white,
                child: QrImage(
                  data: '${_selectedCompany.name}',
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // ignore: deprecated_member_use

                Container(
                    child: RaisedButton(
                        child: Text("Share Screenshot!"),
                        onPressed: () {
                          ShareFilesAndScreenshotWidgets().shareScreenshot(previewContainer, originalSize, "Title", "Name.png", "image/png",
                              text: "QrCode ${_selectedCompany.name}");
                        })),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
