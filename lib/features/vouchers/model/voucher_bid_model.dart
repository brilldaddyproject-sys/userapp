class VoucherBidModel {
  int? id;
  String? title;
  String? description;
  String? image;
  String? value;
  int? totalBids;
  String? latestBidAt;
  String? resultDate;
  int? voucherbidId;
  bool? isWinner;

  VoucherBidModel(
      {this.id,
        this.title,
        this.description,
        this.value,
        this.totalBids,
        this.latestBidAt,
        this.voucherbidId,this.image,this.isWinner,this.resultDate});

  VoucherBidModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    value = json['value'];
    totalBids = json['total_bids'];
    latestBidAt = json['latest_bid_at'];
    voucherbidId = json['voucherbid_id'];
    isWinner = json['is_winner'];
    resultDate = json['result_date'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['description'] = this.description;
    data['value'] = this.value;
    data['total_bids'] = this.totalBids;
    data['latest_bid_at'] = this.latestBidAt;
    data['voucherbid_id'] = this.voucherbidId;
    data['is_winner'] = this.isWinner;
    data['image'] = this.image;
    return data;
  }
}
