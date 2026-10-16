import 'package:flutter/material.dart';
import '../features/auth/presentation/screens/splash_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/register_screen.dart';
import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/household/presentation/screens/create_home_screen.dart';
import '../features/household/presentation/screens/invite_members_screen.dart';
import '../features/household/presentation/screens/family_members_screen.dart';
import '../features/dashboard/presentation/screens/main_navigation_screen.dart';
import '../features/inventory/domain/models/product_item.dart';
import '../features/inventory/presentation/screens/add_edit_product_screen.dart';
import '../features/inventory/presentation/screens/product_details_screen.dart';

class AppRouter {
  AppRouter._();

  // 01 - Auth Routes
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String forgotPassword = '/forgot-password';

  // 02 - Household Routes
  static const String createHome = '/create-home';
  static const String inviteMembers = '/invite-members';
  static const String familyMembers = '/family-members';

  // 03 - Main Layout & Home Dashboard
  static const String mainLayout = '/main-layout';

  // 04 - Inventory Routes
  static const String addEditProduct = '/add-edit-product';
  static const String productDetails = '/product-details';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());
      case createHome:
        return MaterialPageRoute(builder: (_) => const CreateHomeScreen());
      case inviteMembers:
        return MaterialPageRoute(builder: (_) => const InviteMembersScreen());
      case familyMembers:
        return MaterialPageRoute(builder: (_) => const FamilyMembersScreen());
      case mainLayout:
        return MaterialPageRoute(builder: (_) => const MainNavigationScreen());
      case addEditProduct:
        final product = settings.arguments as ProductItem?;
        return MaterialPageRoute(
          builder: (_) => AddEditProductScreen(product: product),
        );
      case productDetails:
        final product = settings.arguments as ProductItem? ??
            dummyInventoryItems.first;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(product: product),
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}