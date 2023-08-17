import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../../common/common.dart';
import '../../core/core.dart';

class FoodModel {
  final int id;
  final String name;
  final String content;
  final double price;
  final int? comments;
  final int score;
  final String? thumbnail;
  final List<String>? covers;
  final double discount;
  final FoodTag tag;
    bool isLiked;

  String get discountInP => makePricePersian(discount.toString());
  double get priceWithDiscount => price - (discount / 100) * price;
  String get showPrice => makePricePersian(price.toString().split('.')[0]);
  String get showPriceWithDiscount =>
      makePricePersian(priceWithDiscount.toString().split('.')[0]);

  FoodModel({
    required this.id,
    required this.name,
    required this.content,
    required this.price,
    this.comments = 0,
    this.score = 0,
    this.thumbnail,
    this.covers,
    this.discount = 0,
    this.tag = FoodTag.normal,
    this.isLiked = false,
  });

  FoodModel copyWith({
    int? id,
    String? name,
    String? content,
    double? price,
    int? comments,
    int? score,
    String? thumbnail,
    List<String>? covers,
    double? discount,
    FoodTag? tag,
    bool? isLiked,
  }) {
    return FoodModel(
      id: id ?? this.id,
      name: name ?? this.name,
      content: content ?? this.content,
      price: price ?? this.price,
      comments: comments ?? this.comments,
      score: score ?? this.score,
      thumbnail: thumbnail ?? this.thumbnail,
      covers: covers ?? this.covers,
      discount: discount ?? this.discount,
      tag: tag ?? this.tag,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'id': id});
    result.addAll({'name': name});
    result.addAll({'content': content});
    result.addAll({'price': price});
    if(comments != null){
      result.addAll({'comments': comments});
    }
    result.addAll({'score': score});
    if(thumbnail != null){
      result.addAll({'thumbnail': thumbnail});
    }
    if(covers != null){
      result.addAll({'covers': covers});
    }
    result.addAll({'discount': discount});
    result.addAll({'tag': tag});
    result.addAll({'isLiked': isLiked});

    return result;
  }

  factory FoodModel.fromMap(Map<String, dynamic> map) {
    return FoodModel(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      content: map['content'] ?? '',
      price: map['price']?.toDouble() ?? 0.0,
      comments: map['comments']?.toInt(),
      score: map['score']?.toInt() ?? 0,
      thumbnail: map['thumbnail'],
      covers: List<String>.from(map['covers']),
      discount: map['discount']?.toDouble() ?? 0.0,
      tag: FoodTag.normal,
      isLiked: map['isLiked'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FoodModel.fromJson(String source) =>
      FoodModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FoodModel(id: $id, name: $name, content: $content, price: $price, comments: $comments, score: $score, thumbnail: $thumbnail, covers: $covers, discount: $discount, tag: $tag, isLiked: $isLiked)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FoodModel &&
      other.id == id &&
      other.name == name &&
      other.content == content &&
      other.price == price &&
      other.comments == comments &&
      other.score == score &&
      other.thumbnail == thumbnail &&
      listEquals(other.covers, covers) &&
      other.discount == discount &&
      other.tag == tag &&
      other.isLiked == isLiked;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      content.hashCode ^
      price.hashCode ^
      comments.hashCode ^
      score.hashCode ^
      thumbnail.hashCode ^
      covers.hashCode ^
      discount.hashCode ^
      tag.hashCode ^
      isLiked.hashCode;
  }
}
