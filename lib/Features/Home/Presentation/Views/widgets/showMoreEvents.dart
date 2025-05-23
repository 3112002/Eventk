import 'package:eventk/Core/Services/get_it_services.dart';
import 'package:eventk/Core/dataBase/Cache/Cache_Helper.dart';
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Data/model/get_events_model/get_events_model.dart';
import 'package:eventk/Features/Home/Presentation/Views/allEventsPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:line_icons/line_icons.dart';

/*Yara Adel Mohamed❤️*/
class ShowMoreEvents extends StatelessWidget {
  const ShowMoreEvents({super.key, this.endPoint, this.name});
  final String? endPoint;
  final String? name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 1.h),
      child: Align(
        alignment: Alignment.topCenter,
        child: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    AllEventsPage(endPoint: endPoint, name: name),
              ),
            );
          },
          child: Container(
            width: 200.w,
            height: 220.h,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: const Color.fromARGB(255, 225, 239, 250),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: Offset(5, 10),
                  )
                ]),
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      // color: const Color.fromARGB(
                      //     176, 253, 254, 254),
                      color: Color(0xFFF5FAFE),
                    ),
                    child: Icon(
                      LineIcons.arrowRight,
                      size: 40,
                      color: Colors.blue,
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 10.h)),
                  Text(
                    'See all events',
                    style: Styles.styleText20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
