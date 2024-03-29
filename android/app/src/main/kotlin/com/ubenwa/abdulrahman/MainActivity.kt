package com.ubenwa.abdulrahman

import android.os.Build
import android.os.Bundle
import android.window.SplashScreenView
import androidx.core.view.WindowCompat
import io.flutter.embedding.android.FlutterActivity


class MainActivity: FlutterActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        WindowCompat.setDecorFitsSystemWindows(window, false)

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.S) {
            splashScreen
                .setOnExitAnimationListener { splashScreenView: SplashScreenView -> splashScreenView.remove() }
        }

        super.onCreate(savedInstanceState)
    }
}
