import 'package:flutter/material.dart';
import 'package:taskify/features/tasks/domain/entities/task.dart';
import 'package:intl/intl.dart';

class TaskCard extends StatelessWidget {
  final Tasks task;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onStatusChange;

  const TaskCard({
    super.key,
    required this.task,
    required this.onTap,
    required this.onDelete,
    required this.onStatusChange,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final priorityColor = _getPriorityColor(task.priority);
    final isOverdue =
        task.dueDate.isBefore(DateTime.now()) && task.status != 'completed';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color:
              isOverdue
                  ? Colors.red.withOpacity(0.3)
                  : Colors.grey.withOpacity(0.1),
          width: isOverdue ? 2 : 1,
        ),
      ),
      shadowColor: Colors.black12,
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 4,
                    height: 32,
                    decoration: BoxDecoration(
                      color: priorityColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          task.title,
                          style: Theme.of(
                            context,
                          ).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            decoration:
                                task.status == 'completed'
                                    ? TextDecoration.lineThrough
                                    : null,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (task.description.isNotEmpty) ...[
                          const SizedBox(height: 4),
                          Text(
                            task.description,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withOpacity(0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      _buildChip(
                        context,
                        icon: Icons.flag_outlined,
                        label: task.priority,
                        color: priorityColor,
                      ),
                      const SizedBox(width: 8),
                      _buildChip(
                        context,
                        icon: Icons.calendar_today_outlined,
                        label: DateFormat('MMM dd').format(task.dueDate),
                        color:
                            isOverdue
                                ? Colors.red
                                : (isDarkMode
                                    ? Colors.grey[400]
                                    : Colors.grey[600])!,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: onStatusChange,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              task.status == 'completed'
                                  ? Icons.check_circle
                                  : Icons.check_circle_outline,
                              color:
                                  task.status == 'completed'
                                      ? Colors.green
                                      : (isDarkMode
                                          ? Colors.grey[400]
                                          : Colors.grey[600]),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(8),
                          onTap: onDelete,
                          child: Padding(
                            padding: const EdgeInsets.all(8),
                            child: Icon(
                              Icons.delete_outline,
                              color: Colors.red.withOpacity(0.8),
                              size: 20,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(
    BuildContext context, {
    required IconData icon,
    required String label,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Color _getPriorityColor(String priority) {
    switch (priority.toLowerCase()) {
      case 'high':
        return const Color(0xFFDC2626); // Red 600
      case 'medium':
        return const Color(0xFFEA580C); // Orange 600
      case 'low':
        return const Color(0xFF059669); // Emerald 600
      default:
        return Colors.grey;
    }
  }
}
