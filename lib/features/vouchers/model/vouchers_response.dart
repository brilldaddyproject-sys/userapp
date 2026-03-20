class VoucherModel {
  int? id;
  String? title;
  String? description;
  String? value;
  String? minBid;
  String? maxBid;
  String? bidStep;
  String? startDate;
  String? endDate;
  String? image;
  String? createdAt;
  String? updatedAt;
  String? canbid = "false";

  VoucherModel(
      {this.id,
        this.title,
        this.description,
        this.value,
        this.minBid,
        this.maxBid,
        this.bidStep,
        this.startDate,
        this.endDate,
        this.image,
        this.createdAt,
        this.updatedAt,this.canbid});

  VoucherModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    value = json['value'];
    minBid = json['min_bid'];
    maxBid = json['max_bid'];
    bidStep = json['bid_step'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    canbid = json['canbid'];
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
    data['start_date'] = this.startDate;
    data['end_date'] = this.endDate;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['canbid'] = this.canbid;
    return data;
  }
}
