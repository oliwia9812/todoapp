import 'package:equatable/equatable.dart';

class CategoryModel extends Equatable {
  final int? id;
  final String categoryName;
  bool isSelected;

  CategoryModel({
    this.id,
    required this.categoryName,
    this.isSelected = false,
  });

  CategoryModel copyWith({
    int? id,
    String? categoryName,
    bool? isSelected,
  }) {
    return CategoryModel(
      id: id ?? this.id,
      categoryName: categoryName ?? this.categoryName,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'categoryName': categoryName,
      'isSelected': isSelected,
    };
  }

  @override
  List<Object?> get props => [
        id,
        categoryName,
        isSelected,
      ];
}
