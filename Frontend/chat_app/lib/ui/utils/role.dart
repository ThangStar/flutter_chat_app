class Role {
  static List<Map<String, String>> myComment = [
    {"content": "Chỉnh sửa", "value": "edit"},
    {"content": "Xóa", "value": "delete"},
    {"content": "Ẩn", "value": "hide"},
  ];
  static List<Map<String, String>> otherComment = List.from(myComment)
    ..removeWhere((element) => element["value"] == "delete" || element["value"] == "edit");
}
