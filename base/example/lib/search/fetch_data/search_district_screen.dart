import 'package:flutter/material.dart';

import '../../utils/misc.dart';
import '../../utils/view.dart';
import '../../widgets/button.widget.dart';
import '../../widgets/dimens.dart';
import 'package:amap_base/amap_base.dart';

class SearchDistrictScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchDistrictScreenState();
  }
}

class _SearchDistrictScreenState extends State<SearchDistrictScreen> {
  var keywordController = TextEditingController();
  var _result = "";

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        appBar: AppBar(
          title: Text("获取行政区划数据"),
        ),
        backgroundColor: Theme.of(context).primaryColor,
        body: Form(
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: '输入关键字',
                  hintStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder(),
                ),
                style: TextStyle(color: Colors.white),
                controller: keywordController,
                validator: (value) {
                  if (value.isEmpty) {
                    return '请输入关键字';
                  }
                  return null;
                },
              ),
              SPACE_NORMAL,
              Button(
                label: '开始搜索',
                onPressed: (context) async {
                  if (!Form.of(context).validate()) {
                    return;
                  }

                  loading(
                    context,
                    AMapSearch().searchDistrict(
                      keywordController.text,
                      true,
                    ),
                  ).then((result) {
                    setState(() => _result = result.toString());
                  }).catchError((e) => showError(context, e.toString()));
                },
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Text(
                  _result,
                  style: TextStyle(color: Colors.white),
                ),
              ))
            ],
          ),
        ));
  }
}
