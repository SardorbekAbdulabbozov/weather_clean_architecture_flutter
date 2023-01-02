import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_clean_architecture/app.dart';
import 'package:weather_clean_architecture/features/home/presentation/bloc/home_bloc.dart';
import 'injector_container.dart' as di;
import 'injector_container.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<HomeBloc>(),
        ),
      ],
      child: const WeatherApp(),
    );
  }
}
