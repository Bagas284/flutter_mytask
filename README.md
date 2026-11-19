# MyTask

## Identitas
- Nama  : Bagas Aldianata
- NIM   : 103012680043

## Deskripsi
MyTask merupakan aplikasi mobile pencatatan / manajemen tugas sederhana yang dibuat menggunakan Flutter

## Screenshot Aplikasi
- Home Screen
![Home Screen](screenshoots/homepage.png)

- Input Form
![Input Form](screenshoots/inputform.png)

- Home Screen dengan 1 data
![Home Screen](screenshoots/homepage1data.png)

## Langkah Singkat Menjalankan Aplikasi
1. Clone repositori ini: https://github.com/Bagas284/flutter_mytask.git

2. Buka folder project menggunakan Visual Studio Code.

3. Install extension Flutter pada Visual Studio Code. Extension Dart biasanya akan ikut terpasang.

4. Install SDK Flutter versi terbaru: https://docs.flutter.dev/install/archive

5. Install dependencies:
   flutter pub get

6. Jalankan aplikasi:
    flutter run

## Deklarasi Penggunaan AI
- Apakah menggunakan AI? **Ya**
- Tool AI yang digunakan: **ChatGPT**
- Estimasi persentase kontribusi AI: **25%**
- Bagian kode/fitur yang dibantu AI: 
  - Membuat Local Storage
    
    Disini melihat tutorial video di youtube dan menggunakan AI dikarenakan kebingungan cara implementasi 

    File keys.dart
    ```
    class Keys {
        static const String tasks = 'tasks';
    }
    ```

    File get_storage.dart
    ```
    import 'package:get_storage/get_storage.dart';

    class GSService {
        static final box = GetStorage();

        static Future<void> init() async {
            await GetStorage.init();
        }

        static dynamic get(String key) {
            return box.read(key);
        }

        static Future<void> save(String key, dynamic value) async {
            await box.write(key, value);
        }

        static Future<void> remove(String key) async {
            await box.remove(key);
        }
    }
    ```

  - Memperbaiki Syntax Error
    ```

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
    }
    ```

- Pernyataan:  
"Saya menyatakan bahwa saya memahami alur dan fungsi dari seluruh kode yang ada dalam 
repositori ini"
