// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get helloWorld => '¡Hola Mundo!';

  @override
  String get emailLocked => 'Email bloqueado';

  @override
  String get emailUnlocked => 'Email desbloqueado';

  @override
  String get emailSuccessfullyUnlocked => '¡Email desbloqueado con éxito!';

  @override
  String get unlockWithProofOfWork => 'Desbloquear con Prueba de Trabajo';

  @override
  String get proofOfWorkDescription =>
      '¡Es como minar Bitcoin!\nTu dispositivo buscará un código, tomará varios minutos y una vez encontrado tu email será desbloqueado.';

  @override
  String get startProofOfWork => 'Iniciar Prueba de Trabajo';

  @override
  String get resumeProofOfWork => 'Reanudar Prueba de Trabajo';

  @override
  String get pauseProofOfWork => 'Pausar Prueba de Trabajo';

  @override
  String get searchingForCode => 'Buscando código...';

  @override
  String nonceAttempts(int nonce) {
    return 'Nonce: $nonce';
  }

  @override
  String get proofOfWorkCompleted => 'Prueba de Trabajo completada';

  @override
  String get unlockWithCashu => 'Desbloquear con Cashu';

  @override
  String get cashuDescription =>
      'Cashu es dinero electrónico para pagos en línea y alrededor del mundo. Es Rápido, Privado, Simple y Seguro.';

  @override
  String pasteCashuTokenHint(int amount, String plural) {
    return 'Pega un token Cashu de $amount sat$plural para desbloquear';
  }

  @override
  String get submitPayment => 'Enviar Pago';

  @override
  String get error => 'Error';

  @override
  String get pleasePasteCashuToken => 'Por favor pega un token Cashu';

  @override
  String get create => 'Crear';

  @override
  String get unlockNow => 'Desbloquear ahora';

  @override
  String get newEmail => 'Nuevo email';

  @override
  String get copyNsec => 'Copiar nsec';

  @override
  String get nostrBasedEmailService => 'Servicio de email basado en Nostr';

  @override
  String get createSecureEmailAddresses =>
      'Crea direcciones de email seguras usando llaves Nostr.';

  @override
  String whyAppTitle(String appTitle) {
    return '¿Por qué $appTitle?';
  }

  @override
  String whyAppTitleDescription(String appTitle) {
    return 'Los proveedores de email tradicionales controlan tus datos y pueden cerrar tu cuenta en cualquier momento. $appTitle es diferente. Basado en el protocolo Nostr, tu dirección de email se genera a partir de llaves criptográficas que solo tú controlas - nadie puede revocar tu identidad.\n\nNunca se te pedirá verificar información personal aquí porque creemos que cualquiera debería tener acceso al email sin requerir conectarlo al creciente estado de vigilancia. Nuestro trabajo aquí está al servicio de esta idea.\n\nMuchos servicios son gratuitos porque se alimentan de tus datos personales para beneficio o control.';
  }

  @override
  String get howCanITrustYou => '¿Cómo puedo confiar en ti?';

  @override
  String trustDescription(String appTitle) {
    return '$appTitle no lee ni escanea el contenido de tu email de ninguna manera, pero es posible para cualquier proveedor de email leer tu email, así que tendrás que confiar en nuestra palabra. Ningún proveedor de \"email encriptado\" está evitando esto: incluso si encriptan el correo entrante antes de almacenarlo, el proveedor aún recibe el email en texto plano primero, lo que significa que solo estás protegido si asumes que nadie estaba leyendo o copiando el email mientras llegaba.';
  }

  @override
  String get noAccounts => 'Sin cuenta';

  @override
  String get noLogs => 'Sin logs';

  @override
  String get justPrivacy => 'Solo privacidad';

  @override
  String get createEmailAddressNow => 'Crear una dirección de email ahora';

  @override
  String get takesLessThan30Seconds =>
      'Toma menos de 30 segundos. No requiere registro.';

  @override
  String get youCanNowReceiveEmails =>
      'Ahora puedes recibir emails en esta dirección.';

  @override
  String get cashuSpace => 'Cashu.space';

  @override
  String get copied => 'Copiado';

  @override
  String get startingProofOfWork => 'Iniciando Prueba de Trabajo...';

  @override
  String resumingProofOfWork(int nonce) {
    return 'Reanudando Prueba de Trabajo desde nonce: $nonce';
  }

  @override
  String proofOfWorkPaused(int nonce) {
    return 'Prueba de Trabajo pausada en nonce: $nonce';
  }

  @override
  String get proofOfWorkReset => 'Prueba de Trabajo reiniciada';

  @override
  String proofOfWorkCompletedWithNonce(int nonce) {
    return '¡Prueba de Trabajo completada! Nonce: $nonce';
  }

  @override
  String searchingWithHashRate(int nonce, String hashRate) {
    return 'Buscando... Nonce: $nonce | Tasa de hash: $hashRate H/s';
  }

  @override
  String errorDecodingNpub(String error) {
    return 'Error decodificando npub: $error';
  }

  @override
  String invalidPubkeyFormat(int length, String isHex) {
    return 'Formato de llave pública inválido: longitud=$length, hex=$isHex';
  }

  @override
  String get invalidEmailFormat => 'Formato de email inválido';

  @override
  String get success => 'Éxito';

  @override
  String get paymentAcceptedEmailUnlocked =>
      '¡Pago aceptado, email desbloqueado!';

  @override
  String get emailUnlockedWithProofOfWork =>
      '¡Email desbloqueado con Prueba de Trabajo!';

  @override
  String get failedToVerifyProofOfWork =>
      'Error al verificar prueba de trabajo';

  @override
  String get failedToConnectToServer => 'Error al conectar con el servidor';

  @override
  String duration(String duration) {
    return 'Duración: $duration';
  }

  @override
  String get home => 'Inicio';

  @override
  String get whereToReadEmails => '¿Dónde leer mis emails?';

  @override
  String get whereToReadEmailsDescription =>
      'Tus emails te son enviados por mensaje privado en Nostr. Puedes leerlos en cualquier aplicación Nostr que soporte mensajes privados como:';

  @override
  String get alreadyHaveNostrAccount =>
      'Ya tengo una cuenta Nostr, ¿puedo recibir mis emails en esta cuenta?';

  @override
  String yesAddDomainToNpub(String domain) {
    return 'Sí, solo tienes que agregar @$domain al final de tu clave pública (Npub) y tienes tu dirección de email.';
  }

  @override
  String get loadingProfile => 'Cargando perfil...';

  @override
  String get goToMailbox => 'Ir al buzón';

  @override
  String get appearance => 'Apariencia';

  @override
  String get logout => 'Cerrar sesión';

  @override
  String get logoutConfirmation =>
      '¿Estás seguro de que quieres cerrar sesión?';

  @override
  String get cancel => 'Cancelar';

  @override
  String get themeMode => 'Modo de tema';

  @override
  String get light => 'Claro';

  @override
  String get dark => 'Oscuro';

  @override
  String get system => 'Sistema';

  @override
  String get accentColor => 'Color de acento';

  @override
  String get defaultColor => 'Predeterminado';

  @override
  String get picture => 'Imagen';

  @override
  String get banner => 'Banner';

  @override
  String get mailbox => 'Buzón';

  @override
  String get login => 'Iniciar sesión';

  @override
  String get createYourAddress => 'Crea tu dirección';

  @override
  String get username => 'nombre de usuario';

  @override
  String get private => 'Privado';

  @override
  String get hideFromPublicDirectory => 'Ocultar del directorio público';

  @override
  String get mailstrLogin => 'Iniciar sesión en Mailstr';

  @override
  String get loginWithNostr => 'Iniciar sesión con Nostr';

  @override
  String get message => 'Mensaje';

  @override
  String get close => 'Cerrar';

  @override
  String copiedToClipboard(String label) {
    return '$label copiado al portapapeles';
  }

  @override
  String get privateKeyWarning =>
      'Tu clave privada (Nsec) es la clave para leer tus emails, guárdala en un lugar seguro como tu gestor de contraseñas.';

  @override
  String get noAccessWithoutNsec =>
      'Sin tu Nsec no tendrás acceso a tus emails.';

  @override
  String get register => 'REGISTRAR';

  @override
  String get connectWithNostr => 'Conectar con Nostr';

  @override
  String get secureDecentralizedAuth =>
      'Autenticación segura y descentralizada';

  @override
  String get signingCapabilityRequired => 'Capacidad de firma requerida';

  @override
  String get nip05AndPubkeyReadOnly =>
      'Los inicios de sesión NIP-05 y pubkey son solo lectura. Use:';

  @override
  String get loginMethodsList =>
      '• Extensión del navegador (Alby, nos2x, etc.)\n• Generar nuevas claves\n• Importar clave privada';

  @override
  String get signInToAccessMailbox => 'Inicia sesión para acceder al buzón';

  @override
  String get toReceiveAndSendMessages =>
      'Para recibir y enviar mensajes encriptados, necesitas iniciar sesión con una cuenta Nostr que pueda firmar mensajes.';

  @override
  String get noMessagesYet => 'No hay mensajes aún';

  @override
  String get noAliasesYet => 'No hay alias aún';

  @override
  String get tapPlusToCreateAlias => 'Toca + para crear tu primer alias';

  @override
  String get limitedView => 'Vista limitada';

  @override
  String get youCanOnlySeeDefaultAliases =>
      'Solo puedes ver los alias predeterminados. Para ver todos tus alias, inicia sesión con capacidad de firma.';

  @override
  String get tapToCopy => 'Toca para copiar';

  @override
  String get useThisAddressAsMyNostrAddress =>
      'Usar esta dirección como mi dirección Nostr';

  @override
  String get unregisterAlias => 'Desregistrar Alias';

  @override
  String get areYouSureUnregister =>
      '¿Estás seguro de que quieres desregistrar';

  @override
  String get aliasUnregistered => 'Alias desregistrado';

  @override
  String get failedToUnregisterAlias => 'Error al desregistrar alias';

  @override
  String get unregister => 'Desregistrar';

  @override
  String get inbox => 'Bandeja de entrada';

  @override
  String get aliases => 'Alias';

  @override
  String get nostrUser => 'Usuario Nostr';

  @override
  String get welcomeToMyNostrProfile => 'Bienvenido a mi perfil Nostr';

  @override
  String get claimYourNip05 =>
      'Reclama tu dirección Nostr NIP-05 ahora y úsala como tu correo electrónico.';

  @override
  String get claim => 'Reclamar';

  @override
  String get switchTo => 'Cambiar a';

  @override
  String get theme => 'tema';

  @override
  String get free => 'Gratis';

  @override
  String get freeDescription => 'Sin cargos, sin tarifas ocultas';

  @override
  String get noSubscription => 'Sin suscripción';

  @override
  String get noSubscriptionDescription => 'Usa sin pagos mensuales';

  @override
  String get noLogsFeature => 'Sin registros';

  @override
  String get noLogsDescription => 'Tu privacidad está protegida';

  @override
  String get unlimitedAccounts => 'Cuentas ilimitadas';

  @override
  String get unlimitedAccountsDescription => 'Crea tantas como necesites';

  @override
  String get nostrBased => 'Basado en Nostr';

  @override
  String get nostrBasedDescription =>
      'Construido sobre protocolo descentralizado';

  @override
  String get anonymous => 'Anónimo';

  @override
  String get anonymousDescription => 'No se requiere información personal';

  @override
  String get openSourceClient => 'Cliente de código abierto';

  @override
  String get openSourceClientDescription => 'Transparente y auditable';
}
