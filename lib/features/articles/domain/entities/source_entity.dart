import 'package:equatable/equatable.dart';

class SourceEntity extends Equatable {
  final String name;
  final String url;

  const SourceEntity({
    required this.name,
    required this.url,
  });

  SourceEntity copyWith({
    String? name,
    String? url,
  }) {
    return SourceEntity(
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  @override
  List<Object?> get props => [name, url];
}
