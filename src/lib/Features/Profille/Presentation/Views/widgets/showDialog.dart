import 'package:eventk/constants.dart';
import 'package:flutter/material.dart';

import 'package:eventk/Features/Authentication/Presentation/Views/loginPage.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfile_cubit/deleteProfile_cubit.dart';
import 'package:eventk/Features/Profille/Presentation/manager/cubits/deleteProfile_cubit/deleteProfile_state.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

/*Yara Adel Mohamed*/
Future<void> ShowDialog(
    {required BuildContext context, required String password}) async {
  final cubit = context.read<DeleteprofileCubit>();
  bool? confirm = await showDialog<bool>(
    context: context,
    builder: (context) {
      return BlocProvider.value(
        value: cubit,
        child: BlocBuilder<DeleteprofileCubit, DeleteprofileStates>(
          builder: (context, state) {
            return AlertDialog(
              backgroundColor: kPrimaryColor,
              title: Text(
                'Are you sure you want to delete your account?',
                style: TextStyle(color: const Color.fromARGB(200, 0, 0, 0)),
              ),
              content: Text(
                'Deleting your account will remove all your data permanently. This action cannot be undone.',
                style: TextStyle(color: Colors.black),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: kButtonsColor),
                  ),
                ),
                TextButton(
                  onPressed: state is DeleteProfileLoadingState
                      ? null
                      : () async {
                          try {
                            await cubit.deleteProfile(password);
                            if (context.mounted) {
                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(builder: (_) => LoginPage()),
                                (route) => false,
                              );
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(e
                                      .toString()
                                      .replaceAll('CustomExceptions: ', '')),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            );
          },
        ),
      );
    },
  );
}
