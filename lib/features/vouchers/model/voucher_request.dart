


class VoucherRequest {
  String? voucherId;
  String? amount;

  VoucherRequest({this.voucherId, this.amount});

  VoucherRequest.fromJson(Map<String, dynamic> json) {
    voucherId = json['voucher_id'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['voucher_id'] = this.voucherId;
    data['amount'] = this.amount;
    return data;
  }
}
