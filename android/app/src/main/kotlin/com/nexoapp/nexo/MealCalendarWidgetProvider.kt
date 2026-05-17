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
                val mealsJsonString = widgetData.getString("meal_today_items", "[]")

                var mealsText = ""
                try {
                    val jsonArray = JSONArray(mealsJsonString)
                    for (i in 0 until jsonArray.length()) {
                        val obj = jsonArray.getJSONObject(i)
                        val slot = obj.getString("slot")
                        val name = obj.getString("name")
                        
                        val slotLabel = when(slot.lowercase()) {
                            "breakfast" -> "Desayuno"
                            "lunch" -> "Almuerzo"
                            "dinner" -> "Cena"
                            "snack" -> "Snack"
                            else -> slot.replaceFirstChar { it.uppercase() }
                        }
                        
                        val emoji = when(slot.lowercase()) {
                            "breakfast" -> "\u2615"
                            "lunch" -> "\uD83C\uDF72"
                            "dinner" -> "\uD83C\uDF19"
                            "snack" -> "\uD83C\uDF4E"
                            else -> "\uD83C\uDF7D\uFE0F"
                        }
                        
                        mealsText += "$emoji $slotLabel: $name\n"
                    }
                    
                    if (mealsText.isEmpty()) {
                        mealsText = "Nada planeado para hoy.\n¡Toca para añadir algo!"
                    }
                } catch (e: Exception) {
                    mealsText = "Sin plan para hoy"
                }

                setTextViewText(R.id.tv_meals, mealsText.trim())

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
