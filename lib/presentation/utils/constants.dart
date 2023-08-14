import 'package:flutter/material.dart';

const kBottomPlayerBarHeight = 74.0;
const kPagePadding = EdgeInsets.symmetric(vertical: 16);
final destinations = [
  const NavigationRailDestination(
    icon: Icon(Icons.explore_outlined),
    selectedIcon: Icon(Icons.explore),
    label: Text('Explore'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.featured_play_list_outlined),
    selectedIcon: Icon(Icons.featured_play_list),
    label: Text('Listening History'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.library_music_outlined),
    selectedIcon: Icon(Icons.library_music),
    label: Text('My Library'),
  ),
  const NavigationRailDestination(
    icon: Icon(Icons.settings_applications_outlined),
    selectedIcon: Icon(Icons.settings_applications),
    label: Text('Settings'),
  ),
];
const kCoverImagePlaceHolderUrl = 'https://shorturl.at/dru03';
