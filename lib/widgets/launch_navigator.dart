import 'package:flutter/material.dart';
import 'package:motiv_hackathon_app/blocs/auth_screen_bloc.dart';
import 'package:motiv_hackathon_app/blocs/launch_navigator_bloc.dart';
import 'package:motiv_hackathon_app/blocs/user_repository_bloc.dart';
import 'package:motiv_hackathon_app/screens/auth/auth_screen.dart';
import 'package:motiv_hackathon_app/screens/home/home_screen.dart';
import 'package:motiv_hackathon_app/utils/enums.dart';
import 'package:provider/provider.dart';

class LaunchNavigator extends StatelessWidget {
  const LaunchNavigator({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userRepositoryBloc = Provider.of<UserRepositoryBloc>(context);
    final launchNavigatorBloc = Provider.of<LaunchNavigatorBloc>(context);
    final launchPage = _getPage(userRepositoryBloc);
    launchNavigatorBloc.initPage(launchPage);
    switch (launchNavigatorBloc.selectedPage) {
      case LaunchPages.Auth:
        return ChangeNotifierProvider<AuthScreenBloc>(
          create: (_) => AuthScreenBloc(),
          child: AuthScreen(),
        );
        break;
      default:
        return HomeScreen();
    }
  }

  LaunchPages _getPage(UserRepositoryBloc userRepositoryBloc) {
    final authStatus = userRepositoryBloc.repository.getAuthorizedStatus();
    final isAuthorized = authStatus == AuthStatus.Authorized;
    return isAuthorized ? LaunchPages.Home : LaunchPages.Auth;
  }
}
