

class WinnerGalleryResponse {
  bool? status;
  List<WinnerData>? data;

  WinnerGalleryResponse({this.status, this.data});

  WinnerGalleryResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <WinnerData>[];
      json['data'].forEach((v) {
        data!.add(new WinnerData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WinnerData {
  int? id;
  int? voucherId;
  String? image;
  String? createdAt;
  String? updatedAt;
  int? status;

  WinnerData(
      {this.id,
        this.voucherId,
        this.image,
        this.createdAt,
        this.updatedAt,
        this.status});

  WinnerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    voucherId = json['voucher_id'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['voucher_id'] = this.voucherId;
    data['image'] = this.image;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['status'] = this.status;
    return data;
  }
}
