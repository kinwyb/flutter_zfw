import 'package:flutter/material.dart';
import 'package:zfw/components/adapt.dart';
import '../components/api/activity.dart';
import 'activitySizeUtil.dart';

class ActivityTemplateWidget extends StatelessWidget {
  final List<ActivityTemplate> template;
  ActivitySizeUtil get _size => getActivitySizeUtil();

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
          children: [TextSpan(text: i.Title, style: _size.templateTextStyle)],
        ),
      );
      wgs.add(wg);
    }
    var wrap = Wrap(
      spacing: Adapt.px(50.0), // gap between adjacent chips
      runSpacing: Adapt.px(12.0), // gap between lines
      children: wgs,
    );
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            context: context,
            builder: (context) {
              return Container(
                padding: _size.templateShowModalPadding,
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
          padding: _size.templateContainerPadding,
          margin: _size.templateContainerMargin,
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: wrap,
              ),
              Container(
                width: _size.templateContainerIconWidth,
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
          padding: _size.templateShowModalContainerPadding,
          margin: _size.templateShowModalContainerMargin,
          decoration: BoxDecoration(
              border: new Border(
            bottom: BorderSide(width: 2, color: Colors.grey[300]),
          )),
          child: Text(
            '服务说明',
            style: _size.templateShowModalContainerTitleTextStyle,
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
      margin: _size.templateShowModalContainerContentMargin,
      child: Column(
        children: <Widget>[
          Container(
              alignment: Alignment.centerLeft,
              padding: _size.templateShowModalContainerContentTitlePadding,
              child: Text.rich(
                TextSpan(
                  text: "• ",
                  style: TextStyle(
                    color: Colors.red,
                  ),
                  children: [
                    TextSpan(
                        text: this.template[index].Title,
                        style: _size
                            .templateShowModalContainerContentTitleTextStyle)
                  ],
                ),
              )),
          Container(
            alignment: Alignment.centerLeft,
            padding: _size.templateShowModalContainerContentDataPadding,
            // color: Colors.green,
            child: Text(
              this.template[index].Contents,
              style: _size.templateShowModalContainerContentDataTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
