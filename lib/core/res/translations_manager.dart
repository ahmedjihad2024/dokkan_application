// ignore_for_file: constant_identifier_names

enum Translation {
  loading('Loading...'),
  no_more('No more items'),
  failed_loading('Failed to load'),
  load_more('Pull up to load more');

  final String tr;
  const Translation(this.tr);
}
