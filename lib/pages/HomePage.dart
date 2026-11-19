import 'package:material_ui/material_ui.dart';
import '../data/TaskData.dart';
import '../pages/AddPage.dart';
import '../core/services/get_storage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    try {
      final savedTasks = GSService.get('tasks');

      tasks = savedTasks == null
          ? []
          : List<Map<String, dynamic>>.from(
              savedTasks.map((task) => Map<String, dynamic>.from(task)),
            );
    } catch (e) {
      tasks = [];
    }
  }

  Future<void> deleteTask(int index) async {
    final title = tasks[index]['title'];
    setState(() {
      tasks.removeAt(index);
    });

    await GSService.save('tasks', tasks);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Tugas $title berhasil dihapus'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final newTask = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (context) => AddPage()),
          );

          if (newTask != null && newTask.isNotEmpty) {
            setState(() {
              tasks.add({
                'title': newTask,
                'isCompleted': false,
              });
            });

            await GSService.save('tasks', tasks);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Tugas $newTask berhasil ditambahkan'),
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add, color: Colors.white),
      ),

      appBar: AppBar(
        title: const Text('MyTask', style: TextStyle(color: Colors.white)), 
        backgroundColor: Colors.red
      ),

      body: Padding(
        padding:  const EdgeInsets.all(16.0),

        child: Column(
          children: [
            const Center(
              child: Text('Daftar Tugas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: 
                tasks.isEmpty
                  ? const Center(child: Text('Tidak ada tugas', style: TextStyle(fontSize: 18)),)
                  : 
                  ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      margin: const EdgeInsets.only(bottom: 12),

                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),

                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),

                        leading: const Icon(
                          Icons.assignment,
                          color: Colors.red,
                        ),

                        title: Text(
                          tasks[index]['title'],
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        trailing: Checkbox(
                          value: tasks[index]['isCompleted'],
                          onChanged: (value) {
                            if (value == true){
                              deleteTask(index);
                            }
                          },
                        ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      )
    );
  }
}

