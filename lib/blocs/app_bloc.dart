import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';

class AppBloc {
  static final applicationCubit = ApplicationCubit();
  static final userCubit = UserCubit();
  static final authenticateCubit = AuthenticationCubit();
  static final wishListCubit = WishListCubit();
  static final reviewCubit = ReviewCubit();
  static final messageBloc = MessageBloc();
  static final submitCubit = SubmitCubit();

  static final List<BlocProvider> providers = [
    BlocProvider<ApplicationCubit>(
      create: (context) => applicationCubit,
    ),
    BlocProvider<UserCubit>(
      create: (context) => userCubit,
    ),
    BlocProvider<AuthenticationCubit>(
      create: (context) => authenticateCubit,
    ),
    BlocProvider<WishListCubit>(
      create: (context) => wishListCubit,
    ),
    BlocProvider<ReviewCubit>(
      create: (context) => reviewCubit,
    ),
    BlocProvider<MessageBloc>(
      create: (context) => messageBloc,
    ),
    BlocProvider<SubmitCubit>(
      create: (context) => submitCubit,
    ),
  ];

  static void dispose() {
    applicationCubit.close();
    userCubit.close();
    wishListCubit.close();
    authenticateCubit.close();
    reviewCubit.close();
    messageBloc.close();
    submitCubit.close();
  }

  ///Singleton factory
  static final AppBloc _instance = AppBloc._internal();

  factory AppBloc() {
    return _instance;
  }

  AppBloc._internal();
}
