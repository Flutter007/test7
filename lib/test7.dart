import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test7/app_routes.dart';
import 'package:test7/provider/quotes_provider.dart';
import 'package:test7/screens/category_list_screen.dart';
import 'package:test7/screens/edit_quote_screen.dart';
import 'package:test7/screens/quote_form_screen.dart';
import 'package:test7/screens/quotes_list_screen.dart';
import 'package:test7/theme/light_theme.dart';

class Test7 extends StatelessWidget {
  const Test7({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) => QuotesProvider(),
      child: MaterialApp(
        theme: lightTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.home,
        routes: {
          AppRoutes.home: (context) => CategoryListScreen(),
          AppRoutes.quoteList: (context) => QuotesListScreen(),
          AppRoutes.create: (context) => QuoteFormScreen(),
          AppRoutes.edit: (context) => EditQuoteScreen(),
        },
      ),
    );
  }
}
