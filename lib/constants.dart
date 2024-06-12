import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final kApiKey = dotenv.env['API_KEY'];
const kUserCollection = 'users';
const kTopicsCollection = 'topics';
const kMessagesCollection = 'messages';
const kNoInternetMessage = "CONNECT TO INTERNET";
const kPrimaryColor = Color(0xff1A2130);
const kSecondaryColor = Color(0xff5A72A0);
const kSecondaryColor2 = Color(0xff7ba1e0);
