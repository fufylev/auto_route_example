import 'package:auto_route/auto_route.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Объект роута
class NavigationRouteData extends Equatable {
  final String? name;

  const NavigationRouteData(this.name);

  factory NavigationRouteData.fromRoute(Route route) => NavigationRouteData(route.data?.name);

  factory NavigationRouteData.fromTabRoute(TabPageRoute route) => NavigationRouteData(route.name);

  @override
  List<Object?> get props => [name];
}
