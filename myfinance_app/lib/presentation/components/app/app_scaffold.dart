import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/app_route.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.drawer,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: .start,
          children: [
            Text(
              DateFormat("MMMM y").format(DateTime.now()).toUpperCase(),
              style: themeContext.textTheme.labelMedium,
            ),
            Text(title),
          ],
        ),
        actionsPadding: const EdgeInsets.all(10),
        actions: [
          InkWell(
            onTap: () => Navigator.of(context).pushNamed(AppRoutes.profile),
            child: CircleAvatar(
              child: Icon(Icons.person),
            ),
          ),
        ],
      ),
      drawer: drawer,
      body: body,
      floatingActionButton: floatingActionButton,
    );
  }
}
