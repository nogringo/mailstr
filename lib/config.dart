import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

const appTitle = "Mailstr";

const themeColor = Colors.orangeAccent;

const difficulty = kDebugMode ? 1 : 7;

const unlockPrice = kDebugMode ? 1 : 100;

const emailDomain = "uid.ovh";

const payWithCashuUrl = kDebugMode
    ? 'http://127.0.0.1:5001/mailstr-6a9c4/us-central1/payWithCashu'
    : 'https://paywithcashu-x52eiet4za-uc.a.run.app';

const payWithProofOfWorkUrl = kDebugMode
    ? 'http://127.0.0.1:5001/mailstr-6a9c4/us-central1/payWithProofOfWork'
    : 'https://paywithproofofwork-x52eiet4za-uc.a.run.app';

const trustedMints = [
  "https://mint.coinos.io",
  "https://mint.lnwallet.app",
  "https://mint.lnvoltz.com",
  "https://mint.cubabitcoin.org",
  "https://mint.minibits.cash/Bitcoin",
  "https://mint.0xchat.com",
  "https://mint.lnserver.com",
];

const relays = [
  "wss://purplepag.es",
  "wss://relay.primal.net",
  "wss://relay.damus.io",
  "wss://nos.lol",
  "wss://bwcervpt.mooo.com",
];
