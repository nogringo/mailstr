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
  String get payWithProofOfWork => 'Pagar con Prueba de Trabajo';

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
  String get payWithCashu => 'Pagar con Cashu';

  @override
  String get cashuDescription =>
      'Cashu es dinero electrónico para pagos en línea, en persona y alrededor del mundo. Es Rápido, Privado, Simple y Seguro.';

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
  String get payNow => 'Pagar ahora';

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
    return 'No puedes. $appTitle no lee ni escanea el contenido de tu email de ninguna manera, pero es posible para cualquier proveedor de email leer tu email, así que tendrás que confiar en nuestra palabra. Ningún proveedor de \"email encriptado\" está evitando esto: incluso si encriptan el correo entrante antes de almacenarlo, el proveedor aún recibe el email en texto plano primero, lo que significa que solo estás protegido si asumes que nadie estaba leyendo o copiando el email mientras llegaba.';
  }

  @override
  String get noAccounts => 'Sin cuentas';

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
}
