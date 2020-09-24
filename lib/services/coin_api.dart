import 'package:bitcoin_ticker/services/network.dart';

const apiKey = ""; // TODO set coin api key;
const baseUrl = "https://rest.coinapi.io/v1";

class CoinApi {
  Future<String> getSpecificRate(String currency, String crypto) async {
    NetworkHelper networkHelper = NetworkHelper(
        url: "$baseUrl/exchangerate/$crypto/$currency?apikey=$apiKey");

    try {
      var data = await networkHelper.getData();

      double changeValue = data['rate'];

      return changeValue.toStringAsFixed(2);
    } catch (e) {
      return "Error";
    }
  }
}
