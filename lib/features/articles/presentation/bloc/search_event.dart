sealed class SearchEvent {}

final class RequestSearch extends SearchEvent {
  final String query;

  RequestSearch({required this.query});
}

final class ClearSearch extends SearchEvent {}
