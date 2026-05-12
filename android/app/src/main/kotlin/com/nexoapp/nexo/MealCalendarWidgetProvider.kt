package com.nexoapp.nexo

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
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
                val dayName = widgetData.getString("meal_today_name", "Hoy")
                val mealsJsonString = widgetData.getString("meal_today_items", "[]")

                if (dayName == "Hoy") {
                    setTextViewText(R.id.tv_title, "Comidas de Hoy")
                } else {
                    setTextViewText(R.id.tv_title, "Comidas del $dayName")
                }

                var mealsText = ""
                try {
                    val jsonArray = JSONArray(mealsJsonString)
                    for (i in 0 until jsonArray.length()) {
                        val obj = jsonArray.getJSONObject(i)
                        val slot = obj.getString("slot")
                        val name = obj.getString("name")
                        val emoji = when(slot.lowercase()) {
                            "breakfast" -> "\u2615" // Coffee ☕
                            "lunch" -> "\uD83C\uDF72" // Stew 🍲
                            "dinner" -> "\uD83C\uDF19" // Moon 🌙
                            "snack" -> "\uD83C\uDF4E" // Apple 🍎
                            else -> "\uD83C\uDF7D\uFE0F" // Plate 🍽️
                        }
                        mealsText += "$emoji $name\n"
                    }
                    if (mealsText.isEmpty()) {
                        mealsText = "No hay comidas planeadas.\n¡Abre Nexo para planificarlas!"
                    }
                } catch (e: Exception) {
                    mealsText = "Error al cargar las comidas"
                }

                setTextViewText(R.id.tv_meals, mealsText.trim())

                // Intent para abrir el calendario de comidas (nexo://meals)
                val intent = es.antonborri.home_widget.HomeWidgetLaunchIntent.getActivity(
                    context, 
                    MainActivity::class.java, 
                    android.net.Uri.parse("nexo://meals")
                )
                setOnClickPendingIntent(R.id.widget_root, intent)
            }
            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
