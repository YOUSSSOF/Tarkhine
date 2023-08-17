import 'package:flutter/material.dart';

import 'package:tarkhine/common/common.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({super.key});

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  final List<bool> isOpens = [
    false,
    false,
    false,
    false,
    false,
    false,
  ];
  void toggleOpen(index) {
    setState(() {
      isOpens[index] = !isOpens[index];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const YxAppbar(
        title: 'سوالات متداول',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFFCBCBCB),
                ),
              ),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: ExpansionPanelList(
                  elevation: 0,
                  dividerColor: const Color(
                    0xFFCBCBCB,
                  ),
                  expansionCallback: (index, isOpen) => toggleOpen(index),
                  children: [
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[0],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'امکانات ترخینه',
                        opens: isOpens,
                        index: 0,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'وبسایت سفارش غذای رستوران های زنجیره ای ترخینه با اتصال مستقیم به نرم افزار اتوماسیون شعبات رستوران، امکان اشتباهات هنگام ثبت سفارش آنلاین غذا و همچنین زمان مورد نیاز برای آماده سازی و تحویل آن را به حداقل ممکن می رسونه.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[1],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'حساب کاربری در ترخینه',
                        opens: isOpens,
                        index: 1,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'خیلی ساده پس از انتخاب غذای مورد علاقه تان از منوی رستوران، هنگام ثبت سفارش با واردکردن شماره تلفن همراه یک پیامک حاوی کد تایید برای شما ارسال و با وارد کردن کد تایید، ثبت نام شما تکمیل می شه. یا میتونید در صفحه ی اصلی سایت روی گزینه ورود کلیک کنید.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[2],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'سابقه خرید',
                        opens: isOpens,
                        index: 2,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'با ورود به حساب کاربری و کلیک روی گزینه سفارشات قبلی سابقه تمام خریدهای شما نمایش داده می شه.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[3],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'تفاوت قیمت در منو شعبات و منو وبسایت',
                        opens: isOpens,
                        index: 3,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'هنگام ثبت سفارش غذا میتونید روش پرداخت دلخواه تون رو انتخاب کنید. آنلاین و یا نقدی در هنگام تحویل سفارش بصورت حضوری.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[4],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'تفاوت قیمت در منو شعبات و منو وبسایت',
                        opens: isOpens,
                        index: 4,
                      ),
                      body: const YxText(
                        'بله. قیمت منوی وبسایت ترخینه دقیقا مطابق با قیمت منوی شعب رستوران است و در صورت تغییر قیمت از طرف رستوران این تغییر در وبسایت ترخینه بلافاصله قابل مشاهده است.',
                        overflow: TextOverflow.visible,
                      ).paddingH(20).paddingV(8),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[5],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'هدیه و تخفیف',
                        opens: isOpens,
                        index: 5,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'بله. قیمت منوی وبسایت ترخینه دقیقا مطابق با قیمت منوی شعب رستوران است و در صورت تغییر قیمت از طرف رستوران این تغییر در وبسایت ترخینه بلافاصله قابل مشاهده است.',
                      ),
                    ),
                  ],
                ),
              ),
            ).marginV(20).marginH(20),
          ],
        ),
      ),
    );
  }
}
