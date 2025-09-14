import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../data/model/sns/notification_model.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isUnread = notification.isRead != true;
    
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: isUnread ? 2 : 1,
      child: ListTile(
        onTap: onTap,
        leading: _buildLeadingIcon(),
        title: Text(
          notification.title,
          style: TextStyle(
            fontWeight: isUnread ? FontWeight.bold : FontWeight.normal,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              notification.message,
              style: TextStyle(
                color: isUnread ? Colors.black87 : Colors.grey[600],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              _formatDateTime(notification.createdAt),
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
        trailing: isUnread
            ? Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }

  Widget _buildLeadingIcon() {
    IconData iconData;
    Color iconColor;

    switch (notification.type) {
      case NotificationType.follow:
        iconData = Icons.person_add;
        iconColor = Colors.blue;
        break;
      case NotificationType.like:
        iconData = Icons.favorite;
        iconColor = Colors.red;
        break;
      case NotificationType.comment:
        iconData = Icons.comment;
        iconColor = Colors.green;
        break;
      case NotificationType.message:
        iconData = Icons.message;
        iconColor = Colors.purple;
        break;
      case NotificationType.eventReminder:
        iconData = Icons.event;
        iconColor = Colors.orange;
        break;
      case NotificationType.purchaseConfirmation:
      case NotificationType.paymentSuccess:
        iconData = Icons.payment;
        iconColor = Colors.green;
        break;
      case NotificationType.ticketIssued:
        iconData = Icons.confirmation_number;
        iconColor = Colors.indigo;
        break;
      case NotificationType.paymentFailed:
        iconData = Icons.error;
        iconColor = Colors.red;
        break;
      default:
        iconData = Icons.notifications;
        iconColor = Colors.grey;
    }

    return CircleAvatar(
      backgroundColor: iconColor.withOpacity(0.1),
      child: Icon(
        iconData,
        color: iconColor,
        size: 20,
      ),
    );
  }

  String _formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '';
    
    final now = DateTime.now();
    final difference = now.difference(dateTime);
    
    if (difference.inMinutes < 1) {
      return 'たった今';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}分前';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}時間前';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}日前';
    } else {
      return DateFormat('MM/dd HH:mm').format(dateTime);
    }
  }
}