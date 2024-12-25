class HistoryModel {
  final int numberOfFinishedRequests;
  final List<FinishedRequest> finishedRequests;

  HistoryModel({
    required this.numberOfFinishedRequests,
    required this.finishedRequests,
  });

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      numberOfFinishedRequests: json['number_of_finished_requests'],
      finishedRequests: (json['finished_requests'] as List)
          .map((requestJson) => FinishedRequest.fromJson(requestJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number_of_finished_requests': numberOfFinishedRequests,
      'finished_requests': finishedRequests.map((request) => request.toJson()).toList(),
    };
  }
}

class FinishedRequest {
  final int id;
  final String taskTitle;
  final String taskDescription;
  final String? accDosen;
  final String? accKaprodi;
  final String downloadKompensasi;
  final List<Comment> comments;

  FinishedRequest({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    this.accDosen,
    this.accKaprodi,
    required this.downloadKompensasi,
    required this.comments,
  });

  factory FinishedRequest.fromJson(Map<String, dynamic> json) {
    return FinishedRequest(
      id: json['id'],
      taskTitle: json['task_title'],
      taskDescription: json['task_description'],
      accDosen: json['acc_dosen'],
      accKaprodi: json['acc_kaprodi'],
      downloadKompensasi: json['download_kompensasi'],
      comments: (json['comments'] as List)
          .map((commentJson) => Comment.fromJson(commentJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_title': taskTitle,
      'task_description': taskDescription,
      'acc_dosen': accDosen,
      'acc_kaprodi': accKaprodi,
      'download_kompensasi': downloadKompensasi,
      'comments': comments.map((comment) => comment.toJson()).toList(),
    };
  }
}

class Comment {
  final int id;
  final int idUser;
  final String name;
  final String image;
  final String comment;

  Comment({
    required this.id,
    required this.idUser,
    required this.name,
    required this.image,
    required this.comment,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      idUser: json['id_user'],
      name: json['name'],
      image: json['image'],
      comment: json['comment'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'name': name,
      'image': image,
      'comment': comment,
    };
  }
}