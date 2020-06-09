import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'l10n/messages_all.dart';


class AppLocalizations {
  static Future<AppLocalizations> load(Locale locale) {
    final String name =
    locale.countryCode == null ? locale.languageCode : locale.toString();
    final String localeName = Intl.canonicalizedLocale(name);

    return initializeMessages(localeName).then((bool _) {
      Intl.defaultLocale = localeName;
      return new AppLocalizations();
    });
  }

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  String get title {
    return Intl.message('Hello world App',
        name: 'title', desc: 'The application title');
  }
  String get titleapp {
    return Intl.message('Guest Registration Card',
        name: 'titleapp', desc: 'The application title');
  }
  String get user {
    return Intl.message('User',
        name: 'user', desc: 'User title');
  }
  String get password {
    return Intl.message('Password',
        name: 'password', desc: 'Password title');
  }

  String get hello {
    return Intl.message('Hello', name: 'hello');
  }

  String get llegadasprobables {
    return Intl.message('Llegadas Probables', name: 'llegadasprobables');
  }
  String get encasa {
    return Intl.message('En Casa', name: 'encasa');
  }

  String get botonaceptar {
    return Intl.message('Aceptar', name: 'botonaceptar');
  }
  String get titulofirma {
    return Intl.message('Ingrese a su cuenta', name: 'titulofirma', desc: 'Ingrese a su cuenta');
  }
  String get olvidopassword {
    return Intl.message('Olvidaste tu contraseña?', name: 'olvidopassword', desc: 'Olvidaste tu contraseña?');
  }
  String get botonentrar1 {
    return Intl.message('Entrar', name: 'botonentrar1', desc: 'Entrar');
  }
  String get filtro {
    return Intl.message('Search', name: 'filtro', desc: 'Search');
  }
  String get reservafiltro {
    return Intl.message('Reserva: ', name: 'reservafiltro', desc: 'Reserva: ');
  }
  String get nombrefiltro {
    return Intl.message('Nombre: ', name: 'nombrefiltro', desc: 'Nombre: ');
  }
  String get botonverificacion {
    return Intl.message('Continuar', name: 'botonverificacion', desc: 'Continuar');
  }
  String get reservadatos {
    return Intl.message('Reserva', name: 'reservadatos', desc: 'Reserva');
  }
  String get fechallegadadatos {
    return Intl.message('Fecha de Llegada', name: 'fechallegadadatos', desc: 'Fecha de Llegada');
  }
  String get fechasalidadatos {
    return Intl.message('Fecha de Salida', name: 'fechasalidadatos', desc: 'Fecha de Salida');
  }
  String get adolescentedatos {
    return Intl.message('Adol', name: 'adolescentedatos', desc: 'Adol');
  }
  String get npagdatos {
    return Intl.message('NPag', name: 'npagdatos', desc: 'NPag');
  }
  String get ngradatos {
    return Intl.message('NGra', name: 'ngradatos', desc: 'NGra');
  }
  String get nombredatos {
    return Intl.message('Nombre', name: 'nombredatos', desc: 'Nombre');
  }
  String get apellidodatos {
    return Intl.message('Apellido', name: 'apellidodatos', desc: 'Apellido');
  }
  String get ciudaddatos {
    return Intl.message('Ciudad', name: 'ciudaddatos', desc: 'Ciudad');
  }
  String get cpdatos {
    return Intl.message('Codigo Postal', name: 'cpdatos', desc: 'Codigo Postal');
  }
  String get emaildatos {
    return Intl.message('Email', name: 'emaildatos', desc: 'Email');
  }
  String get telefonodatos {
    return Intl.message('Telefono', name: 'telefonodatos', desc: 'Telefono');
  }
  String get botondatos {
    return Intl.message('Continuar', name: 'botondatos', desc: 'Continuar');
  }

}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) {
    return AppLocalizations.load(locale);
  }

  @override
  bool shouldReload(LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}

