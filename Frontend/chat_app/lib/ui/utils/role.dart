class Role {
  static List<Map<String, String>> myComment = [
    {"content": "Chỉnh sửa", "value": "edit"},
    {"content": "Xóa", "value": "delete"},
    {"content": "Ẩn", "value": "hide"},
  ];
  static List<Map<String, String>> otherComment = List.from(myComment)
    ..removeWhere((element) =>
        element["value"] == "delete" || element["value"] == "edit");
  static List<Map<String, String>> myPost = [
    {
      "content": "Chỉnh sửa",
      "value": "edit",
    },
    {
      "content": "Xóa",
      "value": "delete",
    },
    {"content": "Ẩn bài đăng này", "value": 'hide'}
  ];

  static List<Map<String, String>> otherPost = List.from(myPost)
    ..removeWhere((element) =>
        element["value"] == "delete" || element["value"] == "edit");

  static List<Map<String, dynamic>> post = [
    {"label": 'Xóa bài', "value": "delete"},
    {"label": "Sửa", "value": "edit"},
    {"label": "Ẩn", "value": "hide"}
  ];
}
