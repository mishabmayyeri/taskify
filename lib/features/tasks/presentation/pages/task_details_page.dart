import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:taskify/features/tasks/presentation/bloc/task_bloc.dart';
import 'package:taskify/features/tasks/presentation/pages/add_edit_task_page.dart';
import 'package:intl/intl.dart';

class TaskDetailsPage extends StatelessWidget {
  final Tasks task;

  const TaskDetailsPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final isOverdue =
        task.dueDate.isBefore(DateTime.now()) && task.status != 'completed';
    final priorityColor = _getPriorityColor(task.priority);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                task.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [priorityColor, priorityColor.withOpacity(0.7)],
                  ),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      right: -50,
                      top: -50,
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                    Positioned(
                      right: -20,
                      top: 100,
                      child: CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.white.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              PopupMenuButton<String>(
                onSelected: (value) {
                  switch (value) {
                    case 'edit':
                      _navigateToEdit(context);
                      break;
                    case 'delete':
                      _showDeleteDialog(context);
                      break;
                  }
                },
                itemBuilder:
                    (context) => [
                      const PopupMenuItem(
                        value: 'edit',
                        child: ListTile(
                          leading: Icon(Icons.edit_outlined),
                          title: Text('Edit Task'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: ListTile(
                          leading: Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          title: Text('Delete Task'),
                          contentPadding: EdgeInsets.zero,
                        ),
                      ),
                    ],
              ),
            ],
          ),
          SliverPadding(
            padding: const EdgeInsets.all(24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Description Section
                if (task.description.isNotEmpty) ...[
                  _buildSectionTitle(context, 'Description'),
                  const SizedBox(height: 12),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        task.description,
                        style: Theme.of(
                          context,
                        ).textTheme.bodyLarge?.copyWith(height: 1.6),
                      ),
                    ),
                  ),
                  const SizedBox(height: 32),
                ],

                // Task Details Section
                _buildSectionTitle(context, 'Task Details'),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      _buildDetailItem(
                        context,
                        icon: Icons.flag_outlined,
                        label: 'Priority',
                        value: task.priority,
                        color: priorityColor,
                        trailing: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: priorityColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            task.priority,
                            style: TextStyle(
                              color: priorityColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      _buildDetailItem(
                        context,
                        icon: Icons.schedule_outlined,
                        label: 'Status',
                        value: task.status,
                        color: _getStatusColor(task.status),
                        trailing: GestureDetector(
                          onTap: () => _toggleTaskStatus(context),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: _getStatusColor(
                                task.status,
                              ).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              task.status,
                              style: TextStyle(
                                color: _getStatusColor(task.status),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Divider(height: 1),
                      _buildDetailItem(
                        context,
                        icon: Icons.calendar_today_outlined,
                        label: 'Due Date',
                        value: DateFormat(
                          'EEEE, MMMM d, y',
                        ).format(task.dueDate),
                        color:
                            isOverdue
                                ? Colors.red
                                : (isDarkMode ? Colors.white : Colors.black),
                        subtitle: isOverdue ? 'Overdue' : null,
                        subtitleColor: Colors.red,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Timestamps Section
                _buildSectionTitle(context, 'Timeline'),
                const SizedBox(height: 12),
                Card(
                  child: Column(
                    children: [
                      _buildDetailItem(
                        context,
                        icon: Icons.add_circle_outline,
                        label: 'Created',
                        value: DateFormat(
                          'MMM d, y h:mm a',
                        ).format(task.createdAt),
                        color: Colors.blue,
                      ),
                      const Divider(height: 1),
                      _buildDetailItem(
                        context,
                        icon: Icons.update_outlined,
                        label: 'Last Updated',
                        value: DateFormat(
                          'MMM d, y h:mm a',
                        ).format(task.updatedAt),
                        color: Colors.green,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100), // Space for FAB
              ]),
            ),
          ),
        ],
      ),
      extendBody: true,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: MediaQuery.of(context).padding.bottom + 24,
            top: 24,
          ),
          child: ElevatedButton.icon(
            onPressed: () => _toggleTaskStatus(context),
            icon: Icon(
              task.status == 'completed'
                  ? Icons.restart_alt
                  : Icons.check_circle_outline,
            ),
            label: Text(
              task.status == 'completed'
                  ? 'Mark as Pending'
                  : 'Mark as Completed',
            ),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
          letterSpacing: -0.5,
        ),
      ),
    );
  }

  Widget _buildDetailItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    Widget? trailing,
    String? subtitle,
    Color? subtitleColor,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color:
                          subtitleColor ??
                          Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (trailing != null) trailing,
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xFFDC2626);
      case 'medium':
        return const Color(0xFFEA580C);
      case 'low':
        return const Color(0xFF059669);
      default:
        return Colors.grey;
    }
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
        return const Color(0xFF059669);
      case 'pending':
        return const Color(0xFF3B82F6);
      default:
        return Colors.grey;
    }
  }

  void _navigateToEdit(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddEditTaskPage(task: task)),
    );
  }

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: const Text('Delete Task'),
            content: const Text(
              'Are you sure you want to delete this task? This action cannot be undone.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Go back to home
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Delete'),
              ),
            ],
          ),
    );
  }

  void _toggleTaskStatus(BuildContext context) {
    final newStatus = task.status == 'completed' ? 'pending' : 'completed';
    final updatedTask = Tasks(
      id: task.id,
      title: task.title,
      description: task.description,
      priority: task.priority,
      status: newStatus,
      dueDate: task.dueDate,
      createdAt: task.createdAt,
      updatedAt: DateTime.now(),
    );

    context.read<TaskBloc>().add(
      UpdateTaskEvent(
        id: updatedTask.id,
        title: updatedTask.title,
        description: updatedTask.description,
        priority: updatedTask.priority,
        status: updatedTask.status,
        dueDate: updatedTask.dueDate,
        createdAt: updatedTask.createdAt,
        updatedAt: updatedTask.updatedAt,
      ),
    );

    Navigator.pop(context); // Go back after updating
  }
}
