import 'package:equatable/equatable.dart';

import '../../models/new_model.dart';

abstract class NewEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetNewListEvent extends NewEvent {}
