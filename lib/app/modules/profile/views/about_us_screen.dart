import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("معلومات عنا"),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: HtmlWidget(
            """
<!DOCTYPE html>
<html lang="en" dir="rtl">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>معلومات عنا</title>
  </head>
  <body>
    <h1>معلومات عنا</h1>
    <p>
      شريك هو تطبيق إعلاني سعودي جديد بخدمات جديدة ومتميزة، مختص في جمع الشركاء
      في عدة مجالات مختلفة مع الأشخاص الأنسب لموقعك واهتمامك.
    </p>
    <div>ابرز خدمات المنصة :</div>
    <ul>
      <li>
        <span>شريك أعمال :</span> وهو الشراكة والبيع في جميع انواع الأراضي
        والعقارات والمشاريع التجارية والتقنية.
      </li>
      <li>
        <span>شريك ذبيحتي : </span>وهو الشراكة والبيع في جميع أنواع الذبائح
        والمواشي.
      </li>
      <li>
        <span>شريك رحلتي :</span> وهو الشراكة في الرحلات الداخلية للتنقل ونقل
        الطرود عبر المناطق والمدن السعودية.
      </li>
      <li>
        <span>شريك سكني : </span> وهو تأجير الشقق والشراكة في السكن التشاركي مع
        الأشخاص من هم من نفس الجنس
      </li>
    </ul>
  </body>
</html>

""",
          ),
        ),
      ),
    );
  }
}
