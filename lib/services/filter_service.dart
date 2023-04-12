import 'package:admin_project/models/house_model.dart';

class FilterService {
  List<House> filterHouses(List<House> houseList, filter) {
    List<House> filteredHouse = houseList;
    // for (String filter in filterList) {
    if (filter.startsWith('<\$')) {
      int price = int.parse(filter.substring(2));
      filteredHouse = filteredHouse.where((p) => p.price < price).toList();
    }
    else if (filter.endsWith('bedrooms') || filter.endsWith('bedroom')) {
      int bedrooms = int.parse(filter[0]);
      filteredHouse = filteredHouse.where((p) => p.bedrooms == bedrooms).toList();
    }
    // }
    return filteredHouse;
  }
}
