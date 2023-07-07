String spacingDateToNow(DateTime time) {
  Duration spacing = DateTime.now().difference(time);
  if(spacing.inDays > 0){
    return "${spacing.inDays} ngày trước";
  }else if(spacing.inHours > 0){
    return "${spacing.inHours} giờ trước";
  }else if(spacing.inHours > 0){
    return "${spacing.inHours} phút trước";
  }else{
    return "Vừa xong";
  }
}