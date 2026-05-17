package com.nexoapp.nexo

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

/**
 * Widget interactivo de la lista de la compra.
 *
 * Características:
 *  - Lista scrolleable con TODOS los items (RemoteViews ListView).
 *  - Tap en un item: toggle de "tachado" (broadcast a [ShoppingToggleReceiver]).
 *  - Tap en cabecera/+ : abre el editor en la app (deep link nexo://shopping_list).
 */
class ShoppingWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_shopping)

            // ── Título + progreso ──
            val title = widgetData.getString("shopping_title", "Lista de la compra")
            views.setTextViewText(R.id.tv_title, title)

            val itemsJsonString = widgetData.getString("shopping_items", "[]") ?: "[]"
            var total = 0
            var checkedCount = 0
            try {
                val arr = JSONArray(itemsJsonString)
                total = arr.length()
                for (i in 0 until total) {
                    if (arr.getJSONObject(i).optBoolean("isChecked", false)) checkedCount++
                }
            } catch (_: Exception) {
            }
            views.setTextViewText(R.id.tv_progress, "$checkedCount/$total")

            // Empty state vs Lista
            if (total == 0) {
                views.setViewVisibility(R.id.lv_items, android.view.View.GONE)
                views.setViewVisibility(R.id.tv_empty, android.view.View.VISIBLE)
            } else {
                views.setViewVisibility(R.id.lv_items, android.view.View.VISIBLE)
                views.setViewVisibility(R.id.tv_empty, android.view.View.GONE)
            }

            // ── ListView adapter (servicio remoto) ──
            val serviceIntent = Intent(context, ShoppingWidgetService::class.java).apply {
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_ID, widgetId)
                // Data único para que Android no reutilice el adapter en cada widget
                data = Uri.parse(toUri(Intent.URI_INTENT_SCHEME))
            }
            views.setRemoteAdapter(R.id.lv_items, serviceIntent)
            views.setEmptyView(R.id.lv_items, R.id.tv_empty)

            // ── PendingIntent template para taps en cada item ──
            val toggleTemplate = Intent(context, ShoppingToggleReceiver::class.java).apply {
                action = ShoppingToggleReceiver.ACTION_TOGGLE
            }
            val templateFlags = PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_MUTABLE
            val templatePending = PendingIntent.getBroadcast(
                context,
                widgetId,
                toggleTemplate,
                templateFlags
            )
            views.setPendingIntentTemplate(R.id.lv_items, templatePending)

            // ── Abrir la app al pulsar la cabecera o el botón "+" ──
            val openEditor = HomeWidgetLaunchIntent.getActivity(
                context,
                MainActivity::class.java,
                Uri.parse("nexo://shopping_list")
            )
            views.setOnClickPendingIntent(R.id.header_root, openEditor)
            views.setOnClickPendingIntent(R.id.btn_add, openEditor)
            views.setOnClickPendingIntent(R.id.tv_empty, openEditor)

            appWidgetManager.updateAppWidget(widgetId, views)
            appWidgetManager.notifyAppWidgetViewDataChanged(widgetId, R.id.lv_items)
        }
    }

    companion object {
        /**
         * Fuerza una recarga total del widget (datos + UI) desde cualquier punto.
         */
        fun refresh(context: Context) {
            val manager = AppWidgetManager.getInstance(context)
            val ids = manager.getAppWidgetIds(
                ComponentName(context, ShoppingWidgetProvider::class.java)
            )
            if (ids.isEmpty()) return
            val intent = Intent(context, ShoppingWidgetProvider::class.java).apply {
                action = AppWidgetManager.ACTION_APPWIDGET_UPDATE
                putExtra(AppWidgetManager.EXTRA_APPWIDGET_IDS, ids)
            }
            context.sendBroadcast(intent)
            manager.notifyAppWidgetViewDataChanged(ids, R.id.lv_items)
        }
    }
}
