import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TaskListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        centerTitle: true,
        backgroundColor:  Color.fromARGB(255, 80, 156, 237),
      ),
      body: Consumer<TaskProvider>(
          builder: (context, taskProvider, child) {
          return ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              final task = taskProvider.tasks[index];

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                  selected: true,
                  
                  selectedTileColor: Colors.blue[50],
                  tileColor: Colors.grey[200],
                  title: Text(
                    task.title,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough 
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(task.description,style: TextStyle(color: Colors.black),),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit,color: Colors.blue,),
                        onPressed: () {
                          _editTaskDialog(context, taskProvider, index, task);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_rounded,color: Colors.red,),
                        onPressed: () {
                          bool success = taskProvider.deleteTask(index);
                          if(success){
                             ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Task deleted successfully',style: TextStyle(fontWeight: FontWeight.bold,),),
                              backgroundColor: Color.fromARGB(255, 146, 205, 242),),
                            );
                          }
                          
                        },
                      ),
                    ],
                  ),
                  leading: Checkbox(
                    activeColor: Colors.green,
                    value: task.isCompleted,
                    onChanged: (bool? value) {
                      taskProvider.toggleTaskCompletion(index);
                    },
                  ),
                 ),
              );
                },
            
             
          );
        },
        
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[200],
        onPressed: () {
          _addTaskDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _addTaskDialog(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[50],
          title: Text('Add New Task',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0, 
                ),
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.green, 
                  width: 2.0,
                ),
              ),
            ),
          ),


              SizedBox(
                height: 10,),

              
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0, 
                ),
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.green, 
                  width: 2.0,
                ),
              ),
            ),
          ),


            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 20),),
            ),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  bool success =
                  Provider.of<TaskProvider>(context, listen: false).addTask(
                    titleController.text,
                    descriptionController.text,
                  );

                  if(success){
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task added successfully',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Color.fromARGB(255, 146, 205, 242),),
                    );
                  Navigator.of(context).pop();

                  }
                     
                }
              },
              child: Text('Add',style: TextStyle(color: Colors.green,fontSize: 20),),
            ),
          ],
        );
      },
    );
  }

  void _editTaskDialog(BuildContext context, TaskProvider taskProvider, int index, Task task) {
    final titleController = TextEditingController(text: task.title);
    final descriptionController = TextEditingController(text: task.description);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.blue[50],
          title: Text('Edit Task',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25),),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0, 
                ),
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.green, 
                  width: 2.0,
                ),
              ),
            ),
          ),

              SizedBox(height: 10,),
              
              TextField(
                controller: descriptionController,
                decoration: InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0, 
                ),
                ),
                enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.blue,
                  width: 2.0,
                ),
                ),
                focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: Colors.green, 
                  width: 2.0,
                ),
              ),
            ),
          ),

            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel',style: TextStyle(color: Colors.red,fontSize: 20),),
            ),
            // SizedBox(height: 10,),
            TextButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  bool success =
                  taskProvider.editTask(index, titleController.text, descriptionController.text);
                  if (success){
                      ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Task Edited Successfully',style: TextStyle(fontWeight: FontWeight.bold),),backgroundColor: Color.fromARGB(255, 146, 205, 242),),

                    );
                     Navigator.of(context).pop();
                  }

                 
                }
              },
              child: Text('Save',style: TextStyle(color: Colors.green,fontSize: 20),
              ),
            ),
          ],
        );
      },
    );
  }
}


class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  bool addTask(String title, String description) {
    _tasks.add(Task(title: title, description: description));
    notifyListeners();
    return true;
  }

  bool editTask(int index, String title, String description) {
    if (index >= 0 && index < _tasks.length) {
    _tasks[index].title = title;
    _tasks[index].description = description;
    notifyListeners();
    return true;
  }
  return false;
  }

  bool deleteTask(int index) {
     if (index >= 0 && index < _tasks.length) {
    _tasks.removeAt(index);
    notifyListeners();
    return true;
  }
  return false;
  }

  void toggleTaskCompletion(int index) {
    if (index >= 0 && index < _tasks.length) {
    _tasks[index].isCompleted = !_tasks[index].isCompleted;
    notifyListeners();
    }
  }
}

class Task {
  String title;
  String description;
  bool isCompleted;

  Task({required this.title, this.description = '', this.isCompleted = false});
}
