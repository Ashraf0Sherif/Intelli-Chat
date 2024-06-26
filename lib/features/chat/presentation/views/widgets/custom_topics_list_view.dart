import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intellichat/features/auth/presentation/logic/login_cubit/login_cubit.dart';

import '../../../../../constants.dart';
import 'custom_remove_dialog.dart';

class CustomTopicsListView extends StatefulWidget {
  const CustomTopicsListView({super.key});

  @override
  State<CustomTopicsListView> createState() => _CustomTopicsListViewState();
}

class _CustomTopicsListViewState extends State<CustomTopicsListView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return ListView.separated(
          itemCount: BlocProvider.of<LoginCubit>(context).user!.topics!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return CustomRemoveAlertDialog(
                        topic: BlocProvider.of<LoginCubit>(context)
                            .user!
                            .topics![index]);
                  },
                );
              },
              onTap: () {
                setState(
                  () {
                    BlocProvider.of<LoginCubit>(context).changeTopicId(
                      BlocProvider.of<LoginCubit>(context)
                          .user!
                          .topics![index]
                          .id!,
                    );
                  },
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: BlocProvider.of<LoginCubit>(context).currentTopicId !=
                          BlocProvider.of<LoginCubit>(context)
                              .user!
                              .topics![index]
                              .id
                      ? Colors.grey.withOpacity(0.2)
                      : kSecondaryColor2,
                  border: Border.all(
                      color: Colors.white.withOpacity(0.3), width: 2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    BlocProvider.of<LoginCubit>(context)
                        .user!
                        .topics![index]
                        .title!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            );
          },
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }
}
