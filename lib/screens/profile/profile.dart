import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wtf_web/screens/onboarding/onboarding.dart';
import 'package:wtf_web/screens/profile/bloc/profile_bloc.dart';
import 'package:wtf_web/screens/profile/profile_details.dart';
import 'package:wtf_web/screens/widgets/custom_loader.dart';
import 'package:wtf_web/session_manager/global_data.dart';

class ProfileScreen extends StatefulWidget {
  static String routeName = '/ProfileScreen';

  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // final args = ModalRoute.of(context)!.settings.arguments as Map;
    return BlocProvider(
      lazy: false,
      create: (context) =>
          ProfileBloc()..add(FetchProfileEvent()), //args['id'].toString())),
      child: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          if (state is FetchUserInfoState) {
            return globalData.memberInfo != null
                ? Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [ProfileDetails(userInfo: state.userInfo)],
                  )
                : OnboardingFlow();
          }
          return CustomLoader();
        },
      ),
    );
  }
}
