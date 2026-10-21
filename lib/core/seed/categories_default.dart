import 'package:my_finance/core/data/enums/flow_type.dart';
import 'package:my_finance/features/category/domain/entities/category.dart';

abstract final class CategoriesDefault {
  static final List<Category> expenses = [
    Category(
      id: "food",
      name: "Alimentação",
      emoji: "🍽️",
      colorHex: "#E24B4A",
      isDefault: true,
      type: FlowType.expense,
    ),
    Category(
      id: "transport",
      name: "Transporte",
      emoji: "🚗",
      colorHex: "#378ADD",
      isDefault: true,
      type: FlowType.expense,
    ),
    Category(
      id: "health",
      name: "Saúde",
      emoji: "🏥",
      colorHex: "#1D9E75",
      isDefault: true,
      type: FlowType.expense,
    ),
    Category(
      id: "education",
      name: "Educação",
      emoji: "🎓",
      colorHex: "#7F77DD",
      isDefault: true,
      type: FlowType.expense,
    ),
    Category(
      id: "leisure",
      name: "Lazer",
      emoji: "🏋️",
      colorHex: "#EF9F27",
      isDefault: true,
      type: FlowType.expense,
    ),
    Category(
      id: "shopping",
      name: "Compras",
      emoji: "🛒",
      colorHex: "#D4537E",
      isDefault: true,
      type: FlowType.expense,
    ),
  ];

  static final List<Category> income = [
    Category(
      id: "salary",
      name: "Salário",
      emoji: "💼",
      colorHex: "#10C225",
      isDefault: true,
      type: FlowType.income,
    ),
    Category(
      id: "investment",
      name: "Investimentos",
      emoji: "📈",
      colorHex: "#760CC7",
      isDefault: true,
      type: FlowType.income,
    ),
    Category(
      id: "bonus",
      name: "Bônus",
      emoji: "🎁",
      colorHex: "#2A23E2",
      isDefault: true,
      type: FlowType.income,
    ),
  ];

  static List<Category> get all => [...expenses, ...income];

  static Category getById(String id) {
    return all.firstWhere(
      (cat) => cat.id == id,
      orElse: () => expenses.first,
    );
  }
}