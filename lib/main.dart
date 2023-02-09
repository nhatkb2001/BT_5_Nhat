import 'package:excercise_2/models/new_transaction.dart';
import 'package:excercise_2/resources/newRepository/new_reponsitory.dart';
import 'package:excercise_2/views/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';

import 'blocs/newBloc/new_bloc.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(NewTransactionAdapter());
  await Hive.openBox<NewTransaction>('NewTransaction');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: RepositoryProvider(
        create: (context) => NewRepository(),
        child: BlocProvider(
            create: (context) =>
                ListNewBloc(RepositoryProvider.of<NewRepository>(context)),
            child: const Dashboard()),
      ),
    );
  }
}
