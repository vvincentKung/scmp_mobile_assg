class FetchStaffListRequest {
  final int page;
  const FetchStaffListRequest({
    this.page = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      'page': page,
    };
  }
}