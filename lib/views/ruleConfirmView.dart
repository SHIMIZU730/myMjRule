import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/ruleConfirmFunc.dart';

class RuleConfirm extends StatefulWidget {
  final bool switchKuitanValue;
  final bool switchAtozukeValue;
  final String ddlFuCalcValue;
  final String freeTextFieldValue;

  const RuleConfirm({
    super.key,
    required this.switchKuitanValue,
    required this.switchAtozukeValue,
    required this.ddlFuCalcValue,
    required this.freeTextFieldValue,
  });

  @override
  _RuleConfirmState createState() => _RuleConfirmState();
}

class _RuleConfirmState extends State<RuleConfirm> {
  String _strKuitanChoiceMoji = '';
  String _strAtozukehoiceMoji = '';
  String _ddlFuCalcValueMoji = '';
  String _freeTextFieldMoji = '';

  @override
  void initState() {
    super.initState();
    _strKuitanChoiceMoji =
        widget.switchKuitanValue ? ariNashi.ari : ariNashi.nashi;
    _strAtozukehoiceMoji =
        widget.switchAtozukeValue ? ariNashi.ari : ariNashi.nashi;
    _ddlFuCalcValueMoji = widget.ddlFuCalcValue;
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
      body: Column(
        children: [
          RepaintBoundary(
            key: convertWidgetToImageKey,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  ListTile(
                    title: const Text(mjRule.kuitan),
                    subtitle: Text(_strKuitanChoiceMoji),
                  ),
                  ListTile(
                    title: const Text(mjRule.atozuke),
                    subtitle: Text(_strAtozukehoiceMoji),
                  ),
                  ListTile(
                    title: const Text(mjRule.fu_calc),
                    subtitle: Text(_ddlFuCalcValueMoji),
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
                title: const Text('自由入力項目'),
                subtitle: Text(_freeTextFieldMoji),
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        width: MediaQuery.of(context).size.width - 20,
        height: 56, // Standard Material Design FAB height.
        margin: const EdgeInsets.symmetric(horizontal: 10),
        child: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).colorScheme.primary,
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
            'シェア',
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: appDesign.btnFontSize,
                fontWeight: FontWeight.bold),
          ),
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(28), // Adjust the corner radius if needed
          ),
        ),
      ),
    );
  }
}
