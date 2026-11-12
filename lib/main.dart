import 'package:flutter/material.dart'; // Importa la librería de Material Design con todos los widgets (Scaffold, Text, TextField, etc.)

void main() { // Función principal, el punto de entrada de la aplicación
  runApp(const SaludoUAE()); // Arranca la app montando el widget raíz en la pantalla
} // Cierra la función main

class SaludoUAE extends StatelessWidget { // Clase raíz de la app, es Stateless porque no cambia su estado
  const SaludoUAE({super.key}); // Constructor constante de la clase

  @override // Sobrescribe el métdo build
  Widget build(BuildContext context) { // Méodo que construye la interfaz visual
    return const MaterialApp( // Retorna la configuración de la app Material
      title: 'SaludoUAE', // Título de la aplicación (sin espacios, como pide el taller)
      home: const SaludoPage(), // Define la pantalla principal (nuestro StatefulWidget)
    ); // Cierra el MaterialApp
  } // Cierra el métdo build
} // Cierra la clase SaludoUAE

class SaludoPage extends StatefulWidget { // Pantalla principal, es Stateful porque el saludo cambia en pantalla
  const SaludoPage({super.key}); // Constructor constante de la pantalla

  @override // Sobrescribe el métdo para crear el estado
  State<SaludoPage> createState() => _SaludoPageState(); // Crea y retorna el objeto de estado de esta pantalla
} // Cierra la clase SaludoPage

class _SaludoPageState extends State<SaludoPage> { // Clase de estado que guarda los datos mutables y redibuja la pantalla
  final TextEditingController _ctrl = TextEditingController(); // Controlador para leer y escribir en el TextField (equivale a EditText)
  String _resultado = ''; // Variable de estado que guarda el saludo a mostrar en pantalla

  @override // Sobrescribe el ciclo de vida
  void dispose() { // Métdo que se ejecuta al destruir la pantalla
    _ctrl.dispose(); // Libera la memoria del controlador para evitar fugas
    super.dispose(); // Llama al dispose de la clase padre
  } // Cierra el dispose

  void _saludar() { // Métdo que se ejecuta al presionar el botón
    print('--- Botón Saludar pulsado ---'); // Imprime en consola que se presionó el botón
    final String nombre = _ctrl.text.trim(); // Lee el texto del campo y elimina espacios vacíos a los lados

    if (nombre.isEmpty) { // Valida si el campo está vacío
      print('Validación fallida: El nombre está vacío'); // Imprime en consola que falló la validación
      setState(() { // Llama a setState para redibujar la pantalla
        _resultado = 'Por favor, ingrese su nombre'; // Muestra un mensaje de advertencia en la variable de estado
      }); // Cierra el setState
      return; // Retorna para que no siga ejecutando el resto del código
    } // Cierra el if de validación

    print('Nombre válido ingresado: $nombre'); // Imprime en consola el nombre ingresado
    setState(() { // Llama a setState para que la pantalla se redibuje
      _resultado = '¡Hola, $nombre! Bienvenido a la UAE'; // Actualiza la variable de estado con el saludo final
    }); // Cierra el setState
    print('Saludo generado: $_resultado'); // Imprime en consola el resultado final
  } // Cierra el método _saludar

  void _limpiar() { // Métdo que se ejecuta al presionar el botón de limpiar
    print('--- Botón Limpiar pulsado ---'); // Imprime en consola que se presionó el botón
    _ctrl.clear(); // Limpia el campo de texto (se puede hacer fuera de setState)
    setState(() { // Llama a setState para redibujar la pantalla
      _resultado = ''; // Borra el mensaje de la pantalla
    }); // Cierra el setState
  } // Cierra el métdo _limpiar

  @override // Sobrescribe el método build
  Widget build(BuildContext context) { //Métdo que construye la interfaz de la pantalla
    return Scaffold( // Contenedor base que da estructura a la pantalla
      appBar: AppBar( // Barra superior de la app
        backgroundColor: Colors.blue, // Color de fondo de la barra superior
        centerTitle: true, // Centra el título en la barra superior
        foregroundColor: Colors.yellow, // Color del texto
        title: const Text( // Texto que se muestra en la barra superior
          'SaludoUAE', // Título
          style: TextStyle(fontFamily: 'serif', fontSize: 26, fontWeight: FontWeight.bold), // Estilo del título
        ), // Cierra el Text
      ), // Cierra el AppBar
      body: Padding( // Añade margen exterior atodo el contenido (equivale al margin de Android)
        padding: const EdgeInsets.all(16.0), // Margen de 16 píxeles en todos los lados
        child: Column( // Organiza los widgets de forma vertical
          crossAxisAlignment: CrossAxisAlignment.stretch, // Estira los hijos para que ocupen todo el ancho
          children: [ // Lista de widgets hijos de la columna
            const Text( // Etiqueta superior
              'Ingresa Tu Nombre', // Texto de la etiqueta
              style: TextStyle(fontFamily: 'serif', fontSize: 18), // Tamaño de la letra
            ), // Cierra el Text
            const SizedBox(height: 8), // Espacio vertical de separación (equivale al margin)
            TextField( // Campo de texto para ingresar el nombre
              controller: _ctrl, // Vincula el controlador _ctrl al campo para poder leerlo
              decoration: const InputDecoration( // Decora el campo de texto
                border: OutlineInputBorder(), // Añade un borde visible alrededor del campo
                hintText: 'Ej: Juan', // Texto de ayuda dentro del campo
              ), // Cierra el InputDecoration
            ), // Cierra el TextField
            const SizedBox(height: 16), // Espacio vertical de separación antes del botón
            ElevatedButton( // Botón elevado
              style: ElevatedButton.styleFrom( // Estilo del botón
                backgroundColor: Colors.green, // Color de fondo del botón
              ), // Cierra el styleFrom
              onPressed: _saludar, // Asigna el méodo _saludar al evento de clic
              child: const Text( // Texto que muestra el botón
                'Saludar', // Texto del botón
                style: TextStyle(fontFamily: 'serif', color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold), // Estilo del texto
              ), // Cierra el Text
            ), // Cierra el ElevatedButton
            const SizedBox(height: 8), // Espacio vertical de separación antes del botón
            OutlinedButton( // Botón con borde
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.white, // Color del texto del botón
                backgroundColor: Colors.red, // Borde del botón

              ),

              onPressed: _limpiar, // Llama al méodo _limpiar (¡Mucho más limpio que usar la función anónima!)

              child: const Text('Limpiar',
              style: TextStyle(fontFamily: 'serif', fontSize: 18, fontWeight: FontWeight.bold),), // Texto del botón
            ), // Cierra el OutlinedButton
            const SizedBox(height: 16), // Espacio vertical de separación antes del resultado
            Text( // Texto que muestra el resultado en pantalla
              _resultado, // Muestra el valor actual de la variable de estado
              style: const TextStyle(fontFamily: 'serif', color: Colors.blueAccent, fontSize: 18, fontWeight: FontWeight.bold), // Estilo del texto
              textAlign: TextAlign.center, // Centra el texto en la pantalla
            ), // Cierra el Text de resultado
          ], // Cierra la lista de hijos
        ), // Cierra el Column
      ), // Cierra el Padding
    ); // Cierra el Scaffold
  } // Cierra el métdo build
} // Cierra la clase _SaludoPageState