import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({this.id, required this.categoryName});

  final int? id;
  final String categoryName;

  Map<String, dynamic> toMap() {
    return {'id': id, 'categoryName': categoryName};
  }

  @override
  List<Object?> get props => [
        id,
        categoryName,
      ];
}
