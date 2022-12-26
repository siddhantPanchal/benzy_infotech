import 'dart:convert';

import 'package:benzy_infotech/model/food_delivery.dart';
import 'package:http/http.dart' as http;

class Controller {
  Future<FoodDelivery> getReport(int? month) async {
    month ??= DateTime.now().month;
    print(month);
    try {
      var headersList = {
        'Authorization':
            'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxIiwianRpIjoiMjI2Zjc5NTNkOWU4Mjk1YTJiMmE3MjIyNTM2ZTlmYjgxM2YwNGJmNGEzNWUwNDNmNDMwMjBhOWFmNjU1MWQzNjU3Y2YwNzliZTcyMGQwNWUiLCJpYXQiOjE2NzA5MTY2NzkuNTg4NDE4MDA2ODk2OTcyNjU2MjUsIm5iZiI6MTY3MDkxNjY3OS41ODg0MjM5NjczNjE0NTAxOTUzMTI1LCJleHAiOjE3MDI0NTI2NzkuNTI1NTYyMDQ3OTU4Mzc0MDIzNDM3NSwic3ViIjoiMTEwIiwic2NvcGVzIjpbXX0.rs5Tk61lQN_YEt3E2XxlbdKQqpuG3RAN7LcFH5WCgaEJKXOOGZ70NP7y01mDZNsrFbksz708xMeBKZXK9rkPnuOJPztc85y3mrEbWM4yBw25JzGeuOeFK-0rT2NCFXaS1XHkT8iYfnpNS6eDQjfPuRLgeTntnSwzGnVj0U0r1abHKHPhSxd1j9sQ_H3yvmj3leLsEtiOV1AK_wv1JN7mQFABrZZqmf8X2HjQz7ZwUs8V0jDhFhlsOE5W7NLmiliX-crm1NPM47dt2pik1i8HWs1i70Vf34wP0fEsaD0A2RBpF8qfgMjLxODMW0AOQ1QkZB5N3evaSJKBK2MzWGDnOLZgqwQlr0DQEeUik0eqASLcLG3XQjtqwg2IApCuQiQjLYl12iPoNfYeaFpucsof2AYoeZwG_iUDGaxm960xDTxTil6pht4gi1wGzensQ9xYGfiqTo8oCD2Lh_IijbYf5XlTum7wmUA65CQhWYc7LG9QEhDas2s0QIuPnTKSnLATlNF87lJyal_K-39VS6fbadvoqCEq9PEjMzinwMgF7yQJijl05E6HsUuwOO21jGnOqg5Xlfzdk-mRga1hi7QJo_TgO22jWL9jRJVIjaLxrCQPgJm3n3u7CiWZ9OWh3Eb1d6RGIWsQ7FAj8yECujiiP2jg_5bP3vEIHf2JsP7tIS8',
        'Content-Type': 'application/json'
      };
      var url =
          Uri.parse('http://canteen.benzyinfotech.com/api/v3/customer/report');

      var body = {"month": month};

      var req = http.Request('POST', url);
      req.headers.addAll(headersList);
      req.body = json.encode(body);

      var res = await req.send();
      final resBody = await res.stream.bytesToString();

      if (res.statusCode >= 200 && res.statusCode < 300) {
        return FoodDelivery.fromJson(resBody);
      } else {
        throw Exception(resBody);
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
