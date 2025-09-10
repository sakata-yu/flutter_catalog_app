import Flutter
import UIKit
import LocalAuthentication

@main
@objc class AppDelegate: FlutterAppDelegate {

  private let CHANNEL = "com.persol.fluttercatalogapp/auth"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    let controller: FlutterViewController = window?.rootViewController as! FlutterViewController
    let channel = FlutterMethodChannel(name: CHANNEL,
                                       binaryMessenger: controller.binaryMessenger)
    channel.setMethodCallHandler { [weak self] (call, result) in
      guard call.method == "authenticate" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let args = call.arguments as? [String: Any]
      let reason = (args?["reason"] as? String) ?? "Authenticate"

      self?.authenticate(reason: reason, flutterResult: result)
    }                          

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

private func authenticate(reason: String, flutterResult: @escaping FlutterResult) {
    let context = LAContext()
    var error: NSError?

    // 生体認証が利用可能かどうかチェック
    if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) == false {
        let code = (error as? LAError)?.code ?? .biometryNotAvailable
        flutterResult(FlutterError(
            code: "\(code.rawValue)",
            message: error?.localizedDescription ?? "生体認証を利用できません",
            details: nil
        ))
        return
    }

    // 生体認証実行
    context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, evalError in
        DispatchQueue.main.async {
            if success {
                flutterResult(true)
            } else {
                if let laError = evalError as? LAError {
                    switch laError.code {
                    case .authenticationFailed:
                        flutterResult(FlutterError(code: "auth_failed", message: "認証に失敗しました", details: nil))
                    case .userCancel:
                        flutterResult(FlutterError(code: "user_cancel", message: "ユーザーがキャンセルしました", details: nil))
                    case .userFallback:
                        flutterResult(FlutterError(code: "user_fallback", message: "パスコード入力が選択されました", details: nil))
                    case .biometryNotAvailable:
                        flutterResult(FlutterError(code: "not_available", message: "生体認証が利用できません", details: nil))
                    case .biometryNotEnrolled:
                        flutterResult(FlutterError(code: "not_enrolled", message: "生体認証が登録されていません", details: nil))
                    case .biometryLockout:
                        flutterResult(FlutterError(code: "lockout", message: "生体認証がロックアウトされています", details: nil))
                    default:
                        flutterResult(FlutterError(code: "unknown", message: laError.localizedDescription, details: nil))
                    }
                } else {
                    flutterResult(FlutterError(code: "unknown", message: evalError?.localizedDescription ?? "不明なエラー", details: nil))
                }
            }
        }
    }
}
