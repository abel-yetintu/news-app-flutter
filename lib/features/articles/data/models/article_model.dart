import 'package:echo/core/utils/mapper.dart';
import 'package:echo/features/articles/data/models/source_model.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class ArticleModel extends DataMapper<ArticleEntity> with EquatableMixin {
  final String title;
  final String description;
  final String content;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final SourceModel source;

  ArticleModel({
    required this.title,
    required this.description,
    required this.content,
    required this.url,
    required this.imageUrl,
    required this.publishedAt,
    required this.source,
  });

  factory ArticleModel.fromMap(Map<String, dynamic> map) {
    return ArticleModel(
      title: map['title'],
      description: map['description'],
      content: map['content'],
      url: map['url'],
      imageUrl: map['image'],
      publishedAt: DateTime.parse(map['publishedAt']),
      source: SourceModel.fromMap(map['source']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'image': imageUrl,
      'publishedAt': publishedAt.toIso8601String(),
      'source': source.toMap()
    };
  }

  @override
  ArticleEntity mapToEntity() {
    return ArticleEntity(
      title: title,
      description: description,
      content: content,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      source: source.mapToEntity(),
    );
  }

  @override
  List<Object?> get props => [title, description, content, url, imageUrl, publishedAt, source];
}
