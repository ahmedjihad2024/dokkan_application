class ReviewsRequest {
  final int page;
  final int pageSize;

  const ReviewsRequest({
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toJson() => {
    'page': page,
    'pageSize': pageSize,
  };

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'pageSize': pageSize,
  };

  @override
  String toString() => 'ReviewsRequest(page: $page, pageSize: $pageSize)';
}

