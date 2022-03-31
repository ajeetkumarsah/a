class MembershipPlan {
  MembershipPlan({
    this.id,
    this.uid,
    this.planName,
    this.planType,
    this.price,
    this.taxPercentage,
    this.dateAdded,
    this.lastUpdated,
    this.status,
    this.duration,
    this.image,
    this.description,
    this.trainerId,
    this.trainerName,
    this.isRecomended,
    this.isGoal,
    this.gymName,
  });

  int? id;
  String? uid;
  String? planName;
  String? planType;
  String? price;
  String? taxPercentage;
  String? dateAdded;
  String? lastUpdated;
  String? status;
  String? duration;
  dynamic image;
  String? description;
  String? trainerId;
  String? trainerName;
  int? isRecomended;
  int? isGoal;
  String? gymName;

  factory MembershipPlan.fromJson(Map<String, dynamic> json) => MembershipPlan(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        planName: json["plan_name"] == null ? null : json["plan_name"],
        planType: json["plan_type"] == null ? null : json["plan_type"],
        price: json["price"] == null ? null : json["price"],
        taxPercentage:
            json["tax_percentage"] == null ? null : json["tax_percentage"],
        dateAdded: json["date_added"] == null ? null : json["date_added"],
        lastUpdated: json["last_updated"] == null ? null : json["last_updated"],
        status: json["status"] == null ? null : json["status"],
        duration: json["duration"] == null ? null : json["duration"],
        image: json["image"],
        description: json["description"] == null ? null : json["description"],
        trainerId: json["trainer_id"] == null ? null : json["trainer_id"],
        trainerName: json["trainer_name"] == null ? null : json["trainer_name"],
        isRecomended:
            json["is_recomended"] == null ? null : json["is_recomended"],
        isGoal: json["is_goal"] == null ? null : json["is_goal"],
        gymName: json["gym_name"] == null ? null : json["gym_name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "uid": uid == null ? null : uid,
        "plan_name": planName == null ? null : planName,
        "plan_type": planType == null ? null : planType,
        "price": price == null ? null : price,
        "tax_percentage": taxPercentage == null ? null : taxPercentage,
        "date_added": dateAdded == null ? null : dateAdded,
        "last_updated": lastUpdated == null ? null : lastUpdated,
        "status": status == null ? null : status,
        "duration": duration == null ? null : duration,
        "image": image,
        "description": description == null ? null : description,
        "trainer_id": trainerId == null ? null : trainerId,
        "trainer_name": trainerName == null ? null : trainerName,
        "is_recomended": isRecomended == null ? null : isRecomended,
        "is_goal": isGoal == null ? null : isGoal,
        "gym_name": gymName == null ? null : gymName,
      };
}

class Pagination {
  Pagination({
    this.pagination,
    this.limit,
    this.pages,
  });

  int? pagination;
  int? limit;
  int? pages;

  factory Pagination.fromJson(Map<String, dynamic> json) => Pagination(
        pagination: json["pagination"] == null ? null : json["pagination"],
        limit: json["limit"] == null ? null : json["limit"],
        pages: json["pages"] == null ? null : json["pages"],
      );

  Map<String, dynamic> toJson() => {
        "pagination": pagination == null ? null : pagination,
        "limit": limit == null ? null : limit,
        "pages": pages == null ? null : pages,
      };
}
