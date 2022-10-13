const String appVersion = "1.1.5";

const bool production = true;
const bool serverHttps = false;

///
/// Informações do Servidor
///

const String serverHost = production ? "192.168.0.9" : "360panel.webevent.com.br";
const String serverPath = production ? "/appservice/" : "appservice/";
const int? serverPort   = production == true ? 8585 : null;

const String serverUrl  = ((serverHttps) ? 'https://' : 'http://') + serverHost + (production ? ":$serverPort" : "") + serverPath;
const String siteUrl    = ((serverHttps) ? 'https://' : 'http://') + serverHost + (production ? ":$serverPort" : "") + serverPath;

///
/// SQLite
///
const dbName = "web360app";


///
/// Firebase
///
const String firebaseToken = "AAAAzuKBHMM:APA91bENm0nVmO6P17bw-Qa3ResY2kHw1RoDiKDHSmzf873Z4UQgICSg5nNXnkx4oluavGb6l0FlrN1LtNkmj63Tit_FiZ-sse4psCz3qLWlzFcYeY-Fp-v4kzWWm5k1EVHdA0l5NMAX";

///
/// Paginação
///
const itensPerPage = 20;