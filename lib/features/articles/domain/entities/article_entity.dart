import 'package:equatable/equatable.dart';
import 'package:echo/features/articles/domain/entities/source_entity.dart';

class ArticleEntity extends Equatable {
  final int? id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final SourceEntity source;

  const ArticleEntity({
    this.id,
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  ArticleEntity copyWith({
    int? id,
    String? title,
    String? description,
    String? content,
    String? url,
    String? imageUrl,
    DateTime? publishedAt,
    SourceEntity? source,
  }) {
    return ArticleEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      content: content ?? this.content,
      url: url ?? this.url,
      imageUrl: imageUrl ?? this.imageUrl,
      publishedAt: publishedAt ?? this.publishedAt,
      source: source ?? this.source,
    );
  }

  @override
  List<Object?> get props => [id, title, description, content, url, imageUrl, publishedAt, source];
}
