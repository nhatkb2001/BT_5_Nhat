import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../models/new_model.dart';

@immutable
abstract class NewState extends Equatable {
  const NewState();
  List<Object?> get props => [];
}

class NewInit extends NewState {}

class NewLoading extends NewState {
  List<NewModel> oldNewList;
  bool isFirstFetch;
  NewLoading(this.oldNewList, {this.isFirstFetch = false});
  @override
  // TODO: implement props
  List<Object?> get props => [oldNewList];
}

class NewLoaded extends NewState {
  final List<NewModel> newList;
  NewLoaded(this.newList);
  @override
  // TODO: implement props
  List<Object?> get props => [newList];
}

class NewError extends NewState {
  String message;
  NewError(this.message);
}
