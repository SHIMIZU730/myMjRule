import 'package:flutter/material.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/rule_confirm_func.dart';

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
  RuleConfirmState createState() => RuleConfirmState();
}

class RuleConfirmState extends State<RuleConfirm> {
  String _kyokusuueMoji = '';
  String _renchanMoji = '';
  String _tochuryukyokuMoji = '';
  String _agariyameMoji = '';
  String _kuitanAtozukeMoji = '';
  String _fuCalcValueMoji = '';
  String _freeTextFieldMoji = '';

  // Create global key for screen shot
  final convertWidgetToImageKey = GlobalKey();
  final convertTextareaToImageKey = GlobalKey();
  // Create global key for share function of ipad
  final shareBtnKey = GlobalKey();

  // App design
  static EdgeInsets subtitlePadding = const EdgeInsets.fromLTRB(8, 3, 0, 0);
  static EdgeInsets listTilePadding = const EdgeInsets.only(top: 2.0)
      .add(const EdgeInsets.symmetric(horizontal: 2.0)) as EdgeInsets;

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

  // Callback function for share success judge message
  void handleShareResult(int statusCode) {
    if (!mounted) return;
    SnackBar snackBar;
    // statusCode 1: do nothing(share cancel after share button click)
    if (statusCode != 1) {
      if (statusCode == 0) {
        snackBar = const SnackBar(
          content: Text("共有が成功しました。"),
          backgroundColor: Colors.green,
        );
      } else {
        snackBar = const SnackBar(
          content: Text("共有が失敗しました。"),
          backgroundColor: Colors.red,
        );
      }
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

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
              fontSize: AppDesign.appBarFontSize,
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
                    Padding(
                      padding: listTilePadding,
                      child: ListTile(
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: ListTileDesign.containerGreenBarWidth,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                  width: ListTileDesign.containerSizeBoxWidth),
                              const Text(MjRule.kyokusu),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: subtitlePadding,
                          child: Text(_kyokusuueMoji),
                        ),
                      ),
                    ),
                    Padding(
                      padding: listTilePadding,
                      child: ListTile(
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: ListTileDesign.containerGreenBarWidth,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                  width: ListTileDesign.containerSizeBoxWidth),
                              const Text(MjRule.renchan),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: subtitlePadding,
                          child: Text(_renchanMoji),
                        ),
                      ),
                    ),
                    Padding(
                      padding: listTilePadding,
                      child: ListTile(
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: ListTileDesign.containerGreenBarWidth,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                  width: ListTileDesign.containerSizeBoxWidth),
                              const Text(MjRule.tochuryukyoku),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: subtitlePadding,
                          child: Text(_tochuryukyokuMoji),
                        ),
                      ),
                    ),
                    Padding(
                      padding: listTilePadding,
                      child: ListTile(
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: ListTileDesign.containerGreenBarWidth,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                  width: ListTileDesign.containerSizeBoxWidth),
                              const Text(MjRule.agariyame),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: subtitlePadding,
                          child: Text(_agariyameMoji),
                        ),
                      ),
                    ),
                    Padding(
                      padding: listTilePadding,
                      child: ListTile(
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: ListTileDesign.containerGreenBarWidth,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                  width: ListTileDesign.containerSizeBoxWidth),
                              const Text(MjRule.kuitanAtoduke),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: subtitlePadding,
                          child: Text(_kuitanAtozukeMoji),
                        ),
                      ),
                    ),
                    Padding(
                      padding: listTilePadding,
                      child: ListTile(
                        title: IntrinsicHeight(
                          child: Row(
                            children: [
                              Container(
                                width: ListTileDesign.containerGreenBarWidth,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(
                                  width: ListTileDesign.containerSizeBoxWidth),
                              const Text(MjRule.fuCalc),
                            ],
                          ),
                        ),
                        subtitle: Padding(
                          padding: subtitlePadding,
                          child: Text(_fuCalcValueMoji),
                        ),
                      ),
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
                  title: IntrinsicHeight(
                    child: Row(
                      children: [
                        Container(
                          width: ListTileDesign.containerGreenBarWidth,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(
                            width: ListTileDesign.containerSizeBoxWidth),
                        const Text(MjRule.freeTextAreaLabel),
                      ],
                    ),
                  ),
                  subtitle: Padding(
                    padding: subtitlePadding,
                    child: Text(_freeTextFieldMoji),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        key: shareBtnKey,
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
                textFieldKey: convertTextareaToImageKey,
                callback: handleShareResult,
                shareBtnKey: shareBtnKey);
          },
          icon: Icon(
            Icons.share,
            color: Theme.of(context).colorScheme.onPrimary,
          ),
          label: Text(
            "シェア",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: AppDesign.btnFontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
