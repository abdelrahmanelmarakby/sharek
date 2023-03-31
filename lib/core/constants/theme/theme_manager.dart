import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sharek/core/constants/theme/theme_export.dart';
import 'package:sharek/core/extensions/color.dart';

import 'sizes_manager.dart';

///This app defines the Light  and Dark themes of the Suiiz app
///please change the theme with this way `EasyDynamicTheme.of(context).changeTheme();`
///if you want to know if the dark mode  is enabled check with this way => ``` bool isDarkModeOn = Theme.of(context).brightness == Brightness.dark; ```
class ThemeManager {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    primarySwatch: ColorsManager.primary.getMaterialColorFromColor(),

    colorScheme: ColorScheme.fromSwatch(
        primarySwatch: Colors.transparent.getMaterialColorFromColor(),
        accentColor: ColorsManager.accent,
        backgroundColor: ColorsManager.white,
        brightness: Brightness.light,
        cardColor: ColorsManager.white,
        errorColor: ColorsManager.error),
    //main colors of the app
    scaffoldBackgroundColor: ColorsManager.white,
    //primaryColor: ColorsManager.primary,
    dialogBackgroundColor: Colors.white,

    primaryColorLight: ColorsManager.primary,
    disabledColor: ColorsManager.lightGrey,

    splashColor: Colors.transparent,
    fontFamily: FontNames.fontName,
    //card theme for the cards
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.grey,
      elevation: Sizes.size4,
      margin: const EdgeInsets.all(Margins.xSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
        enableFeedback: true,
        backgroundColor: ColorsManager.primary,
        elevation: 8,
        shape: CircleBorder()),
    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      iconTheme: const IconThemeData(color: ColorsManager.black),
      backgroundColor: ColorsManager.white,
      shadowColor: ColorsManager.offWhite,
      centerTitle: true,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
      ),
      titleTextStyle: StylesManager.regular(
          color: ColorsManager.black, fontSize: FontSize.xXlarge),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorsManager.primary,
      disabledColor: ColorsManager.lightGrey,
      splashColor: ColorsManager.primary,
      textTheme: ButtonTextTheme.normal,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.primary,
        textStyle: StylesManager.bold(
          color: ColorsManager.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.primary,
        selectedItemColor: ColorsManager.accent,
        showSelectedLabels: true,
        unselectedItemColor: ColorsManager.grey,
        selectedLabelStyle: StylesManager.regular(
            color: ColorsManager.accent, fontSize: FontSize.small),
        unselectedLabelStyle: StylesManager.regular(
            color: ColorsManager.grey, fontSize: FontSize.xSmall)),
    textTheme: TextTheme(
      displayLarge: StylesManager.medium(
          color: ColorsManager.darkGrey, fontSize: Sizes.size18),
      titleMedium: StylesManager.medium(
          color: ColorsManager.darkGrey, fontSize: Sizes.size16),
      titleSmall: StylesManager.medium(
          color: ColorsManager.darkGrey, fontSize: Sizes.size14),
      bodySmall: StylesManager.regular(
        color: ColorsManager.lightGrey,
      ),
      bodyLarge: StylesManager.regular(color: ColorsManager.grey),
    ),
    badgeTheme: const BadgeThemeData(
      backgroundColor: ColorsManager.red,
    ),

    inputDecorationTheme: InputDecorationTheme(
      //border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: ColorsManager.lightGrey,
        ),
      ),
      //hint text style
      hintStyle: StylesManager.regular(
          color: ColorsManager.lightGrey, fontSize: FontSize.large),

      //focused ERROR border
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.lightGrey,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.lightGrey,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.white,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),

      suffixStyle: StylesManager.medium(color: ColorsManager.darkGrey),
      prefixStyle: StylesManager.medium(color: ColorsManager.darkGrey),
      focusColor: ColorsManager.success,
      //focused ERROR hint text style
      errorStyle: StylesManager.regular(color: ColorsManager.error),
      //focused Label text style
      labelStyle: StylesManager.medium(color: ColorsManager.grey),
      filled: true,
      fillColor: Colors.white,

      ///fill COLOR
      isDense: true,

      contentPadding: const EdgeInsets.symmetric(
        vertical: Paddings.xLarge,
        horizontal: Paddings.large,
      ),
    ),
  );
  // static ThemeData darkTheme = ThemeData(
  //   useMaterial3: true,
  //   colorScheme: const ColorScheme.dark(
  //     primary: ColorsManager.primary,
  //     secondary: ColorsManager.accent,
  //     background: ColorsManager.charcoal,
  //     surface: ColorsManager.veryDarkGrey,
  //     onPrimary: ColorsManager.white,
  //     onSecondary: ColorsManager.white,
  //     onBackground: ColorsManager.offWhite,
  //     onSurface: ColorsManager.lightGrey,
  //   ),
  //   brightness: Brightness.dark,
  //   primaryColor: ColorsManager.primary,
  //   scaffoldBackgroundColor: ColorsManager.charcoal,
  //   textTheme: const TextTheme(
  //     displayLarge: TextStyle(
  //         fontSize: 22,
  //         color: ColorsManager.white,
  //         fontWeight: FontWeight.bold),
  //     displayMedium: TextStyle(
  //         fontSize: 20,
  //         color: ColorsManager.white,
  //         fontWeight: FontWeight.bold),
  //     displaySmall: TextStyle(
  //         fontSize: 18,
  //         color: ColorsManager.white,
  //         fontWeight: FontWeight.bold),
  //     bodyLarge: TextStyle(fontSize: 16, color: ColorsManager.lightGrey),
  //     bodyMedium: TextStyle(fontSize: 14, color: ColorsManager.veryLightGrey),
  //   ),
  //   appBarTheme: AppBarTheme(
  //     color: ColorsManager.charcoal,
  //     iconTheme: const IconThemeData(
  //       color: ColorsManager.white,
  //     ),
  //     elevation: 0,
  //     toolbarTextStyle: const TextTheme(
  //       titleLarge: TextStyle(
  //           fontSize: 18,
  //           color: ColorsManager.white,
  //           fontWeight: FontWeight.bold),
  //     ).bodyMedium,
  //     titleTextStyle: const TextTheme(
  //       titleLarge: TextStyle(
  //           fontSize: 18,
  //           color: ColorsManager.white,
  //           fontWeight: FontWeight.bold),
  //     ).titleLarge,
  //   ),
  //   buttonTheme: ButtonThemeData(
  //     buttonColor: ColorsManager.accent,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //   ),
  //   cardTheme: CardTheme(
  //     color: ColorsManager.charcoal,
  //     elevation: 0,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //   ),
  //   bottomNavigationBarTheme: const BottomNavigationBarThemeData(
  //     selectedItemColor: ColorsManager.accent,
  //     unselectedItemColor: ColorsManager.veryLightGrey,
  //     backgroundColor: ColorsManager.veryDarkGrey,
  //     elevation: 0,
  //     selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
  //   ),
  //   inputDecorationTheme: InputDecorationTheme(
  //     border: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: const BorderSide(color: ColorsManager.veryLightGrey),
  //     ),
  //     focusedBorder: OutlineInputBorder(
  //       borderRadius: BorderRadius.circular(8),
  //       borderSide: const BorderSide(color: ColorsManager.selection),
  //     ),
  //     labelStyle: const TextStyle(color: ColorsManager.veryLightGrey),
  //   ),
  // );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    //main colors of the app
    scaffoldBackgroundColor: ColorsManager.black,
    primaryColor: ColorsManager.accent,
    primaryColorLight: ColorsManager.accent,
    disabledColor: ColorsManager.darkGrey,
    platform: TargetPlatform.iOS,
    splashColor: ColorsManager.accent,
    fontFamily: FontNames.fontName,
    //card theme for the cards
    cardTheme: CardTheme(
      color: ColorsManager.white,
      shadowColor: ColorsManager.grey,
      elevation: Sizes.size4,
      margin: const EdgeInsets.all(Margins.xSmall),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    appBarTheme: AppBarTheme(
      elevation: Sizes.size4,
      iconTheme: const IconThemeData(color: ColorsManager.white),
      backgroundColor: ColorsManager.accent,
      shadowColor: ColorsManager.accent,
      // systemOverlayStyle: const SystemUiOverlayStyle(
      //   systemNavigationBarIconBrightness: Brightness.dark,
      //   statusBarIconBrightness: Brightness.dark,
      //   systemNavigationBarColor: Color(0xffdddeee), // Navigation bar
      //   statusBarColor: Color(0xffdddeee), // Status bar
      // ),
      titleTextStyle: StylesManager.regular(
          color: ColorsManager.white, fontSize: FontSize.large),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: ColorsManager.accent,
      disabledColor: ColorsManager.darkGrey,
      splashColor: ColorsManager.accent,
      textTheme: ButtonTextTheme.accent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsManager.accent,
        textStyle: StylesManager.bold(
          color: ColorsManager.white,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.white,
        selectedItemColor: ColorsManager.selection,
        showSelectedLabels: true,
        unselectedItemColor: ColorsManager.grey,
        selectedLabelStyle:
            StylesManager.bold(color: Colors.white, fontSize: FontSize.large),
        unselectedLabelStyle: StylesManager.regular(
            color: ColorsManager.grey, fontSize: FontSize.medium)),
    textTheme: TextTheme(
      bodyMedium: StylesManager.regular(color: ColorsManager.grey),
      displayLarge: StylesManager.medium(
          color: ColorsManager.lightGrey, fontSize: FontSize.large),
      titleMedium: StylesManager.medium(
          color: ColorsManager.lightGrey, fontSize: FontSize.medium),
      titleSmall: StylesManager.medium(
          color: ColorsManager.lightGrey, fontSize: FontSize.medium),
      bodySmall: StylesManager.regular(
          color: ColorsManager.darkGrey, fontSize: FontSize.small),
      bodyLarge: StylesManager.regular(color: ColorsManager.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      //border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12.0),
        borderSide: const BorderSide(
          color: ColorsManager.darkGrey,
        ),
      ),
      //hint text style
      hintStyle: StylesManager.regular(
          color: ColorsManager.darkGrey, fontSize: Sizes.size12),
      //focused ERROR border
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.darkGrey,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.darkGrey,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ColorsManager.darkGrey,
        ),
        borderRadius: BorderRadius.circular(12.0),
      ),

      suffixStyle: StylesManager.medium(color: ColorsManager.grey),
      focusColor: ColorsManager.success,
      //focused ERROR hint text style
      errorStyle: StylesManager.regular(color: ColorsManager.error),
      //focused Label text style
      labelStyle: StylesManager.medium(color: ColorsManager.grey),
      filled: true,
      fillColor: Colors.white,

      ///fill COLOR
      isDense: true,
      contentPadding: const EdgeInsets.symmetric(
        vertical: Paddings.xLarge,
        horizontal: Paddings.large,
      ),
    ),
  );
}
