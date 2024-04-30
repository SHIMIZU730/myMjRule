const String appName = "My麻雀ルール";
const String priPolicyUrl =
    "http://flutter-privacypolicy.s3-website-ap-northeast-1.amazonaws.com/";

const String googleFormUrl =
    "https://docs.google.com/forms/d/e/1FAIpQLScDcS_rbCY2eokj6ttEr5T5EDeYlHY5NjD15SP-CbqOcj1SMQ/viewform?usp=sf_link";

class MjRule {
  static const String kyokusu = "曲数";
  static const String renchan = "連荘条件";
  static const String tochuryukyoku = "途中流局";
  static const String agariyame = "アガリやめ";
  static const String kuitanAtoduke = "食いタン・後付け";
  static const String atozuke = "後付け";
  static const String fuCalc = "符計算";
  static const String freeTextAreaLabel = "自由入力項目";
}

class KyokuRule {
  static const String hanchan4 = "四麻半荘";
  static const String tonpuu4 = "四麻東風";
  static const String hanchan3 = "三麻半荘";
  static const String tonpuu3 = "三麻東風";
}

class RenchanRule {
  static const String agariTenpai = "アガリorテンパイ";
  static const String onlyAgari = "アガリのみ";
  static const String renchanNashi = "連荘なし";
}

class TochuryukyokuRule {
  static const String ari = "あり";
  static const String nashi = "なし";
}

class AgariyameRule {
  static const String dekiru = "できる";
  static const String dekinai = "できない";
}

class KuitanAtodukeRule {
  static const String ariari = "ありあり";
  static const String nashinashi = "なしなし";
  static const String ariNashi = "ありなし";
  static const String nashiari = "なしあり";
}

class AriNashi {
  static const String ari = "あり";
  static const String nashi = "なし";
}

class CalcRule {
  static const String fuNashi = "符計算なし";
  static const String pintsumoChitoiFuAri = "ピンツモ,チートイのみ符計算";
  static const String pintumoFuAri = "ピンツモのみ符計算";
  static const String chitoiFuAri = "チートイのみ符計算";
  static const String fuAri = "符計算あり";
}

class AppDesign {
  static const double btnFontSize = 20.0;
  static const double appBarFontSize = 20.0;
}

// ListTile design for Rule Detail
class ListTileDesign {
  static const double containerGreenBarWidth = 3.0;
  static const double containerSizeBoxWidth = 8.0;
}
