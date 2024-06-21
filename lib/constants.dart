import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final kApiKey = dotenv.env['API_KEY'];
const kUserCollection = 'users';
const kTopicsCollection = 'topics';
const kMessagesCollection = 'messages';
const kNoInternetMessage = "CONNECT TO INTERNET";
const kPrimaryColor = Color(0xff0B2447);
const kSecondaryColor = Color(0xff19376D);
const kSecondaryColor2 = Color(0xff576CBC);