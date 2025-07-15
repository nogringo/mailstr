import 'package:flutter/foundation.dart';

const difficulty = kDebugMode ? 1 : 6;

const unlockPrice = 100;

const emailDomain = "shakerbrain.com";

const payWithCashuUrl = kDebugMode
    ? 'http://127.0.0.1:5001/mailstr-6a9c4/us-central1/payWithCashu'
    : 'http://127.0.0.1:5001/mailstr-6a9c4/us-central1/payWithCashu';

const payWithProofOfWorkUrl = kDebugMode
    ? 'http://127.0.0.1:5001/mailstr-6a9c4/us-central1/payWithProofOfWork'
    : 'http://127.0.0.1:5001/mailstr-6a9c4/us-central1/payWithProofOfWork';

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
