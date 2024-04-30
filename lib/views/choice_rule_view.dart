import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter_app_mj/admob/ad_mod.dart';
import 'package:flutter_app_mj/common/constants.dart';
import 'package:flutter_app_mj/views/rule_confirm_view.dart';
import 'package:flutter_app_mj/common/utils.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class ChoiceRule extends StatefulWidget {
  const ChoiceRule({super.key});

  @override
  ChoiceRuleState createState() => ChoiceRuleState();
}

class ChoiceRuleState extends State<ChoiceRule> {
  // App design
  static EdgeInsets listTilePadding = const EdgeInsets.only(top: 8.0)
      .add(const EdgeInsets.symmetric(horizontal: 16.0)) as EdgeInsets;
  static const double choiceBtnSpace = 4.0;
  static const double ruleCheckTxtSize = 13.0;
  static const double ruleCheckBoxSize = 12.0;
  static const double drawerInfoSize = 14.0;

  // String Text
  static String moveWebAlertMess = 'Web画面に遷移してもよろしいですか？';
  static String alertYes = 'はい';
  static String alertNo = 'いいえ';

  late TextEditingController _freeTextFieldController;
  late BuildContext mainContext; // For snackbar

  // Default input
  String _kyokusu = KyokuRule.hanchan4;
  String _renchan = RenchanRule.agariTenpai;
  String _tochuryukyoku = TochuryukyokuRule.nashi;
  String _agariyame = AgariyameRule.dekiru;
  String _kuitanAtozuke = KuitanAtodukeRule.ariari;
  String _fuCalcValue = CalcRule.fuNashi;
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
      _kyokusu = prefs.getString('kyokusu') ?? KyokuRule.hanchan4;
      _renchan = prefs.getString('renchan') ?? RenchanRule.agariTenpai;
      _tochuryukyoku =
          prefs.getString('tochuryukyoku') ?? TochuryukyokuRule.nashi;
      _agariyame = prefs.getString('agariyame') ?? AgariyameRule.dekiru;
      _kuitanAtozuke =
          prefs.getString('kuitanAtozuke') ?? KuitanAtodukeRule.ariari;
      _fuCalcValue = prefs.getString('fuCalcValue') ?? CalcRule.fuNashi;
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
      _kyokusu = KyokuRule.hanchan4;
      _renchan = RenchanRule.agariTenpai;
      _tochuryukyoku = TochuryukyokuRule.nashi;
      _agariyame = AgariyameRule.dekiru;
      _kuitanAtozuke = KuitanAtodukeRule.ariari;
      _fuCalcValue = CalcRule.fuNashi;
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
              fontSize: AppDesign.appBarFontSize,
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
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: ListTileDesign.containerGreenBarWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                const Text(MjRule.kyokusu,
                    style: TextStyle(fontSize: ruleCheckTxtSize)),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: choiceBtnSpace,
            children: <Widget>[
              FilterChip(
                label: const Text(KyokuRule.hanchan4,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kyokusu == KyokuRule.hanchan4,
                onSelected: (bool selected) {
                  setState(() {
                    _kyokusu = KyokuRule.hanchan4;
                  });
                },
              ),
              FilterChip(
                label: const Text(KyokuRule.tonpuu4,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kyokusu == KyokuRule.tonpuu4,
                onSelected: (bool selected) {
                  setState(() {
                    _kyokusu = KyokuRule.tonpuu4;
                  });
                },
              ),
              FilterChip(
                label: const Text(KyokuRule.hanchan3,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kyokusu == KyokuRule.hanchan3,
                onSelected: (bool selected) {
                  setState(() {
                    _kyokusu = KyokuRule.hanchan3;
                  });
                },
              ),
              FilterChip(
                label: const Text(KyokuRule.tonpuu3,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kyokusu == KyokuRule.tonpuu3,
                onSelected: (bool selected) {
                  setState(() {
                    _kyokusu = KyokuRule.tonpuu3;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetRenchanSelect() {
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: ListTileDesign.containerGreenBarWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                const Text(MjRule.renchan,
                    style: TextStyle(fontSize: ruleCheckTxtSize)),
              ],
            ),
          ),
          Wrap(
            alignment: WrapAlignment.start,
            spacing: choiceBtnSpace,
            children: <Widget>[
              FilterChip(
                label: const Text(RenchanRule.agariTenpai,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _renchan == RenchanRule.agariTenpai,
                onSelected: (bool selected) {
                  setState(() {
                    _renchan = RenchanRule.agariTenpai;
                  });
                },
              ),
              FilterChip(
                label: const Text(RenchanRule.onlyAgari,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _renchan == RenchanRule.onlyAgari,
                onSelected: (bool selected) {
                  setState(() {
                    _renchan = RenchanRule.onlyAgari;
                  });
                },
              ),
              FilterChip(
                label: const Text(RenchanRule.renchanNashi,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _renchan == RenchanRule.renchanNashi,
                onSelected: (bool selected) {
                  setState(() {
                    _renchan = RenchanRule.renchanNashi;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetTochuryukyokuSelect() {
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the left
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: ListTileDesign.containerGreenBarWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                const Text(MjRule.tochuryukyoku,
                    style: TextStyle(fontSize: ruleCheckTxtSize)),
              ],
            ),
          ),
          Wrap(
            spacing: choiceBtnSpace,
            children: <Widget>[
              FilterChip(
                label: const Text(TochuryukyokuRule.ari,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _tochuryukyoku == TochuryukyokuRule.ari,
                onSelected: (bool selected) {
                  setState(() {
                    _tochuryukyoku = TochuryukyokuRule.ari;
                  });
                },
              ),
              FilterChip(
                label: const Text(TochuryukyokuRule.nashi,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _tochuryukyoku == TochuryukyokuRule.nashi,
                onSelected: (bool selected) {
                  setState(() {
                    _tochuryukyoku = TochuryukyokuRule.nashi;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetAgariyameSelect() {
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the left
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: ListTileDesign.containerGreenBarWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                const Text(MjRule.agariyame,
                    style: TextStyle(fontSize: ruleCheckTxtSize)),
              ],
            ),
          ),
          Wrap(
            spacing: choiceBtnSpace,
            children: <Widget>[
              FilterChip(
                label: const Text(AgariyameRule.dekiru,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _agariyame == AgariyameRule.dekiru,
                onSelected: (bool selected) {
                  setState(() {
                    _agariyame = AgariyameRule.dekiru;
                  });
                },
              ),
              FilterChip(
                label: const Text(AgariyameRule.dekinai,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _agariyame == AgariyameRule.dekinai,
                onSelected: (bool selected) {
                  setState(() {
                    _agariyame = AgariyameRule.dekinai;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetKuitanAtozukeSelect() {
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: ListTileDesign.containerGreenBarWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                const Text(MjRule.kuitanAtoduke,
                    style: TextStyle(fontSize: ruleCheckTxtSize)),
              ],
            ),
          ),
          Wrap(
            spacing: choiceBtnSpace,
            children: <Widget>[
              FilterChip(
                label: const Text(KuitanAtodukeRule.ariari,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kuitanAtozuke == KuitanAtodukeRule.ariari,
                onSelected: (bool selected) {
                  setState(() {
                    _kuitanAtozuke = KuitanAtodukeRule.ariari;
                  });
                },
              ),
              FilterChip(
                label: const Text(KuitanAtodukeRule.nashinashi,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kuitanAtozuke == KuitanAtodukeRule.nashinashi,
                onSelected: (bool selected) {
                  setState(() {
                    _kuitanAtozuke = KuitanAtodukeRule.nashinashi;
                  });
                },
              ),
              FilterChip(
                label: const Text(KuitanAtodukeRule.ariNashi,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kuitanAtozuke == KuitanAtodukeRule.ariNashi,
                onSelected: (bool selected) {
                  setState(() {
                    _kuitanAtozuke = KuitanAtodukeRule.ariNashi;
                  });
                },
              ),
              FilterChip(
                label: const Text(KuitanAtodukeRule.nashiari,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _kuitanAtozuke == KuitanAtodukeRule.nashiari,
                onSelected: (bool selected) {
                  setState(() {
                    _kuitanAtozuke = KuitanAtodukeRule.nashiari;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetFukeisanSelect() {
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the left
        children: [
          IntrinsicHeight(
            child: Row(
              children: [
                Container(
                  width: ListTileDesign.containerGreenBarWidth,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                const Text(MjRule.fuCalc,
                    style: TextStyle(fontSize: ruleCheckTxtSize)),
              ],
            ),
          ),
          Wrap(
            spacing: choiceBtnSpace,
            children: <Widget>[
              FilterChip(
                label: const Text(CalcRule.fuNashi,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _fuCalcValue == CalcRule.fuNashi,
                onSelected: (bool selected) {
                  setState(() {
                    _fuCalcValue = CalcRule.fuNashi;
                  });
                },
              ),
              FilterChip(
                label: const Text(CalcRule.fuAri,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _fuCalcValue == CalcRule.fuAri,
                onSelected: (bool selected) {
                  setState(() {
                    _fuCalcValue = CalcRule.fuAri;
                  });
                },
              ),
              FilterChip(
                label: const Text(CalcRule.pintsumoChitoiFuAri,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _fuCalcValue == CalcRule.pintsumoChitoiFuAri,
                onSelected: (bool selected) {
                  setState(() {
                    _fuCalcValue = CalcRule.pintsumoChitoiFuAri;
                  });
                },
              ),
              FilterChip(
                label: const Text(CalcRule.pintumoFuAri,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _fuCalcValue == CalcRule.pintumoFuAri,
                onSelected: (bool selected) {
                  setState(() {
                    _fuCalcValue = CalcRule.pintumoFuAri;
                  });
                },
              ),
              FilterChip(
                label: const Text(CalcRule.chitoiFuAri,
                    style: TextStyle(fontSize: ruleCheckBoxSize)),
                selected: _fuCalcValue == CalcRule.chitoiFuAri,
                onSelected: (bool selected) {
                  setState(() {
                    _fuCalcValue = CalcRule.chitoiFuAri;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _widgetFreeTextField() {
    return Padding(
      padding: listTilePadding,
      child: Column(
        crossAxisAlignment:
            CrossAxisAlignment.start, // Aligns children to the left
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    width: ListTileDesign.containerGreenBarWidth,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: ListTileDesign.containerSizeBoxWidth),
                  const Text(MjRule.freeTextAreaLabel,
                      style: TextStyle(fontSize: ruleCheckTxtSize)),
                ],
              ),
            ),
          ),
          TextField(
            controller: _freeTextFieldController,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            autofocus: false,
            inputFormatters: [
              LengthLimitingTextInputFormatter(1000)
            ], // Set max character limit to 1000
            onChanged: (value) {
              setState(() {
                _freeTextFieldValue = value;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'ここに入力してください',
            ),
          ),
        ],
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
                          title: const Row(
                            children: [
                              Icon(Icons.check),
                              SizedBox(width: 10),
                              Text('確認'),
                            ],
                          ),
                          content: const Text('本当にリセットしてもよろしいですか？'),
                          actions: <Widget>[
                            TextButton(
                              child: Text(alertNo),
                              onPressed: () {
                                Navigator.of(dialogContext)
                                    .pop(); // Close dialog only
                              },
                            ),
                            TextButton(
                              child: Text(alertYes),
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
                    style: TextStyle(fontSize: drawerInfoSize),
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Row(
                            children: [
                              Icon(Icons.check),
                              SizedBox(width: 10),
                              Text('確認'),
                            ],
                          ),
                          content: Text(moveWebAlertMess),
                          actions: <Widget>[
                            TextButton(
                              child: Text(alertNo),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(alertYes),
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
                    style: TextStyle(fontSize: drawerInfoSize),
                  ),
                  onTap: () async {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Row(
                            children: [
                              Icon(Icons.check),
                              SizedBox(width: 10),
                              Text('確認'),
                            ],
                          ),
                          content: Text(moveWebAlertMess),
                          actions: <Widget>[
                            TextButton(
                              child: Text(alertNo),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                            TextButton(
                              child: Text(alertYes),
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
              fontSize: AppDesign.btnFontSize,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
