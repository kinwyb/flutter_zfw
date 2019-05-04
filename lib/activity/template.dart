import 'package:flutter/material.dart';
import '../components/api/activity.dart';

class ActivityTemplateWidget extends StatelessWidget {
  List<ActivityTemplate> template;

  ActivityTemplateWidget({Key key, this.template}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> wgs = List<Widget>();
    for (var i in template) {
      var wg = Text.rich(
        TextSpan(
          text: "• ",
          style: TextStyle(
            color: Colors.red,
          ),
          children: [
            TextSpan(
                text: i.Title,
                style: TextStyle(fontSize: 14.0, color: Colors.grey[700]))
          ],
        ),
      );
      wgs.add(wg);
    }
    var wrap = Wrap(
      spacing: 50.0, // gap between adjacent chips
      runSpacing: 6.0, // gap between lines
      children: wgs,
    );
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                padding: new EdgeInsets.fromLTRB(10, 20, 10, 30),
                child: BottomSheet(
                  builder: (context) {
                    return _bottomSheetWidget(context);
                  },
                  onClosing: () => print('close'),
                ),
              );
            });
      },
      child: Container(
          padding: new EdgeInsets.all(10),
          margin: new EdgeInsets.fromLTRB(0, 0, 0, 10),
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: wrap,
              ),
              Container(
                width: 20,
                child: Icon(Icons.chevron_right),
              ),
            ],
          )),
    );
  }

  Widget _bottomSheetWidget(BuildContext context) {
    return Column(
      children: <Widget>[
        new Container(
          width: MediaQuery.of(context).size.width,
          padding: new EdgeInsets.fromLTRB(0, 0, 0, 10),
          margin: new EdgeInsets.fromLTRB(0, 0, 0, 5),
          decoration: BoxDecoration(
              border: new Border(
            bottom: BorderSide(width: 2, color: Colors.grey[300]),
          )),
          child: Text(
            '服务说明',
            style: TextStyle(fontSize: 22),
            textAlign: TextAlign.center,
          ),
        ),
        new Expanded(
            child: ListView.builder(
          itemCount: template.length,
          itemBuilder: _bootomSheetWidgetItem,
        ))
      ],
    );
  }

  Widget _bootomSheetWidgetItem(BuildContext context, int index) {
    return Container(
      margin: new EdgeInsets.fromLTRB(0, 5, 0, 5),
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: new EdgeInsets.fromLTRB(10, 10, 10, 5),
              child: Text.rich(
                TextSpan(
                  text: "• ",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  children: [
                    TextSpan(
                        text: this.template[index].Title,
                        style: TextStyle(fontSize: 16.0, color: Colors.black))
                  ],
                ),
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: new EdgeInsets.fromLTRB(22, 0, 22, 0),
            // color: Colors.green,
            child: Text(
              this.template[index].Contents,
              style: TextStyle(
                fontSize: 14.0,
                color: Colors.grey,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
