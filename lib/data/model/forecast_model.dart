import 'forecast_item_model.dart';

class ForecastModel {
  final List<ForecastItemModel> items;

  ForecastModel({required this.items});

  factory ForecastModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> list = json['list'];
    final items = list.map((e) => ForecastItemModel.fromJson(e)).toList();
    return ForecastModel(items: items);
  }
}
