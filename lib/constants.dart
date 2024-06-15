import 'dart:ui';

import 'package:flutter_dotenv/flutter_dotenv.dart';

final kApiKey = dotenv.env['API_KEY'];
const kUserCollection = 'users';
const kTopicsCollection = 'topics';
const kMessagesCollection = 'messages';
const kNoInternetMessage = "CONNECT TO INTERNET";
const kPrimaryColor = Color(0xff2C4E80);
const kSecondaryColor = Color(0xff00215E);
const kSecondaryColor2 = Color(0xffFFC55A);
