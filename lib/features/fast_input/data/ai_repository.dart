import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:uuid/uuid.dart';

/// ─────────────────────────────────────────────────────────────────────────────
/// AiRepository — Nexo V3 — Conecta con Google Gemini
/// ─────────────────────────────────────────────────────────────────────────────
class AiRepository {
  late final GenerativeModel _noteModel;
  late final GenerativeModel _mealModel;
  late final GenerativeModel _assistantModel;
  final _uuid = const Uuid();

  AiRepository() {
    final apiKey = dotenv.env['GEMINI_API_KEY'];
    if (apiKey == null || apiKey.isEmpty) {
      throw Exception('GEMINI_API_KEY no encontrada en .env');
    }

    // ── Modelo para parsear input de notas ────────────────────────────────
    _noteModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.1,
      ),
      systemInstruction: Content.system('''
Eres Nexo, un asistente personal inteligente. El usuario te enviará comandos o pensamientos desordenados en lenguaje natural.
Tu objetivo es transformar su entrada en un objeto JSON estructurado que represente una Nota o Lista, con los campos exactos requeridos.
SIEMPRE debes responder en ESPAÑOL.

Si el texto menciona añadir varios elementos (ej. compras, lista de cosas por hacer), extrae una "list" con esos elementos.
Si es un pensamiento o texto libre, devuélvelo como "text" con el contenido formateado.

DEBES responder ÚNICAMENTE con un JSON válido que sea un ARRAY de objetos. Cada objeto representa una nota o lista extraída.
Incluso si solo hay una nota, devuélvela dentro de un array.

Ejemplo de esquema exacto a devolver:
[
  {
    "title": "Un título corto (max 5 palabras)",
    "type": "text" | "list",
    "content": "Solo úsalo si type es 'text'. Aquí va el texto principal.",
    "items": ["Elemento 1", "Elemento 2"] // Solo úsalo si type es 'list'
  }
]

NUNCA devuelvas Markdown ni bloques de código como ```json. Devuelve estrictamente el array JSON crudo.
'''),
    );

    // ── Modelo para generar planes de comidas completos ──────────────────
    _mealModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.2,
      ),
      systemInstruction: Content.system('''
Eres Nexo Chef, un experto en planificación de comidas. Generarás un plan de comidas semanal saludable y creativo basado en los ingredientes o preferencias del usuario.
SIEMPRE debes escribir todas las recetas, títulos, descripciones y pasos en ESPAÑOL.

REQUERIMIENTOS:
1. Devuelve un objeto JSON que represente un "meal_plan".
2. Incluye un nombre para el plan.
3. El campo "meals" debe ser un array de objetos con: "weekday" (monday...sunday), "slot" (breakfast, lunch, dinner, snack) y "recipe".
4. Cada "recipe" debe tener: "name", "description", "prepTimeMinutes", "cookTimeMinutes", "servings", "ingredients" (array de {name, quantity, unit, category}) y "steps" (array de strings).

ESQUEMA JSON:
{
  "name": "Título del plan",
  "meals": [
    {
      "weekday": "monday",
      "slot": "lunch",
      "recipe": {
        "name": "Nombre de la receta",
        "description": "Corta descripción",
        "prepTimeMinutes": 10,
        "cookTimeMinutes": 20,
        "servings": 2,
        "ingredients": [{"name": "Arroz", "quantity": 100, "unit": "g", "category": "granos"}],
        "steps": ["Paso 1", "Paso 2"]
      }
    }
  ]
}
'''),
    );

    // ── Modelo para asistente IA de notas (respuestas estructuradas) ─────
    _assistantModel = GenerativeModel(
      model: 'gemini-2.5-flash',
      apiKey: apiKey,
      generationConfig: GenerationConfig(
        responseMimeType: 'application/json',
        temperature: 0.3,
      ),
      systemInstruction: Content.system('''
Eres Nexo AI, un asistente inteligente para notas. El usuario te dará el contenido actual de su nota y una instrucción.
SIEMPRE debes responder en ESPAÑOL. Tu respuesta debe ser un JSON con secciones estilizadas para que la app las renderice con diseño:

{
  "sections": [
    {"type": "heading", "content": "Título principal"},
    {"type": "paragraph", "content": "Texto normal explicativo..."},
    {"type": "bullet_list", "items": ["Punto 1", "Punto 2", "Punto 3"]},
    {"type": "highlight", "content": "Punto clave importante resaltado"},
    {"type": "numbered_list", "items": ["Primero", "Segundo", "Tercero"]},
    {"type": "separator"},
    {"type": "paragraph", "content": "Más contenido..."}
  ],
  "plain_text": "Versión en texto plano de todo el contenido para guardar en la nota"
}

Tipos de sección disponibles: heading, paragraph, bullet_list, numbered_list, highlight, separator.

Si el usuario pide "resumir", genera un resumen con headings y puntos clave.
Si pide "ampliar la lista de la compra", añade más items como bullet_list.
Si pide "corregir gramática", devuelve el texto corregido.
Si pide algo creativo, usa una mezcla de tipos para un resultado visualmente atractivo.

Responde SIEMPRE con este formato JSON. NUNCA devuelvas texto plano ni Markdown.
'''),
    );
  }

  /// Procesa la entrada cruda del usuario y devuelve una lista de mapas estructurados
  Future<List<Map<String, dynamic>>> parseUserInput(String rawInput) async {
    try {
      final response =
          await _noteModel.generateContent([Content.text(rawInput)]);

      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('Respuesta vacía del modelo IA');
      }

      String cleanJson = _cleanJsonResponse(responseText);
      final parsedData = jsonDecode(cleanJson);

      List<dynamic> jsonList;
      if (parsedData is List) {
        jsonList = parsedData;
      } else if (parsedData is Map) {
        jsonList = [parsedData];
      } else {
        throw Exception('El JSON devuelto no es un objeto ni un array válido.');
      }

      return jsonList.map((parsed) {
        final Map<String, dynamic> noteMap = parsed as Map<String, dynamic>;
        final String type = noteMap['type'] == 'list' ? 'list' : 'text';
        final String title = noteMap['title'] ?? 'Nota sin título';
        final String content = noteMap['content'] ?? '';
        final List<dynamic> rawItems = noteMap['items'] ?? [];

        final items = rawItems
            .map((itemText) => {
                  'id': _uuid.v4(),
                  'text': itemText.toString(),
                  'isChecked': false,
                  'order': rawItems.indexOf(itemText),
                })
            .toList();

        return {
          'title': title,
          'type': type,
          'content': content,
          'items': items,
          'isAiEnhanced': true,
        };
      }).toList();
    } catch (e) {
      throw Exception('No pude procesar eso. ¿Puedes ser más específico? ($e)');
    }
  }

  /// Genera un plan de comidas semanal completo basado en el prompt del usuario
  Future<Map<String, dynamic>> generateMealPlan(String prompt) async {
    try {
      final response = await _mealModel.generateContent([Content.text(prompt)]);

      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('El Chef IA no pudo responder.');
      }

      return jsonDecode(_cleanJsonResponse(responseText))
          as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error al generar el menú: $e');
    }
  }

  /// Genera una receta detallada para una comida específica
  /// Devuelve JSON estructurado: {name, description, difficulty, prepTime, cookTime, servings, steps: [...]}
  Future<Map<String, dynamic>> generateRecipeForMeal(
      String mealName, String? description) async {
    final prompt = '''
Genera una receta completa y detallada para: "$mealName"
${description != null ? 'Descripción adicional: "$description"' : ''}

DEBES escribir TODO el contenido (nombre, descripción, pasos, consejos) en ESPAÑOL.

Devuelve un JSON con esta estructura EXACTA:
{
  "name": "Nombre completo de la receta",
  "description": "Descripción breve y apetitosa",
  "difficulty": "easy" | "medium" | "hard",
  "prepTimeMinutes": 15,
  "cookTimeMinutes": 30,
  "servings": 2,
  "steps": [
    "Paso 1: Descripción detallada del primer paso",
    "Paso 2: Descripción detallada del segundo paso",
    "Paso 3: ..."
  ],
  "tips": ["Consejo útil 1", "Consejo útil 2"]
}

Incluye entre 4 y 8 pasos detallados. Sé específico con tiempos y temperaturas.
''';

    try {
      final response = await _mealModel.generateContent([Content.text(prompt)]);
      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('La IA no pudo generar la receta.');
      }
      return jsonDecode(_cleanJsonResponse(responseText))
          as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error al generar receta: $e');
    }
  }

  /// Genera la lista de ingredientes para una comida específica
  /// Devuelve JSON: [{name, quantity, unit, category}]
  Future<List<Map<String, dynamic>>> generateIngredientsList(
      String mealName, String? description) async {
    final prompt = '''
Lista todos los ingredientes necesarios para preparar: "$mealName"
${description != null ? 'Descripción: "$description"' : ''}

DEBES escribir TODO el contenido en ESPAÑOL.

Devuelve un JSON con esta estructura EXACTA:
{
  "ingredients": [
    {"name": "Nombre del ingrediente", "quantity": 200, "unit": "g", "category": "verduras"},
    {"name": "Otro ingrediente", "quantity": 2, "unit": "uds", "category": "lácteos"}
  ]
}

Categorías válidas: verduras, frutas, carnes, pescados, lácteos, granos, especias, aceites, otros.
Sé preciso con cantidades. Incluye todos los ingredientes necesarios incluyendo sal, aceite, etc.
''';

    try {
      final response = await _mealModel.generateContent([Content.text(prompt)]);
      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('La IA no pudo generar los ingredientes.');
      }
      final data =
          jsonDecode(_cleanJsonResponse(responseText)) as Map<String, dynamic>;
      return List<Map<String, dynamic>>.from(data['ingredients'] ?? []);
    } catch (e) {
      throw Exception('Error al generar ingredientes: $e');
    }
  }

  /// Solicita asistencia IA para mejorar o expandir una nota existente
  /// Devuelve JSON estructurado con secciones estilizadas
  Future<Map<String, dynamic>> getNoteAssistance({
    required String currentContent,
    required String command,
  }) async {
    final prompt = '''
Contenido actual de la nota:
"$currentContent"

Instrucción del usuario:
"$command"

Aplica las instrucciones del usuario al contenido de la nota y devuelve el resultado como JSON estructurado con secciones estilizadas.
''';

    try {
      final response =
          await _assistantModel.generateContent([Content.text(prompt)]);
      final responseText = response.text;
      if (responseText == null || responseText.isEmpty) {
        throw Exception('El asistente IA no pudo responder.');
      }
      return jsonDecode(_cleanJsonResponse(responseText))
          as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Error del asistente IA: $e');
    }
  }

  /// Limpia posibles artefactos de Markdown del JSON
  String _cleanJsonResponse(String raw) {
    String clean = raw.trim();
    if (clean.startsWith('```json')) {
      clean = clean.substring(7, clean.length - 3).trim();
    } else if (clean.startsWith('```')) {
      clean = clean.substring(3, clean.length - 3).trim();
    }
    return clean;
  }
}
