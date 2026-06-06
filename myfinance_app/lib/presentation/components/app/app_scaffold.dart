import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myfinance_app/app_route.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final Widget? drawer;
  final Widget? floatingActionButton;
  final Future<void> Function()? onRefreshBody;

  Future<void> _onRefreshDefault() {
    return Future.delayed(Duration(seconds: 3));
  }

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.drawer,
    this.floatingActionButton,
    this.onRefreshBody,
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
      body: RefreshIndicator.adaptive(
        onRefresh: onRefreshBody ?? _onRefreshDefault,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: body,
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
