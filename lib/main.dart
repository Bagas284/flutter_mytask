import 'package:material_ui/material_ui.dart';
import 'pages/HomePage.dart';
import 'core/services/get_storage.dart';

void main() async{
  await GSService.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Task',
      home: HomePage(),
    );
  }
}
