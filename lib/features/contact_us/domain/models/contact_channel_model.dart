import 'package:flutter/material.dart';

class ContactChannelModel {
  final IconData icon;
  final String title;
  final String value;
  final String hint;

  const ContactChannelModel({
    required this.icon,
    required this.title,
    required this.value,
    required this.hint,
  });

  static const List<ContactChannelModel> defaultChannels = [
    ContactChannelModel(
      icon: Icons.phone_in_talk_rounded,
      title: 'Customer Support Hotline',
      value: '+971 4 800 3655',
      hint: 'Toll-free • Available 9:00 AM - 9:00 PM',
    ),
    ContactChannelModel(
      icon: Icons.mail_outline_rounded,
      title: 'Concierge & Email Support',
      value: 'support@dokkan-atelier.com',
      hint: 'Average response time: under 2 hours',
    ),
    ContactChannelModel(
      icon: Icons.support_agent_rounded,
      title: 'Live Chat & Styling Advisory',
      value: 'advisor@dokkan.com',
      hint: '7 days a week dedicated assistance',
    ),
  ];
}

