class Benefit {
    Benefit({
        this.id,
        this.uid,
        this.gymId,
        this.name,
        this.breif,
        this.image,
        this.status,
        this.dateAdded,
        this.lastUpdated,
    });

    int? id;
    String? uid;
    String? gymId;
    String? name;
    String? breif;
    String? image;
    String? status;
    DateTime? dateAdded;
    DateTime ? lastUpdated;

    factory Benefit.fromJson(Map<String, dynamic> json) => Benefit(
        id: json["id"] == null ? null : json["id"],
        uid: json["uid"] == null ? null : json["uid"],
        gymId: json["gym_id"] == null ? null : json["gym_id"],
        name: json["name"] == null ? null : json["name"],
        breif: json["breif"] == null ? null : json["breif"],
        image: json["image"] == null ? null : json["image"],
        status: json["status"] == null ? null : json["status"],
        dateAdded: json["date_added"] == null ? DateTime.now() : DateTime.parse(json["date_added"]),
        lastUpdated: json["last_updated"] == null ? DateTime.now()  : DateTime.parse(json["last_updated"]),
    );


}
