class HttpService {
  static const baseUrl = 'https://spiska.pythonanywhere.com';

  // Future<dynamic> getRequest() async {
  //   Person person = HiveDB.loadPerson();
  //   try {
  //     // user id berilsa o'zi azo dokonlarni olib kelib beradi.
  //     var url = Uri.parse(
  //         'https://spiska.pythonanywhere.com/api/shop/?id=${person.id}');
  //     var response = await http.get(
  //       url,
  //     );
  //     if (response.statusCode == 200) {
  //       Shops shops =
  //       Shops.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  //       return (shops.data as List<Shop>)
  //           .map((e) => Shop.fromJson(e.toJson()))
  //           .toList();
  //     }
  //   } on SocketException {
  //     throw const SocketException('NO internet');
  //   } catch (error) {
  //     throw Exception(error.toString());
  //   }
  //   return [];
  // }

  Future postRequest() async {}
}
