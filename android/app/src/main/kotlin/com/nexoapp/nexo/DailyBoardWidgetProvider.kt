package com.nexoapp.nexo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

class DailyBoardWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_daily_board).apply {
                val postitsJsonString = widgetData.getString("daily_board_items", "[]")

                var itemsText = ""
                try {
                    val jsonArray = JSONArray(postitsJsonString)
                    for (i in 0 until jsonArray.length()) {
                        val obj = jsonArray.getJSONObject(i)
                        val text = obj.getString("text")
                        val time = obj.getString("time")
                        itemsText += "\u2022 $time - $text\n"
                    }
                    if (itemsText.isEmpty()) {
                        itemsText = "No tienes recordatorios pendientes para hoy. ¡Disfruta tu día!"
                    }
                } catch (e: Exception) {
                    itemsText = "Error al cargar recordatorios"
                }

                setTextViewText(R.id.tv_content, itemsText.trim())
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
