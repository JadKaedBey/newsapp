import 'package:json_annotation/json_annotation.dart';
import 'package:intl/intl.dart';

part 'article.g.dart';

@JsonSerializable()
class Article {
  final Source source; // Nested object
  final String? author;
  final String? title;
  final String? description;
  final String? url;
  @JsonKey(name: 'urlToImage')
  final String? urlToImage;
  final String? publishedAt;
  final String? content;

  Article({
    required this.source, // source is required as per API response
    this.author,
    this.title,
    this.description,
    this.url,
    this.urlToImage,
    this.publishedAt,
    this.content,
  });

  factory Article.fromJson(Map<String, dynamic> json) => _$ArticleFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  /// Getter to format the publishedAt date
  String get formattedPublishedAt {
    if (publishedAt == null) return 'Unknown'; // Handle null case
    try {
      final date = DateTime.parse(publishedAt!);
      return DateFormat('yyyy-MM-dd HH:mm').format(date);
    } catch (e) {
      return 'Invalid date'; // Handle invalid date format
    }
  }
}

@JsonSerializable()
class Source {
  final String? id;
  final String? name;

  Source({this.id, this.name});

  factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

  Map<String, dynamic> toJson() => _$SourceToJson(this);
}
