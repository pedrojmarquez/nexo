package com.nexoapp.nexo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray
import android.graphics.Color

class PostItWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_postit).apply {
                val title = widgetData.getString("postit_title", "Quick Note")
                val content = widgetData.getString("postit_content", "Tap + to add a post-it in Nexo")
                val colorHex = widgetData.getString("postit_color", "#FFF176")
                
                setTextViewText(R.id.tv_title, title)
                setTextViewText(R.id.tv_content, content)
                
                try {
                    val color = Color.parseColor(colorHex)
                    setInt(R.id.widget_root, "setBackgroundColor", color)
                } catch (e: Exception) {
                    setInt(R.id.widget_root, "setBackgroundColor", Color.parseColor("#FFF176"))
                }
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
