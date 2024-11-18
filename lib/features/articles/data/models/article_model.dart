import 'package:echo/core/utils/mapper.dart';
import 'package:echo/features/articles/data/models/source_model.dart';
import 'package:echo/features/articles/domain/entities/article_entity.dart';
import 'package:equatable/equatable.dart';

class ArticleModel extends DataMapper<ArticleEntity> with EquatableMixin {
  final int? id;
  final String title;
  final String description;
  final String content;
  final String url;
  final String imageUrl;
  final DateTime publishedAt;
  final SourceModel source;

  ArticleModel({
    this.id,
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

  factory ArticleModel.fromDB(Map<String, dynamic> map) {
    return ArticleModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      content: map['content'],
      url: map['url'],
      imageUrl: map['image'],
      publishedAt: DateTime.fromMillisecondsSinceEpoch(map['publishedAt']),
      source: SourceModel(name: map['sourceName'], url: map['sourceUrl']),
    );
  }

  Map<String, dynamic> toDB() {
    return {
      'title': title,
      'description': description,
      'content': content,
      'url': url,
      'image': imageUrl,
      'publishedAt': publishedAt.millisecondsSinceEpoch,
      'sourceName': source.name,
      'sourceUrl': source.url
    };
  }

  @override
  ArticleEntity mapToEntity() {
    return ArticleEntity(
      id: id,
      title: title,
      description: description,
      content: content,
      url: url,
      imageUrl: imageUrl,
      publishedAt: publishedAt,
      source: source.mapToEntity(),
    );
  }

  factory ArticleModel.fromEntitiy({required ArticleEntity entity}) {
    return ArticleModel(
      id: entity.id,
      title: entity.title,
      description: entity.description,
      content: entity.content,
      url: entity.url,
      imageUrl: entity.imageUrl,
      publishedAt: entity.publishedAt,
      source: SourceModel(name: entity.source.name, url: entity.source.url),
    );
  }

  @override
  List<Object?> get props => [title, description, content, url, imageUrl, publishedAt, source];
}
