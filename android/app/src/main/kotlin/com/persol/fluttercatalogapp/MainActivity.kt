package com.persol.fluttercatalogapp

import androidx.biometric.BiometricManager
import androidx.biometric.BiometricPrompt
import androidx.core.content.ContextCompat
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterFragmentActivity() {

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(
      flutterEngine.dartExecutor.binaryMessenger,
      CHANNEL,
    ).setMethodCallHandler { call, result ->
      when (call.method) {
        "authenticate" -> {
          val reason = call.argument<String>("reason")
          authenticate(reason ?: "", result)
        }

        else -> {
          result.notImplemented()
        }
      }
    }
  }

  private fun authenticate(reason: String, callback: MethodChannel.Result) {
    val biometricManager = BiometricManager.from(this)
    val canAuthenticate = biometricManager.canAuthenticate(
      BiometricManager.Authenticators.BIOMETRIC_STRONG or
          BiometricManager.Authenticators.BIOMETRIC_WEAK
    )
    when (canAuthenticate) {
      BiometricManager.BIOMETRIC_SUCCESS -> {
        // 正常に認証可能 → このまま BiometricPrompt を呼び出す
      }
      BiometricManager.BIOMETRIC_ERROR_NO_HARDWARE -> {
        callback.error("no_hardware", "生体認証用のハードウェアが搭載されていません", null)
        return
      }
      BiometricManager.BIOMETRIC_ERROR_NONE_ENROLLED -> {
        callback.error("not_enrolled", "生体認証が登録されていません", null)
        return
      }
      else -> {
        callback.error("unavailable", "生体認証を利用できません", null)
        return
      }
    }

    val executor = ContextCompat.getMainExecutor(this)
    val prompt = BiometricPrompt(
      this,
      executor,
      object : BiometricPrompt.AuthenticationCallback() {
        override fun onAuthenticationSucceeded(result: BiometricPrompt.AuthenticationResult) {
          callback.success(true)
        }

        override fun onAuthenticationError(errorCode: Int, errString: CharSequence) {
          callback.success(false)
        }

        override fun onAuthenticationFailed() {
          callback.success(false)
        }
      }
    )

    val promptInfo = BiometricPrompt.PromptInfo.Builder()
      .setTitle(reason)
      .setSubtitle("指紋または顔認証を使用してください")
      .setAllowedAuthenticators(
        BiometricManager.Authenticators.BIOMETRIC_STRONG or
            BiometricManager.Authenticators.BIOMETRIC_WEAK
      )
      .setNegativeButtonText("キャンセル")
      .build()

    prompt.authenticate(promptInfo)

  }

  companion object {
    private const val CHANNEL = "com.persol.fluttercatalogapp/auth"
  }
}
