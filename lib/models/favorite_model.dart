class FavoriteModel {
  late final int pid;
  late final String ptitle, ptype;
  late final String? pimg, pcity, pdate, presult;

  FavoriteModel(
    this.pid,
    this.ptitle,
    this.ptype,
    this.pimg,
    this.pdate,
    this.pcity,
    this.presult,
  );

  FavoriteModel.map(dynamic obj) {
    pid = obj['pid'];
    ptitle = obj['title'];
    ptype = obj['type'];
    pimg = obj['img'];
    pdate = obj['date'];
    pcity = obj['city'];
    presult = obj['result'];
  }
  //take from user and give it to class
  // int get sqlid => id; //take from user and give it to class
  int get ppid => pid; //take from user and give it to class
  String get village => ptitle;
  // double get originalPrice => poriginalPrice;
  // String get pic => ppic;

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['pid'] = pid;
    map['title'] = ptitle;
    map['type'] = ptype;
    map['img'] = pimg;
    map['date'] = pdate;
    map['city'] = pcity;
    map['result'] = presult;
    return map;
  }

  FavoriteModel.fromMap(Map<String, dynamic> map) {
    pid = map['pid'];
    ptitle = map['title'];
    ptype = map['type'];
    pimg = map['img'];
    pdate = map['date'];
    pcity = map['city'];
    presult = map['result'];
  }
}
