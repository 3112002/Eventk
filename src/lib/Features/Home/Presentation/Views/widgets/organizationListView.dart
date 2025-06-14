/*Yara❤️*/
import 'package:eventk/Core/utils/styles.dart';
import 'package:eventk/Core/widgets/FailureScaffold.dart';
import 'package:eventk/Core/widgets/customLoadingWidgets.dart';
import 'package:eventk/Features/Home/Data/model/organizationModel.dart';
import 'package:eventk/Features/Home/Presentation/Manager/organization_cubit.dart';
import 'package:eventk/Features/Home/Presentation/Manager/organization_state.dart';
import 'package:eventk/Features/Home/Presentation/Views/orgainzationHome.dart';
import 'package:eventk/Features/Home/Presentation/Views/organizationDeatlis.dart';
import 'package:eventk/Features/Home/Presentation/Views/widgets/organization.dart';
import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

/*Yara Adel Mohamed Elsayed*/
bool isLoading = false;

class OrganizationListView extends StatelessWidget {
  const OrganizationListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrganizationCubit, OrganizationState>(
      builder: (context, state) {
        if (state is SuccessOrganizationState) {
          final displayedList = state.organizationList.take(5).toList();
          final hasMore = state.organizationList.length > 5;

          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: displayedList.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: GestureDetector(
                      child: Organization(
                        organizationss: displayedList[index],
                      ),
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => OrganizationPage()));
                      },
                    ),
                  );
                },
              ),
              if (hasMore)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrgainzationHome(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 183, 219, 246),
                    ),
                    child: Text(
                      'See more',
                      style: Styles.styleText20.copyWith(color: Colors.white),
                    ),
                  ),
                ),
            ],
          );
        } else if (state is FailureOrganizationState) {
          return SizedBox(
            height: 100.h,
            child: Text(
              state.errMessage,
              style: Styles.styleText20,
            ),
          );
        } else {
          return CustomLoadingWidgets();
        }
      },
    );
  }
}
