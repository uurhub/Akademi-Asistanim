import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Email';

  @override
  String get passwordInputLabel => 'Şifre';

  @override
  String get signInActionText => "Giriş Yap";

  @override
  String get emailIsRequiredErrorText =>
      "Email alanının doldurulması gereklidir.";

  @override
  String get passwordIsRequiredErrorText =>
      "Şifre alanının doldurulması gereklidir.";

  @override
  String get forgotPasswordButtonLabel => "Şifrenizi mi unuttunuz?";

  @override
  String get isNotAValidEmailErrorText => "Doğru bir mail adresi giriniz.";

  @override
  String get userNotFoundErrorText => "Kullanıcı bulunamadı.";

  @override
  String get forgotPasswordHintText =>
      "Lütfen akademiye kayıtlı olduğun mail adresini yaz. Sana şifreni sıfırlama linkini göndereceğiz.";

  @override
  String get forgotPasswordViewTitle => "Şifremi Unuttum";

  @override
  String get resetPasswordButtonLabel => "Şifremi Sıfırla";

  @override
  String get goBackButtonLabel => "Geriye dön";

  @override
  String get passwordResetEmailSentText =>
      "Şifreni sıfırlama linkini gönderdik! Lütfen epostanı kontrol etmeyi unutma. Eğer görüntüleyemiyorsanz SPAM kısmına göz atabilirsiniz.";
      
  @override
  String get wrongOrNoPasswordErrorText => "Yanlış şifre";
}
