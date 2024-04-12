import 'package:flutter/material.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/ruleConfirmFunc.dart';

class RuleConfirm extends StatefulWidget {
  final String kyokusuValue;
  final String renchanValue;
  final String tochuryukyokuValue;
  final String agariyameValue;
  final String kuitanaAtozukeValue;
  final String fuCalcValue;
  final String freeTextFieldValue;

  const RuleConfirm({
    super.key,
    required this.kyokusuValue,
    required this.renchanValue,
    required this.tochuryukyokuValue,
    required this.agariyameValue,
    required this.kuitanaAtozukeValue,
    required this.fuCalcValue,
    required this.freeTextFieldValue,
  });

  @override
  _RuleConfirmState createState() => _RuleConfirmState();
}

class _RuleConfirmState extends State<RuleConfirm> {
  String _kyokusuueMoji = '';
  String _renchanMoji = '';
  String _tochuryukyokuMoji = '';
  String _agariyameMoji = '';
  String _kuitanAtozukeMoji = '';
  String _fuCalcValueMoji = '';
  String _freeTextFieldMoji = '';

  @override
  void initState() {
    super.initState();
    _kyokusuueMoji = widget.kyokusuValue;
    _renchanMoji = widget.renchanValue;
    _tochuryukyokuMoji = widget.tochuryukyokuValue;
    _agariyameMoji = widget.agariyameValue;
    _kuitanAtozukeMoji = widget.kuitanaAtozukeValue;
    _fuCalcValueMoji = widget.fuCalcValue;
    _freeTextFieldMoji = widget.freeTextFieldValue;
  }

  // Create globalkey for screen shot
  final convertWidgetToImageKey = GlobalKey();
  final convertTextareaToImageKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'ルールを確認',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: appDesign.appBarFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RepaintBoundary(
              key: convertWidgetToImageKey,
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ListView(
                  shrinkWrap: true,
                  children: <Widget>[
                    ListTile(
                      title: const Text(mjRule.kyokusu),
                      subtitle: Text(_kyokusuueMoji),
                    ),
                    ListTile(
                      title: const Text(mjRule.renchan),
                      subtitle: Text(_renchanMoji),
                    ),
                    ListTile(
                      title: const Text(mjRule.tochuryukyoku),
                      subtitle: Text(_tochuryukyokuMoji),
                    ),
                    ListTile(
                      title: const Text(mjRule.agariyame),
                      subtitle: Text(_agariyameMoji),
                    ),
                    ListTile(
                      title: const Text(mjRule.kuitanAtoduke),
                      subtitle: Text(_kuitanAtozukeMoji),
                    ),
                    ListTile(
                      title: const Text(mjRule.fu_calc),
                      subtitle: Text(_fuCalcValueMoji),
                    ),
                  ],
                ),
              ),
            ),
            RepaintBoundary(
              key: convertTextareaToImageKey,
              child: Container(
                color: Theme.of(context).colorScheme.background,
                child: ListTile(
                  title: const Text(mjRule.freeTextAreaLabel),
                  subtitle: Text(_freeTextFieldMoji),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _widgetBottomButton(),
    );
  }

  Widget _widgetBottomButton() {
    return BottomAppBar(
      color: Theme.of(context).colorScheme.background,
      elevation: 0,
      child: ElevatedButton.icon(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 60),
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        onPressed: () {
          shareWidgetImage(
              globalKey: convertWidgetToImageKey,
              textFielldKey: convertTextareaToImageKey);
        },
        icon: Icon(
          Icons.share,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
        label: Text(
          "シェア",
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: appDesign.btnFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
