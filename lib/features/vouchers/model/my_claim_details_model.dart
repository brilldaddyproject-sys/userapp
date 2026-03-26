class MyClaimDetailsModel {
  bool? status;
  String? message;
  ClaimProduct? product;
  ClaimDetailSlots? slots;
  ClaimWinner? winner;
  List<ClaimParticipant>? participants;

  MyClaimDetailsModel({
    this.status,
    this.message,
    this.product,
    this.slots,
    this.winner,
    this.participants,
  });

  MyClaimDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'] == true || json['status'] == 1;
    message = json['message']?.toString();
    product = json['product'] != null ? ClaimProduct.fromJson(json['product']) : null;
    slots = json['slots'] != null ? ClaimDetailSlots.fromJson(json['slots']) : null;
    winner = json['winner'] is Map<String, dynamic> ? ClaimWinner.fromJson(json['winner']) : null;
    if (json['participants'] != null) {
      participants = <ClaimParticipant>[];
      for (final participant in json['participants']) {
        participants!.add(ClaimParticipant.fromJson(participant));
      }
    }
  }
}

class ClaimProduct {
  int? id;
  String? title;
  String? description;
  String? image;
  String? voucherAmount;
  String? entryFee;
  bool? isWinnerAnnounced;

  ClaimProduct({
    this.id,
    this.title,
    this.description,
    this.image,
    this.voucherAmount,
    this.entryFee,
    this.isWinnerAnnounced,
  });

  ClaimProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title']?.toString();
    description = json['description']?.toString();
    image = json['image']?.toString();
    voucherAmount = json['voucher_amount']?.toString();
    entryFee = json['entry_fee']?.toString();
    isWinnerAnnounced = json['is_winner_announced'] == true || json['is_winner_announced'] == 1;
  }
}

class ClaimDetailSlots {
  int? filled;
  int? total;
  int? remaining;
  String? display;
  double? progress;

  ClaimDetailSlots({
    this.filled,
    this.total,
    this.remaining,
    this.display,
    this.progress,
  });

  ClaimDetailSlots.fromJson(Map<String, dynamic> json) {
    filled = int.tryParse(json['filled'].toString());
    total = int.tryParse(json['total'].toString());
    remaining = int.tryParse(json['remaining'].toString());
    display = json['display']?.toString();
    progress = double.tryParse(json['progress'].toString());
  }
}

class ClaimWinner {
  String? userName;
  String? amount;

  ClaimWinner({
    this.userName,
    this.amount,
  });

  ClaimWinner.fromJson(Map<String, dynamic> json) {
    userName = json['user_name']?.toString();
    amount = json['amount']?.toString();
  }
}

class ClaimParticipant {
  int? id;
  String? userName;
  String? amount;
  String? gameId;
  bool? isWinner;
  bool? isMyBid;
  String? createdAt;

  ClaimParticipant({
    this.id,
    this.userName,
    this.amount,
    this.gameId,
    this.isWinner,
    this.isMyBid,
    this.createdAt,
  });

  ClaimParticipant.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userName = json['user_name']?.toString();
    amount = json['amount']?.toString();
    gameId = json['gameid']?.toString();
    isWinner = json['is_winner'] == true || json['is_winner'] == 1;
    isMyBid = json['is_my_bid'] == true || json['is_my_bid'] == 1;
    createdAt = json['created_at']?.toString();
  }
}
