class ActivitiesModel {
  final int numberOfUnfinishedRequests;
  final List<UnfinishedRequest> unfinishedRequests;

  ActivitiesModel({
    required this.numberOfUnfinishedRequests,
    required this.unfinishedRequests,
  });

  factory ActivitiesModel.fromJson(Map<String, dynamic> json) {
    return ActivitiesModel(
      numberOfUnfinishedRequests: json['number_of_unfinished_requests'],
      unfinishedRequests: (json['unfinished_requests'] as List)
          .map((requestJson) => UnfinishedRequest.fromJson(requestJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number_of_unfinished_requests': numberOfUnfinishedRequests,
      'unfinished_requests':
          unfinishedRequests.map((request) => request.toJson()).toList(),
    };
  }
}

class UnfinishedRequest {
  final int id;
  final String taskTitle;
  final String taskDescription;
  final String? accDosen;
  final String? accKaprodi;
  final String? kompensasiName;
  final String? downloadKompensasi;
  final List<Map> comments;

  UnfinishedRequest({
    required this.id,
    required this.taskTitle,
    required this.taskDescription,
    this.accDosen,
    this.accKaprodi,
    this.kompensasiName,
    this.downloadKompensasi,
    required this.comments,
  });

  factory UnfinishedRequest.fromJson(Map<String, dynamic> json) {
    List<Map<String, dynamic>> parseComments(dynamic comments) {
      if (comments is List) {
        return List<Map<String, dynamic>>.from(comments);
      } else if (comments is Map) {
        return comments.values
            .map((e) => Map<String, dynamic>.from(e))
            .toList();
      } else {
        return [];
      }
    }

    return UnfinishedRequest(
      id: json['id'],
      taskTitle: json['task_title'],
      taskDescription: json['task_description'],
      accDosen: json['acc_dosen'],
      accKaprodi: json['acc_kaprodi'],
      kompensasiName: json['kompensasi_name'],
      downloadKompensasi: json['download_kompensasi'],
      comments: parseComments(json['comments']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'task_title': taskTitle,
      'task_description': taskDescription,
      'acc_dosen': accDosen,
      'acc_kaprodi': accKaprodi,
      'kompensasi_name': kompensasiName,
      'download_kompensasi': downloadKompensasi,
      'comments': comments,
    };
  }
}
