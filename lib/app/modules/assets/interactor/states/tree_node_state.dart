

import 'package:tractian_challenge/app/core/errors/failures.dart';
import 'package:tractian_challenge/app/modules/assets/interactor/entities/tree_node_entity.dart';

sealed  class TreeNodeState {}

class InitialTreeNodeState implements TreeNodeState {}

class LoadingTreeNodeState implements TreeNodeState {}

class SuccessTreeNodeState implements TreeNodeState {
  const SuccessTreeNodeState({
    required this.data,
  });
  final List<TreeNodeEntity> data;
}

class ErrorTreeNodeState implements TreeNodeState {
  const ErrorTreeNodeState({
    required this.exception,
  });

  final Failure exception;
}