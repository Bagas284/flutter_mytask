import 'package:material_ui/material_ui.dart';

class AddPage extends StatelessWidget {
  const AddPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MyTask', style: TextStyle(color: Colors.white)), 
          backgroundColor: Colors.red),

        body: AddForm(),
    );
  }
}

class AddForm extends StatefulWidget {
  const AddForm({super.key});

  @override
  State<AddForm> createState() => _AddFormState();
}

class _AddFormState extends State<AddForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();

  @override
  void dispose() {
    _taskController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Center(
              child: Text('Tambah Tugas', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                const Text('Tugas', style: TextStyle(fontSize: 20)),
                const Text(' *', style: TextStyle(color: Colors.red, fontSize: 20)),
              ],
            ),

            TextFormField(
              controller: _taskController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter your task',
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Tugas tidak boleh kosong';
                }
                return null;
              },
            ),

            const SizedBox(height: 30),

            Align(
              alignment: Alignment.centerRight,
              child: 
                OutlinedButton.icon(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final taskTitle = _taskController.text.trim();

                      Navigator.pop(context, taskTitle);
                    }
                  },

                  style: OutlinedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),

                  label: const Text('Save', style: TextStyle(color: Colors.white)),
                ),
            )
          ],
        ),
      )
    );
  }
}