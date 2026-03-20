

class VoucherWinnerModel {
  int? id;
  int? voucherId;
  int? userId;
  String? amount;
  String? gameid;
  String? declaredAt;
  String? createdAt;
  String? updatedAt;
  Voucher? voucher;
  User? user;

  VoucherWinnerModel(
      {this.id,
        this.voucherId,
        this.userId,
        this.amount,
        this.gameid,
        this.declaredAt,
        this.createdAt,
        this.updatedAt,
        this.voucher,
        this.user});

  VoucherWinnerModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherId = json['voucher_id'];
    userId = json['user_id'];
    amount = json['amount'];
    gameid = json['gameid'];
    declaredAt = json['declared_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    voucher =
    json['voucher'] != null ? new Voucher.fromJson(json['voucher']) : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_id'] = this.voucherId;
    data['user_id'] = this.userId;
    data['amount'] = this.amount;
    data['gameid'] = this.gameid;
    data['declared_at'] = this.declaredAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    if (this.voucher != null) {
      data['voucher'] = this.voucher!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Voucher {
  int? id;
  String? title;
  String? description;
  String? value;
  String? minBid;
  String? maxBid;
  String? bidStep;
  Null? bidFee;
  String? startDate;
  String? endDate;
  String? resultDate;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? deletedAt;
  int? status;

  Voucher(
      {this.id,
        this.title,
        this.description,
        this.value,
        this.minBid,
        this.maxBid,
        this.bidStep,
        this.bidFee,
        this.startDate,
        this.endDate,
        this.resultDate,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.status});

  Voucher.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    value = json['value'];
    minBid = json['min_bid'];
    maxBid = json['max_bid'];
    bidStep = json['bid_step'];
    bidFee = json['bid_fee'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    resultDate = json['result_date'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['value'] = this.value;
    data['min_bid'] = this.minBid;
    data['max_bid'] = this.maxBid;
    data['bid_step'] = this.bidStep;
    data['bid_fee'] = this.bidFee;
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['result_date'] = this.resultDate;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['deleted_at'] = this.deletedAt;
    data['status'] = this.status;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? fName;
  String? phone;
  String? image;
  String? email;
  String? createdAt;
  String? updatedAt;
  bool? isPhoneVerified;
  bool? isEmailVerified;
  int? walletBalance;
  int? loyaltyPoint;
  int? loginHitCount;
  bool? isTempBlocked;
  String? referralCode;
  String? appLanguage;

  List<Null>? storage;

  User(
      {this.id,
        this.name,
        this.fName,
        this.phone,
        this.image,
        this.email,
        this.createdAt,
        this.updatedAt,
        this.isPhoneVerified,

        this.isEmailVerified,
        this.walletBalance,
        this.loyaltyPoint,
        this.loginHitCount,
        this.isTempBlocked,

        this.referralCode,

        this.appLanguage,
        this.storage});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    fName = json['f_name'];
    phone = json['phone'];
    image = json['image'];
    email = json['email'];

    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

    isPhoneVerified = json['is_phone_verified'];

    isEmailVerified = json['is_email_verified'];
    walletBalance = json['wallet_balance'];
    loyaltyPoint = json['loyalty_point'];
    loginHitCount = json['login_hit_count'];
    isTempBlocked = json['is_temp_blocked'];

    referralCode = json['referral_code'];

    appLanguage = json['app_language'];


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['f_name'] = this.fName;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['email'] = this.email;

    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;



    data['is_phone_verified'] = this.isPhoneVerified;

    data['is_email_verified'] = this.isEmailVerified;
    data['wallet_balance'] = this.walletBalance;
    data['loyalty_point'] = this.loyaltyPoint;
    data['login_hit_count'] = this.loginHitCount;
    data['is_temp_blocked'] = this.isTempBlocked;

    data['referral_code'] = this.referralCode;

    data['app_language'] = this.appLanguage;

    return data;
  }
}


