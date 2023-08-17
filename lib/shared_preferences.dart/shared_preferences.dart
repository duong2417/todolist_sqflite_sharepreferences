import 'package:shared_preferences/shared_preferences.dart';

class SharedPREFERENCES{
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
 void storedSoCOT (int soCotCURRENT) async {
      final SharedPreferences prefs = await _prefs;//ko là nó đỏ setInt()

await prefs.setInt('soCotCurrent', soCotCURRENT);

}
Future<int> getSoCotCURRENT ()async{
      final SharedPreferences prefs = await _prefs;//ko là nó đỏ setInt()

return (prefs.getInt('soCotCurrent') ?? 1);

}
}