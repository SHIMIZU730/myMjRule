import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
// import 'package:flutter_app_mj/admob/ad_mod.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/ruleConfirmView.dart';
import 'package:flutter_app_mj/common/utils.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ChoiceRule extends StatefulWidget {
  @override
  _ChoiceRuleState createState() => _ChoiceRuleState();
}

class _ChoiceRuleState extends State<ChoiceRule> {
  late TextEditingController _freeTextFieldController;
  late BuildContext mainContext; // For snackbar

  // Default input
  String _kyokusu = kyokuRule.hanchan4;
  String _renchan = renchanRule.agariTenpai;
  String _tochuryukyoku = tochuryukyokuRule.nashi;
  String _agariyame = agariyameRule.dekiru;
  String _kuitanAtozuke = kuitanAtodukeRule.ariari;
  String _fuCalcValue = calcRule.fu_nashi;
  String _freeTextFieldValue = "";

  // Admob
  // final AdMob _adMob = AdMob();

  @override
  void initState() {
    super.initState();
    _freeTextFieldController = TextEditingController();
    // _adMob.load();
    _initData();
  }

  void _initData() async {
    await _loadData();
    // _freeFieldController: need to write _loadData()
    _freeTextFieldController = TextEditingController(text: _freeTextFieldValue);
  }

  @override
  void dispose() {
    super.dispose();
    // _adMob.dispose();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _kyokusu = prefs.getString('kyokusu') ?? kyokuRule.hanchan4;
      _renchan = prefs.getString('renchan') ?? renchanRule.agariTenpai;
      _tochuryukyoku =
          prefs.getString('tochuryukyoku') ?? tochuryukyokuRule.nashi;
      _agariyame = prefs.getString('agariyame') ?? agariyameRule.dekiru;
      _kuitanAtozuke =
          prefs.getString('kuitanAtozuke') ?? kuitanAtodukeRule.ariari;
      _fuCalcValue = prefs.getString('fuCalcValue') ?? calcRule.fu_nashi;
      _freeTextFieldValue = prefs.getString('freeTextFieldValue') ?? "";
    });
  }

  void _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('kyokusu', _kyokusu);
    prefs.setString('renchan', _renchan);
    prefs.setString('tochuryukyoku', _tochuryukyoku);
    prefs.setString('agariyame', _agariyame);
    prefs.setString('kuitanAtozuke', _kuitanAtozuke);
    prefs.setString('fuCalcValue', _fuCalcValue);
    prefs.setString('freeTextFieldValue', _freeTextFieldValue);
  }

  void _resetData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _kyokusu = kyokuRule.hanchan4;
      _renchan = renchanRule.agariTenpai;
      _tochuryukyoku = tochuryukyokuRule.nashi;
      _agariyame = agariyameRule.dekiru;
      _kuitanAtozuke = kuitanAtodukeRule.ariari;
      _fuCalcValue = calcRule.fu_nashi;
      _freeTextFieldValue = "";
      _freeTextFieldController.text = "";
      prefs.setString('kyokusu', _kyokusu);
      prefs.setString('renchan', _renchan);
      prefs.setString('tochuryukyoku', _tochuryukyoku);
      prefs.setString('agariyame', _agariyame);
      prefs.setString('kuitanAtozuke', _kuitanAtozuke);
      prefs.setString('fuCalcValue', _fuCalcValue);
      prefs.setString('freeTextFieldValue', _freeTextFieldValue);
    });
  }

  @override
  Widget build(BuildContext context) {
    mainContext = context; // For snackbar
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
        actions: <Widget>[
          IconButton(
            onPressed: () {
              _saveData();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('ルールを保存しました。',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold)),
                  duration: const Duration(seconds: 2),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .primary, // Changed background color to green
                ),
              );
            },
            icon: const Icon(Icons.save),
          )
        ],
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
                _widgetAgariyameSelect(),
                _widgetKuitanAtozukeSelect(),
                _widgetFukeisanSelect(),
                _widgetFreeTextField(),
              ],
            ),
          ),
        ),
      ),
      drawer: _widgetDrawer(context),
      bottomNavigationBar: _widgetBottomButton(),
    );
  }

  Widget _widgetKyokusuSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0, top: 16.0),
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
              selected: _kyokusu == kyokuRule.hanchan4,
              onSelected: (bool selected) {
                setState(() {
                  _kyokusu = kyokuRule.hanchan4;
                });
              },
            ),
            FilterChip(
              label: const Text(kyokuRule.tonpuu4,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyokusu == kyokuRule.tonpuu4,
              onSelected: (bool selected) {
                setState(() {
                  _kyokusu = kyokuRule.tonpuu4;
                });
              },
            ),
            FilterChip(
              label: const Text(kyokuRule.hanchan3,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyokusu == kyokuRule.hanchan3,
              onSelected: (bool selected) {
                setState(() {
                  _kyokusu = kyokuRule.hanchan3;
                });
              },
            ),
            FilterChip(
              label: const Text(kyokuRule.tonpuu3,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _kyokusu == kyokuRule.tonpuu3,
              onSelected: (bool selected) {
                setState(() {
                  _kyokusu = kyokuRule.tonpuu3;
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

  Widget _widgetAgariyameSelect() {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(mjRule.agariyame,
                style: TextStyle(fontSize: appDesign.ruleCheckTxtSize)),
          ),
        ),
        Wrap(
          spacing: 8.0,
          children: <Widget>[
            FilterChip(
              label: const Text(agariyameRule.dekiru,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _agariyame == agariyameRule.dekiru,
              onSelected: (bool selected) {
                setState(() {
                  _agariyame = agariyameRule.dekiru;
                });
              },
            ),
            FilterChip(
              label: const Text(agariyameRule.dekinai,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _agariyame == agariyameRule.dekinai,
              onSelected: (bool selected) {
                setState(() {
                  _agariyame = agariyameRule.dekinai;
                });
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _widgetKuitanAtozukeSelect() {
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
              selected: _fuCalcValue == calcRule.fu_nashi,
              onSelected: (bool selected) {
                setState(() {
                  _fuCalcValue = calcRule.fu_nashi;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _fuCalcValue == calcRule.fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _fuCalcValue = calcRule.fu_ari;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.pintsumo_chitoi_fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _fuCalcValue == calcRule.pintsumo_chitoi_fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _fuCalcValue = calcRule.pintsumo_chitoi_fu_ari;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.pintumo_fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _fuCalcValue == calcRule.pintumo_fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _fuCalcValue = calcRule.pintumo_fu_ari;
                });
              },
            ),
            FilterChip(
              label: const Text(calcRule.chitoi_fu_ari,
                  style: TextStyle(fontSize: appDesign.ruleCheckBoxSize)),
              selected: _fuCalcValue == calcRule.chitoi_fu_ari,
              onSelected: (bool selected) {
                setState(() {
                  _fuCalcValue = calcRule.chitoi_fu_ari;
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
        controller: _freeTextFieldController,
        keyboardType: TextInputType.multiline,
        maxLines: null,
        autofocus: false,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1000)
        ], // Set max character limit to 500
        onChanged: (value) {
          setState(() {
            _freeTextFieldValue = value;
          });
        },
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: mjRule.freeTextAreaLabel,
          hintText: 'ここに入力してください',
        ),
      ),
    );
  }

  Widget _widgetDrawer(BuildContext drawerContext) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(drawerContext).unfocus();
      },
      child: Drawer(
          child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 36),
              children: [
                ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("トップへ戻る"),
                  onTap: () {
                    FocusScope.of(drawerContext).unfocus();
                    navigateToTop(drawerContext);
                  },
                ),
                const Divider(), // Added divider to separate the buttons
                ListTile(
                  leading: const Icon(Icons.restore),
                  title: const Text("保存したルールをリセット"),
                  onTap: () {
                    showDialog(
                      context: drawerContext,
                      builder: (BuildContext dialogContext) {
                        return AlertDialog(
                          title: const Text('確認'),
                          content: const Text('本当にリセットしてもよろしいですか？'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('いいえ'),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Close dialog only
                              },
                            ),
                            TextButton(
                              child: const Text('はい'),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Close dialog only
                                _resetData();
                                ScaffoldMessenger.of(mainContext).showSnackBar(
                                  SnackBar(
                                    content: const Text('保存したルールをリセットしました。',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    duration: const Duration(seconds: 2),
                                    backgroundColor:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                                );
                                Navigator.of(drawerContext)
                                    .pop(); // Close drawer only
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                const Divider(), // Added divider to separate the buttons
                const ListTile(
                  contentPadding: EdgeInsets.fromLTRB(3, 0, 0, 0),
                  title: Text(
                    "アプリ情報",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.privacy_tip),
                  title: const Text(
                    "プライバシーポリシー",
                    style: TextStyle(fontSize: appDesign.drawerDetailSize),
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('確認'),
                          content: const Text('web画面に遷移してもよろしいですか？'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('いいえ'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('はい'),
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close dialog
                                // for privacypolicy url
                                final url = Uri.parse(priPolicyUrl);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.contact_mail_rounded),
                  title: const Text(
                    "お問いわせフォーム",
                    style: TextStyle(fontSize: appDesign.drawerDetailSize),
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('確認'),
                          content: const Text('web画面に遷移してもよろしいですか？'),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('いいえ'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: const Text('はい'),
                              onPressed: () async {
                                Navigator.of(context).pop(); // Close dialog
                                // for privacypolicy url
                                final url = Uri.parse(googleFormUrl);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url);
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          // FutureBuilder(
          //     future: AdSize.getAnchoredAdaptiveBannerAdSize(
          //         Orientation.portrait,
          //         MediaQuery.of(context).size.width.truncate()),
          //     builder: (BuildContext context,
          //         AsyncSnapshot<AnchoredAdaptiveBannerAdSize?> snapshot) {
          //       if (snapshot.hasData) {
          //         return SizedBox(
          //           width: double.infinity,
          //           child: _adMob.getAdBanner(),
          //         );
          //       } else {
          //         return Container(
          //           height: _adMob.getAdBannerHeight(),
          //           color: Colors.white,
          //         );
          //       }
          //     }),
        ],
      )),
    );
  }

  Widget _widgetBottomButton() {
    return BottomAppBar(
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
                    kyokusuValue: _kyokusu,
                    renchanValue: _renchan,
                    tochuryukyokuValue: _tochuryukyoku,
                    agariyameValue: _agariyame,
                    kuitanaAtozukeValue: _kuitanAtozuke,
                    fuCalcValue: _fuCalcValue,
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
    );
  }
}
