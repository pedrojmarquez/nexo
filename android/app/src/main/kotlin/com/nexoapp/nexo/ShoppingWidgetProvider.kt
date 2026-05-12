package com.nexoapp.nexo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import android.net.Uri
import org.json.JSONArray

class ShoppingWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_shopping).apply {
                val title = widgetData.getString("shopping_title", "Lista de Compra")
                val itemsJsonString = widgetData.getString("shopping_items", "[]")

                setTextViewText(R.id.tv_title, title)

                var itemsText = ""
                try {
                    val jsonArray = JSONArray(itemsJsonString)
                    val total = jsonArray.length()
                    var checkedCount = 0
                    
                    // Mostramos solo los primeros 5-6 para no desbordar el widget
                    for (i in 0 until minOf(total, 6)) {
                        val item = jsonArray.getJSONObject(i)
                        val text = item.getString("text")
                        val checked = item.getBoolean("isChecked")
                        if (checked) checkedCount++
                        
                        val icon = if (checked) "☑" else "☐"
                        itemsText += "$icon $text\n"
                    }
                    
                    // Contamos el resto
                    if (total > 6) {
                        for (i in 6 until total) {
                            if (jsonArray.getJSONObject(i).getBoolean("isChecked")) checkedCount++
                        }
                        itemsText += "...y ${total - 6} más"
                    }

                    if (itemsText.isEmpty()) {
                        itemsText = "¡Todo listo! \uD83C\uDF89"
                    }
                    
                    setTextViewText(R.id.tv_progress, "$checkedCount/$total")
                } catch (e: Exception) {
                    itemsText = "Toca el lápiz para empezar"
                }

                setTextViewText(R.id.tv_items, itemsText.trim())

                // Intent para abrir el editor (nexo://shopping_list)
                val editIntent = HomeWidgetLaunchIntent.getActivity(
                    context, 
                    MainActivity::class.java, 
                    Uri.parse("nexo://shopping_list")
                )
                setOnClickPendingIntent(R.id.btn_edit, editIntent)
                setOnClickPendingIntent(R.id.widget_root, editIntent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
