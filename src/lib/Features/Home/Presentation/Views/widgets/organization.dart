import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Features/Home/Data/model/organizationModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
/*Yara❤️*/

bool isFollow = true;

class Organization extends StatefulWidget {
  Organization({super.key, required this.organizationss});
  OrganizationModel organizationss;

  @override
  State<Organization> createState() => _OrganizationState();
}

class _OrganizationState extends State<Organization> {
  @override
  void initState() {
    super.initState();
    isFollow = widget.organizationss.isFollowed ?? true;
  }

  @override
  Widget build(BuildContext context) {
    print(widget.organizationss.organizationId);
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Padding(padding: EdgeInsets.only(top: 20.h)),
        Container(
          height: 80.h,
          width: 80.w,
          decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.fill,
                image: NetworkImage(widget.organizationss.logo ?? ''),
              ),
              borderRadius: BorderRadius.circular(150)),
        ),
        Padding(padding: EdgeInsets.only(left: 10.w)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.organizationss.name,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: Styles.styleText14,
              ),
              Text(
                '${widget.organizationss.followersCount} Followers',
                style: Styles.styleText14.copyWith(color: Colors.grey),
              ),
              TextButton(
                onPressed: () {
                  setState(() {
                    isFollow = !isFollow;
                  });
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: isFollow
                      ? Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            'Follow',
                            style:
                                Styles.styleText16.copyWith(color: Colors.blue),
                          ),
                        )
                      : Align(
                          alignment: Alignment.bottomRight,
                          child: Text('Following',
                              style: Styles.styleText16.copyWith(
                                  color:
                                      const Color.fromARGB(159, 26, 26, 27))),
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
