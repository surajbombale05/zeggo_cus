class LikeToggleResponse {
  final bool status;
  final String message;

  LikeToggleResponse({
    required this.status,
    required this.message,
  });

  factory LikeToggleResponse.fromJson(Map<String, dynamic> json) {
    return LikeToggleResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
    };
  }

  /// Helper getters
  bool get isLiked => message.toLowerCase().contains('liked');
  bool get isUnliked => message.toLowerCase().contains('unliked');
}
