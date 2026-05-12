package com.nexoapp.nexo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetProvider
import org.json.JSONArray

class MealCalendarWidgetProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.widget_meal).apply {
                val dayName = widgetData.getString("meal_today_name", "Today")
                val mealsJsonString = widgetData.getString("meal_today_items", "[]")

                setTextViewText(R.id.tv_title, "$dayName's Meals")

                var mealsText = ""
                try {
                    val jsonArray = JSONArray(mealsJsonString)
                    for (i in 0 until jsonArray.length()) {
                        val obj = jsonArray.getJSONObject(i)
                        val slot = obj.getString("slot")
                        val name = obj.getString("name")
                        val emoji = when(slot.lowercase()) {
                            "breakfast" -> "🌅"
                            "lunch" -> "☀️"
                            "dinner" -> "🌙"
                            "snack" -> "🍎"
                            else -> "🍽️"
                        }
                        mealsText += "$emoji $name\n"
                    }
                    if (mealsText.isEmpty()) {
                        mealsText = "No meals planned for today.\nOpen Nexo to plan your day!"
                    }
                } catch (e: Exception) {
                    mealsText = "Error loading meals"
                }

                setTextViewText(R.id.tv_meals, mealsText.trim())
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
