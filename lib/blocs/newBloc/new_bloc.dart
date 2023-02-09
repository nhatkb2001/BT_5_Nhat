import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:excercise_2/blocs/newBloc/new_event.dart';
import 'package:excercise_2/blocs/newBloc/new_state.dart';
import 'package:excercise_2/models/new_model.dart';
import 'package:excercise_2/views/dashboard/dashboard.dart';

import '../../resources/newRepository/new_reponsitory.dart';

// import '../../resources/newRepository/newReponsitory.dart';

class ListNewBloc extends Bloc<NewEvent, NewState> {
  NewRepository newrepo;
  int page = 1;
  ListNewBloc(this.newrepo) : super(NewInit()) {
    on<GetNewListEvent>((event, emit) async {
      try {
        if (state is NewLoading) {
          return;
        }
        final currentState = state;

        var oldNewList = <NewModel>[];

        if (currentState is NewLoaded) {
          oldNewList = currentState.newList;
        }
        emit(NewLoading(oldNewList, isFirstFetch: page == 1));

        await newrepo.getNewList(page.toString()).then((value) {
          page++;
          final newList = (state as NewLoading).oldNewList;
          newList.addAll(value);
          emit(NewLoaded(newList));
        });
      } catch (e) {
        emit(NewError(e.toString()));
      }
    });
  }
}
