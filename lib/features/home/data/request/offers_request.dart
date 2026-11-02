class OffersRequest {
  final int page;
  final int pageSize;

  const OffersRequest({
    this.page = 1,
    this.pageSize = 10,
  });

  Map<String, dynamic> toQueryParameters() => {
    'page': page,
    'pageSize': pageSize,
  };

  Map<String, dynamic> toJson() => toQueryParameters();

  @override
  String toString() => 'OffersRequest(page: $page, pageSize: $pageSize)';
}

