package com.nexoapp.nexo

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.net.Uri
import androidx.core.content.edit
import es.antonborri.home_widget.HomeWidgetBackgroundIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray

/**
 * Recibe los taps sobre items individuales del widget de la lista de la compra.
 *
 * Flujo:
 *  1. Lee el JSON de items desde SharedPreferences (HomeWidgetPlugin).
 *  2. Alterna el flag `isChecked` del item identificado por `EXTRA_ITEM_ID`.
 *  3. Persiste el JSON actualizado y refresca el widget visualmente.
 *  4. Dispara un callback en background hacia Dart (HomeWidgetBackgroundIntent)
 *     para sincronizar el cambio con Firestore.
 */
class ShoppingToggleReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        if (intent.action != ACTION_TOGGLE) return
        val itemId = intent.getStringExtra(EXTRA_ITEM_ID) ?: return

        val prefs = HomeWidgetPlugin.getData(context)
        val raw = prefs.getString("shopping_items", "[]") ?: "[]"

        var newCheckedState = false
        val updated = try {
            val arr = JSONArray(raw)
            for (i in 0 until arr.length()) {
                val obj = arr.getJSONObject(i)
                if (obj.optString("id") == itemId) {
                    newCheckedState = !obj.optBoolean("isChecked", false)
                    obj.put("isChecked", newCheckedState)
                    break
                }
            }
            arr.toString()
        } catch (e: Exception) {
            return
        }

        // 1) Persistencia local inmediata (para que el widget se vea actualizado)
        prefs.edit { putString("shopping_items", updated) }

        // 2) Refrescar el widget (datos + UI de cabecera/progreso)
        ShoppingWidgetProvider.refresh(context)

        // 3) Notificar a Flutter para que sincronice con Firestore
        try {
            val callbackUri = Uri.parse(
                "nexo://shopping_toggle?itemId=$itemId&checked=$newCheckedState"
            )
            val pending = HomeWidgetBackgroundIntent.getBroadcast(context, callbackUri)
            pending.send()
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    companion object {
        const val ACTION_TOGGLE = "com.nexoapp.nexo.action.SHOPPING_TOGGLE"
        const val EXTRA_ITEM_ID = "itemId"
    }
}
