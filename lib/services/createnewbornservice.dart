import 'dart:developer';

import 'package:english_words/english_words.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/local/preferences.dart';

import '../data/models/create_new_born_resquest/attributes.dart';
import '../data/models/create_new_born_resquest/create_new_born_resquest.dart';
import '../data/models/create_new_born_resquest/data.dart';
import 'package:http/http.dart' as http;

Future createNewborn() async {
  final prefs = PreferencesImpl(prefs: await SharedPreferences.getInstance());

  final count = await prefs.getNewBornsCreated();
  if (prefs.hasToken()) {
    final res = await http.post(
      Uri.parse("https://ubenwa-cat-api-stage.herokuapp.com/api/v1/newborns"),
      headers: {
        "Authorization": "Bearer ${await prefs.getTokenFromPrefs()}",
        "Content-Type": "application/vnd.api+json"
      },
      body: CreateNewBornResquest(
        data: Data(
          type: "newborns",
          attributes: Attributes(
            gestation: DateTime.now(),
            gender: count % 2 == 0 ? "male" : "female",
            name: WordPair.random().join(" "),
          ),
        ),
      ).toJson(),
    );
    log(res.body);
    await prefs.updateNewBornCount();
  } else {
    log("Not logged in");
  }
}
