import 'package:meta/meta.dart';

/// Articles event.
@immutable
abstract class ArticlesEvent {
}

/// LoadMoreArticlesEvent event.
class LoadMoreArticlesEvent extends ArticlesEvent {
  LoadMoreArticlesEvent({
    @required this.searchCriteria,
  });

  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'LoadMoreArticlesEvent { }';
}

/// RefreshArticlesEvent event.
class RefreshArticlesEvent extends ArticlesEvent {
  RefreshArticlesEvent({
    @required this.searchCriteria,
  });

  final Map<String, dynamic> searchCriteria;

  @override
  String toString() => 'RefreshArticlesEvent { }';
}

/// LoadArticleEvent event.
class LoadArticleEvent extends ArticlesEvent {
  LoadArticleEvent(this.id);

  final String id;

  @override
  String toString() => 'LoadArticleEvent { }';
}
