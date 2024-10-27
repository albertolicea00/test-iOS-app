import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Te Saludo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return NameInputDialog(
                      onNameSubmitted: (name) {
                        (context.findAncestorStateOfType<_GreetingTextState>())
                            ?._setUserName(name);
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: Center(
          child: GreetingText(),
        ),
      ),
    );
  }
}

class GreetingText extends StatefulWidget {
  @override
  _GreetingTextState createState() => _GreetingTextState();
}

class _GreetingTextState extends State<GreetingText> {
  String _greeting = 'Cargando...';
  String _userName = 'Tanke';

  @override
  void initState() {
    super.initState();
    _updateGreeting();
  }

  void _updateGreeting() {
    setState(() {
      _greeting = _getGreeting(_userName);
    });
  }

  String _getGreeting(String userName) {
    final hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Buenos Días, $userName ☀️';
    } else if (hour < 18) {
      return 'Buenas Tardes, $userName 🌤️';
    } else {
      return 'Buenas Noches, $userName 🌙';
    }
  }

  void _setUserName(String name) {
    setState(() {
      _userName = name;
      _updateGreeting();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _greeting,
      style: TextStyle(
        fontSize: 50, // Ajusta el tamaño del texto según tus necesidades
        fontWeight: FontWeight.bold,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class NameInputDialog extends StatefulWidget {
  final Function(String) onNameSubmitted;

  NameInputDialog({required this.onNameSubmitted});

  @override
  _NameInputDialogState createState() => _NameInputDialogState();
}

class _NameInputDialogState extends State<NameInputDialog> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Introduce tu nombre'),
      content: TextField(
        controller: _controller,
        decoration: InputDecoration(hintText: 'Nombre'),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            String name = _controller.text;
            if (name.isNotEmpty) {
              widget.onNameSubmitted(name);
              Navigator.of(context).pop();
            }
          },
          child: Text('Aceptar'),
        ),
      ],
    );
  }
}
