

class VoucherBidDetailModel {
  int? id;
  String? title;
  String? description;
  String? value;
  String? amount;
  String? createdAt;
  String? gameid;
  bool? isWinner;

  VoucherBidDetailModel(
      {this.id,
        this.title,
        this.description,
        this.value,
        this.amount,
        this.createdAt,
        this.gameid,this.isWinner});

  VoucherBidDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    value = json['value'];
    amount = json['amount'];
    createdAt = json['created_at'];
    gameid = json['gameid'];
    isWinner = json['is_winner'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['value'] = this.value;
    data['amount'] = this.amount;
    data['created_at'] = this.createdAt;
    data['gameid'] = this.gameid;
    data['is_winner'] = this.isWinner;
    return data;
  }
}
