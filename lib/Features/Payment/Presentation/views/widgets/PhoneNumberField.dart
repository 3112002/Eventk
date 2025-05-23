import 'package:eventk/Features/Payment/Presentation/views/widgets/phoneNoValidation.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Phonenumberfield extends StatelessWidget {
  final TextEditingController phoneController;
  const Phonenumberfield({super.key, required this.phoneController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: phoneController,
      keyboardType: TextInputType.phone,
      validator: (value) {
        final currentValid =
            Phonenovalidation.isvalidNumber(phoneController.text);

        if (value == null || value.isEmpty) {
          return 'Please enter your phone number';
        }
        if (!currentValid) {
          return 'Enter a valid phone number';
        }
        return null;
      },
      style: TextStyle(
        fontSize: 16.sp,
        color: Colors.black87,
        fontWeight: FontWeight.w500,
      ),
      decoration: InputDecoration(
        hintText: "Enter your phone number",
        hintStyle: TextStyle(
          color: Colors.grey[600],
          fontSize: 16.sp,
        ),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            ClipOval(
              child: Image.asset(
                "assets/Images/Egypt.jpg",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 6.w,
            ),
            Text(
              "+20",
              style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87),
            )
          ]),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: kButtonsColor,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: Colors.grey[300]!,
            width: 1.5,
          ),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      ),
    );
  }
}
