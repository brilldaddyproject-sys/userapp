class MyClaimModel {
  int? id;
  String? image;
  String? title;
  String? description;
  String? value;
  int? totalBids;
  String? latestBidAt;
  bool? resultAnnounced;
  bool? isWinner;
  ClaimSlots? slots;

  MyClaimModel({
    this.id,
    this.image,
    this.title,
    this.description,
    this.value,
    this.totalBids,
    this.latestBidAt,
    this.resultAnnounced,
    this.isWinner,
    this.slots,
  });

  MyClaimModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image']?.toString();
    title = json['title']?.toString();
    description = json['description']?.toString();
    value = json['value']?.toString();
    totalBids = int.tryParse(json['total_bids'].toString());
    latestBidAt = json['latest_bid_at']?.toString();
    resultAnnounced = json['result_announced'] == true || json['result_announced'] == 1;
    isWinner = json['is_winner'] == true || json['is_winner'] == 1;
    slots = json['slots'] != null ? ClaimSlots.fromJson(json['slots']) : null;
  }
}

class ClaimSlots {
  int? filled;
  int? total;
  int? remaining;
  String? display;

  ClaimSlots({
    this.filled,
    this.total,
    this.remaining,
    this.display,
  });

  ClaimSlots.fromJson(Map<String, dynamic> json) {
    filled = int.tryParse(json['filled'].toString());
    total = int.tryParse(json['total'].toString());
    remaining = int.tryParse(json['remaining'].toString());
    display = json['display']?.toString();
  }
}
