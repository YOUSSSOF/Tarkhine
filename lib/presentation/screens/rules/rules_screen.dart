import 'package:flutter/material.dart';

import 'package:tarkhine/common/common.dart';

class RulesScreen extends StatefulWidget {
  const RulesScreen({super.key});

  @override
  State<RulesScreen> createState() => _RulesScreenState();
}

class _RulesScreenState extends State<RulesScreen> {
  final List<bool> isOpens = [
    false,
    false,
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
        title: 'قوانین',
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
                        text: 'حداقل سفارش',
                        opens: isOpens,
                        index: 0,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'حداقل سفارشات در رستوران های ترخینه، مبلغ 50,000 تومان است. برای ثبت، پردازش و ارسال سفارشات، باید حداقل، این مبلغ سفارش داده شود در غیر اینصورت سفارشات، ثبت نخواهد شد.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[1],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'فاصله تحویل',
                        opens: isOpens,
                        index: 1,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'ترخینه در ارسال سفارشات به نقاط دور محدودیدت دارد و حداکثر فاصله از رستوران های زنجیره ای ترخینه برای ارسال کالا، 6 کیلومتر است. لطفا قبل از ثبت سفارش، نزدیک ترین شعبه به محل ارسال را انتخاب کنید و از رعایت کردن حداکثر فاصله برای ارسال سفارشات اطمینان حاصل فرمایید.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[2],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'زمان تحویل',
                        opens: isOpens,
                        index: 2,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'جدول زمانی تخمینی تحویل در زمان ثبت سفارش به اطلاع شما خواهد رسید. این ممکن است تحت تاثیر عوامل زیادی مانند ترافیک، آب و هوا، دوره های شلوغ رستوران و غیره باشد، بنابراین در صورت تاخیر لطفا صبور باشید.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[3],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'گزینه‌های پرداخت',
                        opens: isOpens,
                        index: 3,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'ما گزینه های مختلفی را می پذیریم، از جمله پرداخت اینترنتی، کارت های اعتباری یا پول نقد. لطفا قبل از تکمیل سفارش، روش اینترنتی پرداختی را که ترجیح میدهید، تایید کنید.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[4],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'دقت سفارش',
                        opens: isOpens,
                        index: 4,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'لطفا قبل از ارسال، از دقیق بودن تمام جزئیات سفارش خود، از جمله موارد منو ، درستورالعمل های خاص و جزئیات سفارش خود اطمینان حاصل کنید تا اختلالی در فرایند پردازش و تحویل سفارشات شما ایجاد نشود و سفارشات شما در سریع ترین زمان ممکن به دستتان برسد.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[5],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'شرایط لغو سفارش',
                        opens: isOpens,
                        index: 5,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'شما می توانید با تماس مستقیم با هر شعبه از رستوران های زنجیره ای ترخینه، سفارش خود را لغو کنید. لطفا توجه داشته باشید که ممکن است محدودیت زمانی برای لغو وجود داشته باشد، زیرا ممکن است غذا از قبل آماده شده باشد و در این صورت متاسفانه امکان لغو سفارش وجود ندارد.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[6],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'شرایط بازگشت سفارش',
                        opens: isOpens,
                        index: 6,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'اگر سفارش شما انتظارات شما را برآورده نمی کند، لطفا بلافاصله از طریق تماس تلفنی با ما تماس بگیرید؛ ما در اسرع وقت به دنبال حل مشکل شما خواهیم بود.',
                      ),
                    ),
                    ExpansionPanel(
                      canTapOnHeader: true,
                      isExpanded: isOpens[7],
                      headerBuilder: (_, isOpen) => YxExpansionalHeader(
                        text: 'تخفیفات',
                        opens: isOpens,
                        index: 7,
                      ),
                      body: const YxExpansionBody(
                        text:
                            'هرگونه تخفیف یا برنامه های وفاداری ممکن است قوانین و شرایط خاصی داشته باشد که به وضوح در وب سایت مشخص می شود.',
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
