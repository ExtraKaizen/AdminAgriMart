import 'package:agri_mart_admin/controllers/auth_service.dart';
import 'package:agri_mart_admin/firebase_options.dart';
import 'package:agri_mart_admin/providers/admin_provider.dart';
import 'package:agri_mart_admin/views/admin_home.dart';
import 'package:agri_mart_admin/views/categories_page.dart';
import 'package:agri_mart_admin/views/coupons.dart';
import 'package:agri_mart_admin/views/login.dart';
import 'package:agri_mart_admin/views/modify_product.dart';
import 'package:agri_mart_admin/views/modify_promo.dart';
import 'package:agri_mart_admin/views/orders_page.dart';
import 'package:agri_mart_admin/views/products_page.dart';
import 'package:agri_mart_admin/views/promo_banners_page.dart';
import 'package:agri_mart_admin/views/signup.dart';
import 'package:agri_mart_admin/views/view_product.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AdminProvider(),
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'AgriMart Admin',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // TRY THIS: Try running your application with "flutter run". You'll see
          // the application has a purple toolbar. Then, without quitting the app,
          // try changing the seedColor in the colorScheme below to Colors.green
          // and then invoke "hot reload" (save your changes or press the "hot
          // reload" button in a Flutter-supported IDE, or press "r" if you used
          // the command line to start the app).
          //
          // Notice that the counter didn't reset back to zero; the application
          // state is not lost during the reload. To reset the state, use hot
          // restart instead.
          //
          // This works for code too, not just values: Most code changes can be
          // tested with just a hot reload.
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          "/": (context) => CheckUser(),
          "/login": (context) => LoginPage(),
          "/signup": (context) => SingupPage(),
          "/home": (context) => AdminHome(),
          "/category": (context) => CategoriesPage(),
          "/products": (context) => ProductsPage(),
          "/add_product": (context) => ModifyProduct(),
          "/view_product": (context) => ViewProduct(),
          "/promos": (context) => PromoBannersPage(),
          "/update_promo": (context) => ModifyPromo(),
          "/coupons": (context) => CouponsPage(),
          "/orders": (context) => OrdersPage(),
          "/view_order": (context) => ViewOrder()
        },
      ),
    );
  }
}

class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    AuthService().isLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushReplacementNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
