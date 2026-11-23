import '../models/localized_text.dart';

/// Shared recipe tags. The English text is the stable filter key.
abstract final class RecipeTags {
  static const egyptian = LocalizedText('Egyptian', 'مصري');
  static const chicken = LocalizedText('Chicken', 'فراخ');
  static const meat = LocalizedText('Meat', 'لحمة');
  static const vegetables = LocalizedText('Vegetables', 'خضار');
  static const pasta = LocalizedText('Pasta', 'مكرونة');
  static const rice = LocalizedText('Rice', 'رز');
  static const eggs = LocalizedText('Eggs', 'بيض');
  static const potatoes = LocalizedText('Potatoes', 'بطاطس');
  static const sauce = LocalizedText('Sauce', 'صوص');
  static const spicy = LocalizedText('Spicy', 'حار');
  static const tomato = LocalizedText('Tomato', 'طماطم');
  static const breakfast = LocalizedText('Breakfast', 'فطار');
  static const vegan = LocalizedText('Vegan', 'فيجن');
  static const mexican = LocalizedText('Mexican', 'مكسيكي');
  static const beans = LocalizedText('Beans', 'بقوليات');
  static const sweet = LocalizedText('Sweet', 'حلو');
  static const lentils = LocalizedText('Lentils', 'عدس');
  static const soup = LocalizedText('Soup', 'شوربة');
  static const bread = LocalizedText('Bread', 'عيش');
  static const grill = LocalizedText('Grill', 'مشويات');
  static const fried = LocalizedText('Fried', 'مقلي');
  static const oven = LocalizedText('Oven', 'فرن');
  static const tagine = LocalizedText('Tagine', 'طواجن');
}
