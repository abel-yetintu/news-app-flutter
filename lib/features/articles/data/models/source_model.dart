import 'package:echo/core/utils/mapper.dart';
import 'package:echo/features/articles/domain/entities/source_entity.dart';
import 'package:equatable/equatable.dart';

class SourceModel extends DataMapper<SourceEntity> with EquatableMixin {
  final String name;
  final String url;

  SourceModel({required this.name, required this.url});

  factory SourceModel.fromMap(Map<String, dynamic> map) {
    return SourceModel(name: map['name'], url: map['url']);
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'url': url,
    };
  }

  @override
  mapToEntity() {
    return SourceEntity(name: name, url: url);
  }

  @override
  List<Object?> get props => [name, url];
}
