package com.nexoapp.nexo

import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.text.SpannableString
import android.text.style.StrikethroughSpan
import android.widget.RemoteViews
import android.widget.RemoteViewsService
import es.antonborri.home_widget.HomeWidgetPlugin
import org.json.JSONArray

/**
 * Servicio que alimenta la ListView del [ShoppingWidgetProvider].
 *
 * Lee los items desde las SharedPreferences que mantiene el plugin `home_widget`
 * (clave: `shopping_items`, formato JSON: `[{"id":"...","text":"...","isChecked":bool}]`).
 */
class ShoppingWidgetService : RemoteViewsService() {
    override fun onGetViewFactory(intent: Intent): RemoteViewsFactory {
        return ShoppingRemoteViewsFactory(applicationContext)
    }
}

private data class ShoppingItem(val id: String, val text: String, val checked: Boolean)

class ShoppingRemoteViewsFactory(
    private val context: Context
) : RemoteViewsService.RemoteViewsFactory {

    private var items: List<ShoppingItem> = emptyList()

    override fun onCreate() {
        loadData()
    }

    override fun onDataSetChanged() {
        loadData()
    }

    private fun loadData() {
        val prefs = HomeWidgetPlugin.getData(context)
        val raw = prefs.getString("shopping_items", "[]") ?: "[]"
        val parsed = mutableListOf<ShoppingItem>()
        try {
            val arr = JSONArray(raw)
            for (i in 0 until arr.length()) {
                val obj = arr.getJSONObject(i)
                val id = obj.optString("id", i.toString())
                val text = obj.optString("text", "")
                val checked = obj.optBoolean("isChecked", false)
                parsed.add(ShoppingItem(id, text, checked))
            }
        } catch (_: Exception) {
        }
        // Pendientes primero, completados al final (manteniendo el orden interno)
        items = parsed.sortedBy { if (it.checked) 1 else 0 }
    }

    override fun onDestroy() {
        items = emptyList()
    }

    override fun getCount(): Int = items.size

    override fun getViewAt(position: Int): RemoteViews {
        val item = items[position]
        val rv = RemoteViews(context.packageName, R.layout.widget_shopping_item)

        // Icono de check (Unicode → siempre visible sin necesidad de vector drawable)
        rv.setTextViewText(R.id.tv_check, if (item.checked) "☑" else "☐")
        rv.setTextColor(
            R.id.tv_check,
            if (item.checked) Color.parseColor("#10B981") else Color.parseColor("#94A3B8")
        )

        // Texto con strikethrough cuando está marcado
        if (item.checked) {
            val span = SpannableString(item.text)
            span.setSpan(StrikethroughSpan(), 0, item.text.length, 0)
            rv.setTextViewText(R.id.tv_text, span)
            rv.setTextColor(R.id.tv_text, Color.parseColor("#94A3B8"))
        } else {
            rv.setTextViewText(R.id.tv_text, item.text)
            rv.setTextColor(R.id.tv_text, Color.parseColor("#1E293B"))
        }

        // Fill-in intent que rellena el template definido en el provider
        val fillIn = Intent().apply {
            putExtra(ShoppingToggleReceiver.EXTRA_ITEM_ID, item.id)
        }
        rv.setOnClickFillInIntent(R.id.item_root, fillIn)

        return rv
    }

    override fun getLoadingView(): RemoteViews? = null
    override fun getViewTypeCount(): Int = 1
    override fun getItemId(position: Int): Long = items[position].id.hashCode().toLong()
    override fun hasStableIds(): Boolean = true
}
