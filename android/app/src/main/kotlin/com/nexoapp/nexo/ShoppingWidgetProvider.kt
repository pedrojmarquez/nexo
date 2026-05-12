package com.nexoapp.nexo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
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
                val title = widgetData.getString("shopping_title", "Shopping List")
                val progress = widgetData.getString("shopping_progress", "0/0")
                val itemsJsonString = widgetData.getString("shopping_items", "[]")
                val remainingCount = widgetData.getInt("shopping_remaining_count", 0)

                setTextViewText(R.id.tv_title, title)
                setTextViewText(R.id.tv_progress, progress)

                var itemsText = ""
                try {
                    val jsonArray = JSONArray(itemsJsonString)
                    for (i in 0 until jsonArray.length()) {
                        itemsText += "• ${jsonArray.getString(i)}\n"
                    }
                    if (remainingCount > 5) {
                        itemsText += "...and ${remainingCount - 5} more"
                    }
                    if (itemsText.isEmpty()) {
                        itemsText = "All done! \uD83C\uDF89"
                    }
                } catch (e: Exception) {
                    itemsText = "Error loading items"
                }

                setTextViewText(R.id.tv_items, itemsText.trim())
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
