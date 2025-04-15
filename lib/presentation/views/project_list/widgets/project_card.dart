// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../../../data/model/project.dart';

class ProjectCard extends StatelessWidget {
  final Project project;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final daysRemaining = project.endDate.difference(DateTime.now()).inDays;
    final progress = _calculateProgress(project);
    final isSmallScreen = MediaQuery.of(context).size.width < 400;

    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            margin: EdgeInsets.zero, // Remove default card margin
            child: Container(
              constraints: BoxConstraints(
                minHeight: isSmallScreen ? 180 : 200, // Minimum height
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: project.color.withOpacity(0.1),
                border: Border.all(
                  color: project.color.withOpacity(0.3),
                  width: 1,
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min, // Important for responsiveness
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildHeader(context),
                  const SizedBox(height: 12),
                  _buildProjectInfo(),
                  const Spacer(),
                  _buildProgressBar(progress, daysRemaining, constraints.maxWidth),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor: project.color.withOpacity(0.2),
          radius: 18, // Smaller on small screens
          child: Icon(
            Icons.folder,
            color: project.color,
            size: 18, // Smaller icon
          ),
        ),
        const Spacer(),
        IconButton(
          icon: Icon(
            Icons.delete,
            color: Colors.grey[600],
            size: 18, // Smaller delete icon
          ),
          padding: EdgeInsets.zero, // Reduce padding
          constraints: const BoxConstraints(), // Remove default constraints
          onPressed: onDelete,
        ),
      ],
    );
  }

  Widget _buildProjectInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // Important for responsiveness
      children: [
        Text(
          project.name,
          style: const TextStyle(
            fontSize: 16, // Slightly smaller font
            fontWeight: FontWeight.bold,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (project.description != null) ...[
          const SizedBox(height: 4), // Reduced spacing
          Text(
            project.description!,
            style: TextStyle(
              fontSize: 12, // Smaller description
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildProgressBar(double progress, int daysRemaining, double maxWidth) {
    return SizedBox(
      width: maxWidth - 32, // Account for padding (16 on each side)
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min, // Important for responsiveness
        children: [
          Text(
            '${_formatDate(project.startDate)} - ${_formatDate(project.endDate)}',
            style: TextStyle(
              fontSize: 10, // Smaller date text
              color: Colors.grey[600],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.grey[200],
            color: project.color,
            minHeight: 4, // Thinner progress bar
          ),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: const TextStyle(
                  fontSize: 10, // Smaller percentage
                ),
              ),
              Text(
                '$daysRemaining ${daysRemaining == 1 ? 'day' : 'days'} left',
                style: TextStyle(
                  fontSize: 10, // Smaller days text
                  color: daysRemaining < 3 ? Colors.red : Colors.green,
                  fontWeight: daysRemaining < 3 ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return date.toLocal().toString().split(' ')[0];
  }

  double _calculateProgress(Project project) {
    final totalDays = project.endDate.difference(project.startDate).inDays;
    final daysPassed = DateTime.now().difference(project.startDate).inDays;
    return (daysPassed / totalDays).clamp(0.0, 1.0);
  }
}