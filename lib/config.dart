import 'package:flutter/material.dart';
import 'package:mailstr/constant.dart';

const appTitle = "Mailstr";

Color defaultThemeColor = Colors.orangeAccent;

const difficulty = debugMode ? 1 : 7;

const unlockPrice = debugMode ? 1 : 100;

const emailDomain = "uid.ovh";

const serverPubkey =
    "0d365385f474d4b025377b4ade6ad241f847d514a9e9b475069f69a20f886c68";

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

// API endpoints - based on Firebase hosting configuration
const baseUrl = debugMode ? "http://localhost:5000" : "https://uid.ovh";
const unlockWithCashuUrl = "$baseUrl/api/unlock/cashu";
const unlockWithProofOfWorkUrl = "$baseUrl/api/unlock/proof-of-work";
const addAddressUrl = "$baseUrl/api/addresses/add";
const removeAddressUrl = "$baseUrl/api/addresses/remove";
const getAddressesByPubkeyUrl = "$baseUrl/api/addresses/get-by-pubkey";
