import 'package:eventk/Features/Home/Presentation/Views/allEventsPage.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/seeMoreEventsListView.dart';
import 'package:eventk/constants.dart';
import 'package:eventk/Features/Search/Presentation/Views/searchPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*Yara Adel*/
class SearchFields extends StatefulWidget {
  const SearchFields({this.comeFrom, this.onSearch});
  final String? comeFrom;
  final ValueChanged<String>? onSearch;
  @override
  State<SearchFields> createState() => _SearchFieldsState();
}

class _SearchFieldsState extends State<SearchFields> {
  late final bool isHome;
  late final bool isFilter;

  @override
  void initState() {
    super.initState();
    isHome = widget.comeFrom == 'Home';
    isFilter = widget.comeFrom == 'Filter';
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: 210.w,
        child: TextFormField(
          cursorColor: const Color.fromARGB(201, 11, 11, 11),
          cursorHeight: 24,
          readOnly: isHome,
          onTap: () {
            if (isHome) {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AllEventsPage(
                          endPoint: '',
                        )),
              );
            }
          },
          style: TextStyle(color: Colors.black),
          onChanged: isFilter
              ? (value) {
                  widget.onSearch?.call(value);
                }
              : null,
          onFieldSubmitted: isFilter
              ? (value) {
                  widget.onSearch?.call(value);
                }
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(
              vertical: 10.0.h,
              horizontal: 8.0.w,
            ),
            border: OutlineInputBorder(),
            labelText: 'Search Events',
            prefixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(
              // borderSide: BorderSide(color: kButtonsColor),
              borderRadius: BorderRadius.all(Radius.circular(20)).w,
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                // color: kButtonsColor,
                width: 1.w,
              ),
              borderRadius: BorderRadius.all(Radius.circular(20)).w,
            ),
            floatingLabelStyle: TextStyle(
              color: const Color.fromARGB(201, 11, 11, 11),
            ),
          ),
        ),
      ),
    );
  }
}
