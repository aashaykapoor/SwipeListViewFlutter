
import 'package:geolocator/geolocator.dart';

class LocationService {
 
  Future<Position> getCurrentLocation() async {
    Position position =
        await getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    return position;
  }

}
