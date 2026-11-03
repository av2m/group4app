import 'package:flutter/material.dart';

void main() {
  runApp(const StudyReminderApp());
}

class StudyReminderApp extends StatefulWidget {
  const StudyReminderApp({super.key});

  @override
  State<StudyReminderApp> createState() => _StudyReminderAppState();
}

class _StudyReminderAppState extends State<StudyReminderApp> {
  // App-wide theme mode index: 0 = Vibrant, 1 = Solid Black, 2 = Clean White, 3 = Neon Purple
  int _bgThemeIndex = 0;

  void _changeTheme(int index) {
    setState(() {
      _bgThemeIndex = index;
    });
  }

  BoxDecoration getBackgroundDecoration() {
    switch (_bgThemeIndex) {
      case 1: // Solid Black / Dark
        return const BoxDecoration(color: Color(0xFF090D16));
      case 2: // Clean White / Light
        return const BoxDecoration(color: Color(0xFFF8FAFC));
      case 3: // Neon Cyberpunk
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF0F172A), Color(0xFF065F46), Color(0xFF1E1B4B)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
      default: // Vibrant Gradient (Default)
        return const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1E1B4B), Color(0xFF312E81), Color(0xFF4C1D95), Color(0xFF831843)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
    }
  }

  Color getTextColor() {
    return _bgThemeIndex == 2 ? const Color(0xFF0F172A) : Colors.white;
  }

  Color getSubTextColor() {
    return _bgThemeIndex == 2 ? const Color(0xFF64748B) : const Color(0xFFCBD5E1);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Group 4 Study & Task Reminder',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: _bgThemeIndex == 2 ? Brightness.light : Brightness.dark,
        ),
      ),
      home: HomeScreen(
        bgDecoration: getBackgroundDecoration(),
        textColor: getTextColor(),
        subTextColor: getSubTextColor(),
        currentThemeIndex: _bgThemeIndex,
        onThemeChanged: _changeTheme,
      ),
    );
  }
}

class HomeScreen extends StatefulWidget {
  final BoxDecoration bgDecoration;
  final Color textColor;
  final Color subTextColor;
  final int currentThemeIndex;
  final Function(int) onThemeChanged;

  const HomeScreen({
    super.key,
    required this.bgDecoration,
    required this.textColor,
    required this.subTextColor,
    required this.currentThemeIndex,
    required this.onThemeChanged,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _userName = 'Mark Dilan';

  // Function to edit user name via dialog
  void _editName() {
    final TextEditingController nameController = TextEditingController(text: _userName);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Your Name', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: nameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Display Name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (nameController.text.trim().isNotEmpty) {
                  setState(() {
                    _userName = nameController.text.trim();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Theme Picker Bottom Sheet
  void _showThemeSelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1E293B),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '🎨 Choose Background Theme',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.gradient, color: Color(0xFF818CF8)),
                title: const Text('Vibrant Gradient (Default)', style: TextStyle(color: Colors.white)),
                onTap: () {
                  widget.onThemeChanged(0);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.dark_mode, color: Colors.grey),
                title: const Text('Solid Black / Dark', style: TextStyle(color: Colors.white)),
                onTap: () {
                  widget.onThemeChanged(1);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.light_mode, color: Colors.amber),
                title: const Text('Clean White / Light', style: TextStyle(color: Colors.white)),
                onTap: () {
                  widget.onThemeChanged(2);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.flash_on, color: Colors.tealAccent),
                title: const Text('Neon Cyberpunk', style: TextStyle(color: Colors.white)),
                onTap: () {
                  widget.onThemeChanged(3);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: widget.bgDecoration,
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header with Theme Switcher icon on top right
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF6366F1), Color(0xFFEC4899)],
                            ),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(3.0),
                            child: CircleAvatar(
                              radius: 22,
                              backgroundColor: Colors.white,
                              child: Icon(Icons.school, color: Color(0xFF4F46E5), size: 24),
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Study Reminder App',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: widget.subTextColor,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                Text(
                                  _userName,
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: widget.textColor,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                InkWell(
                                  onTap: _editName,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      color: Colors.white.withOpacity(0.2),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: const Icon(Icons.edit, size: 14, color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    // Theme Switcher Button (Top Right Corner)
                    IconButton(
                      onPressed: _showThemeSelector,
                      icon: const Icon(Icons.color_lens_rounded, color: Colors.white, size: 28),
                      tooltip: 'Change Background Theme',
                    ),
                  ],
                ),
                const SizedBox(height: 28),

                // Hero Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6366F1), Color(0xFF9333EA), Color(0xFFDB2777)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF9333EA).withOpacity(0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.25),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          '🌟 Group 4 Task Manager Active',
                          style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                        ),
                      ),
                      const SizedBox(height: 18),
                      const Text(
                        'Study Dashboard',
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Team: Nathan, Mark, Kharyru, Ariq, Kamil\nManage tasks with live search, custom names, and priority alerts.',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white.withOpacity(0.9),
                          height: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28),

                // Navigation Card to Task Manager
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TaskScreen(
                          bgDecoration: widget.bgDecoration,
                        ),
                      ),
                    );
                  },
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.95),
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 15,
                          offset: const Offset(0, 6),
                        ),
                      ],
                      border: Border.all(color: Colors.white, width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Color(0xFFEEF2FF),
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),
                          child: Icon(Icons.checklist_rtl_rounded, color: Color(0xFF4F46E5), size: 28),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Open Task & Priority Manager',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Search, add, edit, and organize assignments',
                                style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                              ),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios_rounded, size: 16, color: Color(0xFF4F46E5)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class TaskScreen extends StatefulWidget {
  final BoxDecoration bgDecoration;

  const TaskScreen({super.key, required this.bgDecoration});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  
  String _searchQuery = '';

  // Task list with full CRUD support
  final List<Map<String, dynamic>> _tasks = [
    {
      'title': 'Complete Week 15 CRUD Checkpoint',
      'tag': 'IT Project',
      'color': const Color(0xFF4F46E5),
      'dueDate': DateTime(2026, 11, 4, 23, 59),
      'dueString': 'Nov 4, 11:59 PM',
      'done': false,
    },
    {
      'title': 'Review Flutter UI Layouts & Search Bar',
      'tag': 'IT Project',
      'color': const Color(0xFF7C3AED),
      'dueDate': DateTime(2026, 11, 10, 18, 00),
      'dueString': 'Nov 10, 6:00 PM',
      'done': false,
    },
    {
      'title': 'Economics Assignment Notes',
      'tag': 'Economics',
      'color': const Color(0xFF059669),
      'dueDate': DateTime(2026, 11, 5, 23, 59),
      'dueString': 'Nov 5, 11:59 PM',
      'done': false,
    },
  ];

  // CREATE: Add new task
  void _addTask() {
    if (_taskController.text.trim().isNotEmpty) {
      setState(() {
        _tasks.add({
          'title': _taskController.text.trim(),
          'tag': 'Study Reminder',
          'color': const Color(0xFFDB2777),
          'dueDate': DateTime.now().add(const Duration(days: 2)),
          'dueString': 'Nov 6, 11:59 PM',
          'done': false,
        });
      });
      _taskController.clear();
    }
  }

  // UPDATE: Edit task title via AlertDialog
  void _editTask(int index) {
    final TextEditingController editController =
        TextEditingController(text: _tasks[index]['title']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Task', style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Task Title',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF4F46E5),
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (editController.text.trim().isNotEmpty) {
                  setState(() {
                    _tasks[index]['title'] = editController.text.trim();
                  });
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  // DELETE: Remove task
  void _deleteTask(int index) {
    setState(() {
      _tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();

    // Filter tasks based on working search bar query
    final List<Map<String, dynamic>> searchedTasks = _tasks.where((task) {
      final title = task['title'].toString().toLowerCase();
      final tag = task['tag'].toString().toLowerCase();
      final query = _searchQuery.toLowerCase();
      return title.contains(query) || tag.contains(query);
    }).toList();

    // Separate into Overdue and Upcoming
    final List<Map<String, dynamic>> overdueTasks = searchedTasks.where((task) {
      final DateTime due = task['dueDate'];
      return due.isBefore(now) && !task['done'];
    }).toList();

    final List<Map<String, dynamic>> upcomingTasks = searchedTasks.where((task) {
      final DateTime due = task['dueDate'];
      return !due.isBefore(now) || task['done'];
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Task & Priority Manager', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        decoration: widget.bgDecoration,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // WORKING SEARCH BAR
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Color(0xFF0F172A)),
                  onChanged: (value) {
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Search tasks or subjects...',
                    hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                    prefixIcon: const Icon(Icons.search, color: Color(0xFF4F46E5)),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // WORKING ADD TASK BAR
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _taskController,
                        style: const TextStyle(color: Color(0xFF0F172A)),
                        decoration: InputDecoration(
                          hintText: 'Add a new study task...',
                          hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 14),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide.none,
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: const BorderSide(color: Color(0xFF4F46E5), width: 2),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(colors: [Color(0xFF6366F1), Color(0xFFEC4899)]),
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEC4899).withOpacity(0.4),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: IconButton(
                        onPressed: _addTask,
                        icon: const Icon(Icons.add, color: Colors.white, size: 24),
                        padding: const EdgeInsets.all(12),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Main Scrollable Task List Area
                Expanded(
                  child: ListView(
                    children: [
                      // OVERDUE / HIGH PRIORITY SECTION
                      if (overdueTasks.isNotEmpty) ...[
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: const Color(0xFF7F1D1D),
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: const Color(0xFFEF4444), width: 1.5),
                          ),
                          child: const Row(
                            children: [
                              Icon(Icons.warning_rounded, color: Color(0xFFFCA5A5), size: 20),
                              SizedBox(width: 8),
                              Text(
                                'Overdue & High Priority',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 12),
                        ...overdueTasks.map((task) {
                          final int originalIndex = _tasks.indexOf(task);
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(color: const Color(0xFFEF4444), width: 1.5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: task['done'],
                                activeColor: const Color(0xFFEF4444),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                                onChanged: (val) {
                                  setState(() {
                                    task['done'] = val ?? false;
                                  });
                                },
                              ),
                              title: Text(
                                task['title'],
                                style: const TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF991B1B),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(top: 6.0),
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEE2E2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    'Due: ${task['dueString']}',
                                    style: const TextStyle(
                                      color: Color(0xFFDC2626),
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit_outlined, color: Color(0xFF4F46E5)),
                                    onPressed: () => _editTask(originalIndex),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                                    onPressed: () => _deleteTask(originalIndex),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                        const SizedBox(height: 16),
                      ],

                      // UPCOMING TASKS SECTION
                      const Text(
                        'All Tasks & Schedule',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...upcomingTasks.map((task) {
                        final int originalIndex = _tasks.indexOf(task);
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                            border: Border.all(color: Colors.white, width: 1.5),
                          ),
                          child: ListTile(
                            leading: Checkbox(
                              value: task['done'],
                              activeColor: const Color(0xFF4F46E5),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                              onChanged: (val) {
                                setState(() {
                                  task['done'] = val ?? false;
                                });
                              },
                            ),
                            title: Text(
                              task['title'],
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: task['done'] ? const Color(0xFF94A3B8) : const Color(0xFF0F172A),
                                decoration: task['done'] ? TextDecoration.lineThrough : null,
                              ),
                            ),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 6.0),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: (task['color'] as Color).withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    child: Text(
                                      task['tag'],
                                      style: TextStyle(
                                        color: task['color'],
                                        fontSize: 11,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Due: ${task['dueString']}',
                                    style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                                  ),
                                ],
                              ),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.edit_outlined, color: Color(0xFF4F46E5)),
                                  onPressed: () => _editTask(originalIndex),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete_outline, color: Color(0xFFEF4444)),
                                  onPressed: () => _deleteTask(originalIndex),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}