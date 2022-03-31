

class Gallery {
    Gallery({
        required this.id,
        required this.uid,
        required this.gymId,
        required this.categoryId,
        required this.images,
        required this.status,
        required this.dateAdded,
        required this.lastUpdated,
        required this.type,
    });

    final int id;
    final String uid;
    final String gymId;
    final String categoryId;
    final String images;
    final String status;
    final String dateAdded;
    final String lastUpdated;
    final String type;

    factory Gallery.fromJson(Map<String, dynamic> json) => Gallery(
        id: json["id"],
        uid: json["uid"],
        gymId: json["gym_id"],
        categoryId: json["category_id"],
        images: json["images"],
        status:json["status"],
        dateAdded: json["date_added"],
        lastUpdated: json["last_updated"],
        type: json["type"],
    );

    
}
