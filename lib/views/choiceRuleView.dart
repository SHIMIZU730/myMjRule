import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/ruleConfirmView.dart';
import 'package:flutter_app_mj/common/utils.dart';

class ChoiceRule extends StatefulWidget {
  @override
  _ChoiceRuleState createState() => _ChoiceRuleState();
}

class _ChoiceRuleState extends State<ChoiceRule> {
  // デフォルト設定
  bool _switchKuitanValue = true;
  bool _switchAtozukeValue = true;
  String _ddlFuCalcValue = calcRule.fu_nashi;
  String _kyoku = kyokuRule.hanchan4;
  String _freeTextFieldValue = "";
  String _kuitanAtozuke = kuitanAtodukeRule.ariari;
  String _renchan = renchanRule.agariTenpai;
  String _tochuryukyoku = tochuryukyokuRule.nashi;

// todoshi 削除
  // String _strKuitanChoiceMoji = ariNashi.ari;
  // String _strAtozukehoiceMoji = ariNashi.ari;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        iconTheme:
            IconThemeData(color: Theme.of(context).colorScheme.onPrimary),
        title: Text(
          'ルールを選んでね',
          style: TextStyle(
              color: Theme.of(context).colorScheme.onPrimary,
              fontSize: appDesign.appBarFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          child: Container(
            color: Theme.of(context).colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                _widgetKyokusuSelect(),
                _widgetRenchanSelect(),
                _widgetTochuryukyokuSelect(),
                _widgetKuitanSelect(),
                _widgetFukeisanSelect(),
                _widgetFreeTextField(),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
          children: [
            ListTile(
              title: const Text("トップへ戻る"),
              onTap: () {
                FocusScope.of(context).unfocus();
                navigateToTop(context);
              },
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.background,
        elevation: 0,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => RuleConfirm(
                      switchKuitanValue: _switchKuitanValue,
                      switchAtozukeValue: _switchAtozukeValue,
                      ddlFuCalcValue: _ddlFuCalcValue,
                      freeTextFieldValue: _freeTextFieldValue)),
            );
          },
          child: Text(
            "確認画面へ",
            style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: appDesign.btnFontSize,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  Widget _widgetKyokusuSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(mjRule.kyokusu,
                style: TextStyle(fontSize: appDesign.ruleCheckTxtSize)),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.0,
          children: <Widget>[
            FilterChip(
              label: const Text(kyokuRule.hanchan4,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyoku == kyokuRule.hanchan4,
              onSelected: (bool selected) {
                setState(() {
                  _kyoku = kyokuRule.hanchan4;
                });
              },
            ),
            FilterChip(
              label: const Text(kyokuRule.tonpuu4,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyoku == kyokuRule.tonpuu4,
              onSelected: (bool selected) {
                setState(() {
                  _kyoku = kyokuRule.tonpuu4;
                });
              },
            ),
            FilterChip(
              label: const Text(kyokuRule.hanchan3,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyoku == kyokuRule.hanchan3,
              onSelected: (bool selected) {
                setState(() {
                  _kyoku = kyokuRule.hanchan3;
                });
              },
            ),
            FilterChip(
              label: const Text(kyokuRule.tonpuu3,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyoku == kyokuRule.tonpuu3,
              onSelected: (bool selected) {
                setState(() {
                  _kyoku = kyokuRule.tonpuu3;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetRenchanSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(mjRule.renchan,
                style: TextStyle(fontSize: appDesign.ruleCheckTxtSize)),
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          spacing: 8.0,
          children: <Widget>[
            FilterChip(
              label: const Text(renchanRule.agariTenpai,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _renchan == renchanRule.agariTenpai,
              onSelected: (bool selected) {
                setState(() {
                  _renchan = renchanRule.agariTenpai;
                });
              },
            ),
            FilterChip(
              label: const Text(renchanRule.onlyAgari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _renchan == renchanRule.onlyAgari,
              onSelected: (bool selected) {
                setState(() {
                  _renchan = renchanRule.onlyAgari;
                });
              },
            ),
            FilterChip(
              label: const Text(renchanRule.renchanNashi,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _renchan == renchanRule.renchanNashi,
              onSelected: (bool selected) {
                setState(() {
                  _renchan = renchanRule.renchanNashi;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetTochuryukyokuSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(mjRule.tochuryukyoku,
                style: TextStyle(fontSize: appDesign.ruleCheckTxtSize)),
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            FilterChip(
              label: const Text(tochuryukyokuRule.ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _tochuryukyoku == tochuryukyokuRule.ari,
              onSelected: (bool selected) {
                setState(() {
                  _tochuryukyoku = tochuryukyokuRule.ari;
                });
              },
            ),
            FilterChip(
              label: const Text(tochuryukyokuRule.nashi,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _tochuryukyoku == tochuryukyokuRule.nashi,
              onSelected: (bool selected) {
                setState(() {
                  _tochuryukyoku = tochuryukyokuRule.nashi;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetKuitanSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(mjRule.kuitanAtoduke,
                style: TextStyle(fontSize: appDesign.ruleCheckTxtSize)),
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            FilterChip(
              label: const Text(kuitanAtodukeRule.ariari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kuitanAtozuke == kuitanAtodukeRule.ariari,
              onSelected: (bool selected) {
                setState(() {
                  _kuitanAtozuke = kuitanAtodukeRule.ariari;
                });
              },
            ),
            FilterChip(
              label: const Text(kuitanAtodukeRule.nashinashi,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kuitanAtozuke == kuitanAtodukeRule.nashinashi,
              onSelected: (bool selected) {
                setState(() {
                  _kuitanAtozuke = kuitanAtodukeRule.nashinashi;
                });
              },
            ),
            FilterChip(
              label: const Text(kuitanAtodukeRule.arinashi,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kuitanAtozuke == kuitanAtodukeRule.arinashi,
              onSelected: (bool selected) {
                setState(() {
                  _kuitanAtozuke = kuitanAtodukeRule.arinashi;
                });
              },
            ),
            FilterChip(
              label: const Text(kuitanAtodukeRule.nashiari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kuitanAtozuke == kuitanAtodukeRule.nashiari,
              onSelected: (bool selected) {
                setState(() {
                  _kuitanAtozuke = kuitanAtodukeRule.nashiari;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  // todoshj 削除
  // Widget _widgetAtozukeSelect() {
  //   return ListTile(
  //     title: const Text(mjRule.atozuke),
  //     subtitle: Text(_strAtozukehoiceMoji),
  //     trailing: Switch(
  //       value: _switchAtozukeValue, // This should be bound to a state variable
  //       onChanged: (bool value) {
  //         if (!_switchAtozukeValue) {
  //           _strAtozukehoiceMoji = ariNashi.ari;
  //         } else {
  //           _strAtozukehoiceMoji = ariNashi.nashi;
  //         }
  //         setState(() {
  //           _switchAtozukeValue = value;
  //         });
  //       },
  //     ),
  //   );
  // }

  Widget _widgetFukeisanSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(mjRule.fu_calc,
                style: TextStyle(fontSize: appDesign.ruleCheckTxtSize)),
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            FilterChip(
              label: const Text(calcRule.fu_nashi,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _ddlFuCalcValue == calcRule.fu_nashi,
              onSelected: (bool selected) {
                setState(() {
                  _ddlFuCalcValue = calcRule.fu_nashi;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _ddlFuCalcValue == calcRule.fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _ddlFuCalcValue = calcRule.fu_ari;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.pintsumo_chitoi_fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _ddlFuCalcValue == calcRule.pintsumo_chitoi_fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _ddlFuCalcValue = calcRule.pintsumo_chitoi_fu_ari;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.pintumo_fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _ddlFuCalcValue == calcRule.pintumo_fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _ddlFuCalcValue = calcRule.pintumo_fu_ari;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.chitoi_fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _ddlFuCalcValue == calcRule.chitoi_fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _ddlFuCalcValue = calcRule.chitoi_fu_ari;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetFreeTextField() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autofocus: false,
        onChanged: (value) {
          _freeTextFieldValue = value;
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: '自由入力項目',
          hintText: 'ここに入力してください',
        ),
      ),
    );
  }
}
