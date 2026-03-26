

class NotificationBody {
  int? orderId;
  String? type;
  String? status;
  String? messageKey;
  String? title;
  String? productId;
  String? slug;
  String? image;
  String? expiryDate;


  NotificationBody({
    this.orderId,
    this.type,
    this.status,
    this.messageKey,
    this.title,
    this.productId,
    this.slug,
    this.image,
    this.expiryDate
  });

  NotificationBody.fromJson(Map<String, dynamic> json) {
    orderId = json['order_id'];
    type = json['type'];
    messageKey = json['message_key'];
    title = json['title'];
    productId = json['product_id'];
    slug = json['slug'];
    image = json['image'];
    status = json['status'];
    expiryDate = json['expiry-date'] ?? json['expiry_date'] ?? json['expiryDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_id'] = orderId;
    data['type'] = type;
    data['message_key'] = messageKey;
    data['title'] = title;
    data['product_id'] = productId;
    data['slug'] = slug;
    data['image'] = image;
    data['status'] = status;
    data['expiry-date'] = expiryDate;
    return data;
  }


}
