/*Yara❤️*/
class CategoriesModel {
  final int categoryId;
  final String? categoryImage;
  final String categoryName;

  const CategoriesModel({
    required this.categoryId,
    required this.categoryImage,
    required this.categoryName,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      categoryId: json['categoryId'] as int,
      categoryImage: json['categoryImage'] as String?,
      categoryName: json['categoryName'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
        'categoryId': categoryId,
        'categoryImage': categoryImage,
        'categoryName': categoryName,
      };

  @override
  List<Object?> get props => [categoryId, categoryImage, categoryName];
}
