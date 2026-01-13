import 'dart:io';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class HttpSSLPinning {
  static Future<http.Client> get client async {
    final sslCert = await rootBundle.load('certificates/tmdb.pem');

    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext.setTrustedCertificatesBytes(sslCert.buffer.asUint8List());

    HttpClient httpClient = HttpClient(context: securityContext);

    httpClient.badCertificateCallback =
        (X509Certificate cert, String host, int port) {
          return false;
        };

    return IOClient(httpClient);
  }
}
