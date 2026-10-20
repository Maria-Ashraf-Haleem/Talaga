<div align="center">

# Talaga
### Shared Household Fridge and Grocery Management Application

![Flutter](https://img.shields.io/badge/Flutter-3.x-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-3.x-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20%2F%20Feature--First-165B3D?style=for-the-badge)
![Platform](https://img.shields.io/badge/Platform-Android%20%7C%20iOS%20%7C%20Windows-4CAF50?style=for-the-badge)

</div>

---

## Overview

**Talaga** is a collaborative household fridge inventory and grocery management application built with Flutter. It is designed to help families and shared households track food quantities, monitor product expiration dates, manage shared shopping lists in real time, and receive automated alerts for low-stock and expiring items.

---

## App Screens Preview

![Talaga App Screens](assets/screenshots/app_screens.jpeg)

---

## Core Features and Modules

The application is structured into **7 main modules** comprising **15 screens**:

### 01. Authentication
* **Splash Screen:** Displays the application branding and transitions automatically to the authentication flow.
* **Login:** Supports email and password authentication as well as social sign-in via Google and Apple.
* **Register:** Allows new users to create an account and join or set up a household.
* **Forgot Password:** Enables password recovery via an email reset link.
* **Household Verification:** Automatically checks after sign-in whether the user account is linked to an existing household.

### 02. Household Setup
* **Create Your Home:** Allows users to initialize a new household space with a custom name.
* **Invite Members:** Generates a unique, verifiable invitation code (e.g., `7K8M2P`) and a shareable invite link with quick-copy and direct sharing options (WhatsApp, Messages, More).
* **Family Members Management:** Displays all household members along with their assigned roles (`Owner` or `Member`) and provides an option to invite additional members.

### 03. Home Dashboard
Serves as the primary control center after authentication and household setup:
* **Total Items:** Displays the total count of products currently stored in the fridge.
* **Low Stock:** Highlights items that have reached or fallen below their minimum quantity threshold.
* **Expiring Soon:** Tracks products approaching their expiration date within a few days.
* **Expired Items:** Flags expired products that require immediate removal or review.
* **Shopping List Summary:** Displays the total number of pending items on the shared grocery list.
* **Quick Add Action:** Provides a direct `+ Add Item` button to register new products immediately.

### 04. Fridge Inventory
* **Inventory List:** Displays all stored products with their current quantities, units, and color-coded expiration status indicators.
* **Search and Filter Modal:**
    * **Category Filtering:** Filter items by `All`, `Fruits`, `Vegetables`, `Dairy`, `Meat`, `Grains`, `Beverages`, or `Other`.
    * **Sorting Options:** Sort inventory by `Name (A - Z)`, `Name (Z - A)`, `Expiry Date (Soonest)`, or `Expiry Date (Latest)`.
* **Add / Edit Product Form:** Supports product photo upload, product name, category selection, quantity, measurement unit (`kg`, `g`, `liter`, `pieces`, `pack`), minimum quantity threshold, expiration date picker, and optional storage notes.
* **Product Details:** Displays complete product metadata with dedicated `Edit` and `Delete` actions.

### 05. Shared Shopping List
* Displays shared grocery items needed by the household along with required quantities.
* Supports instant manual item addition, quantity updates, and item removal.
* Allows members to mark items as purchased and transfer selected items directly to the fridge inventory via the `Add to Inventory` action.

### 06. Alerts and Activity
* **Categorized Alerts:** Filterable notification feed for `All`, `Low Stock`, `Expiring`, and `Expired` product alerts.
* **Recent Activity Log:** Chronological audit trail showing additions, updates, and deletions performed by household members, including member names and timestamps.

### 07. Profile and Settings
* **User Profile:** Displays current user account details.
* **Home and Members:** Quick navigation to household details (`My Home`) and member administration (`Manage Members`).
* **Notification Preferences:** Granular toggle controls for `Push Notifications`, `Expiry Reminders`, and `Low Stock Alerts`.
* **Application Controls:** Language selection, session logout, and role-based household leave or deletion options.

---

## Navigation and User Flow

### Bottom Navigation Structure
The main layout features a persistent 5-tab `BottomNavigationBar`:
1. **Home:** Home Dashboard and status overview.
2. **Inventory:** Fridge Inventory list and search.
3. **Shopping:** Shared Shopping List.
4. **Alerts:** Notifications and Recent Activity log.
5. **More:** Profile, Household Management, and App Settings.

*(Authentication screens, Household Setup screens, Add/Edit Product form, and Product Details operate as standalone routes outside the bottom navigation bar).*

### User Journey Diagram

```text
App Launch (Splash Screen)
   |
   v
Authentication (Login / Register)
   |
   v
Is User Linked to a Household?
   |-- No  --> Create New Home --> Invite Members
   |                                     |
   |-- Yes <-- Load Household Data <-----/
                 |
                 v
         Home Dashboard (Main Layout)
                 |
      +----------+-----------+------------+------------+
      |          |           |            |            |
      v          v           v            v            v
  Inventory   Shopping     Alerts    Manage Home   Settings
```

### Add Product Workflow
1. Trigger the **Add Product** screen from the Home Dashboard or Inventory floating action button.
2. Enter the product name, category, quantity, unit, and minimum stock threshold.
3. Select the expiration date (if applicable) and add optional storage notes.
4. Validate inputs and save the product.
5. Automatically refresh the inventory list, dashboard counters, and alert notifications.

---

## Project Architecture

The codebase follows a modular **Feature-First Clean Architecture** pattern (`data`, `domain`, `presentation`) to ensure scalability, testability, and clear separation of concerns:

```text
lib/
├── main.dart
├── app/
│   ├── app.dart
│   ├── router.dart
│   └── theme/
│       ├── app_colors.dart
│       ├── app_text_styles.dart
│       └── app_theme.dart
├── core/
│   ├── constants/
│   ├── errors/
│   ├── services/
│   ├── utils/
│   └── widgets/
│       ├── custom_text_field.dart
│       ├── primary_button.dart
│       └── talaga_logo.dart
└── features/
    ├── auth/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       └── screens/
    │           ├── splash_screen.dart
    │           ├── login_screen.dart
    │           ├── register_screen.dart
    │           └── forgot_password_screen.dart
    ├── household/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       └── screens/
    │           ├── create_home_screen.dart
    │           ├── invite_members_screen.dart
    │           └── family_members_screen.dart
    ├── dashboard/
    │   └── presentation/
    │       └── screens/
    │           ├── main_navigation_screen.dart
    │           └── home_dashboard_screen.dart
    ├── inventory/
    │   ├── data/
    │   ├── domain/
    │   │   └── models/
    │   │       └── product_item.dart
    │   └── presentation/
    │       ├── screens/
    │       │   ├── fridge_inventory_screen.dart
    │       │   ├── add_edit_product_screen.dart
    │       │   └── product_details_screen.dart
    │       └── widgets/
    │           └── inventory_filter_sheet.dart
    ├── shopping/
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       └── screens/
    │           └── shopping_list_screen.dart
    ├── notifications/
    │   └── presentation/
    │       └── screens/
    │           └── alerts_activity_screen.dart
    └── profile/
        └── presentation/
            └── screens/
                └── profile_settings_screen.dart
```

---

## Design System and Color Palette

| Token | Hex Code | Usage |
| :--- | :--- | :--- |
| **Primary Green** | `#165B3D` | Primary buttons, active navigation states, brand identity |
| **Soft Green** | `#E6F2EC` | Secondary buttons, role badges, active category highlights |
| **Scaffold Background** | `#F6F7F9` | Default background surface across all screens |
| **Warning / Low Stock** | `#F59E0B` | Low stock indicators and warning badges |
| **Expiring Soon** | `#EA580C` | Upcoming expiration date highlights and alerts |
| **Expired / Danger** | `#DC2626` | Expired product alerts, delete actions, logout indicator |
| **Shopping Accent** | `#1D4ED8` | Shopping list counter card on the Home Dashboard |

---

## Getting Started

### Prerequisites
* Flutter SDK (`3.x` or later)
* Dart SDK (`3.x` or later)
* Android Studio or VS Code with Flutter extensions installed

### Installation and Execution

1. **Clone the repository:**
   ```bash
   git clone [https://github.com/Maria-Ashraf-Haleem/Talaga.git](https://github.com/Maria-Ashraf-Haleem/Talaga.git)
   cd Talaga
   ```

2. **Fetch project dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the application:**
   ```bash
   flutter run
   ```

---

## Author

**Maria Ashraf Haleem**
