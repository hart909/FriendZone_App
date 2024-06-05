import 'package:flutter/material.dart';
import 'package:friendszone_app/screens/add_post_screen.dart';
import 'package:friendszone_app/screens/feed_screen.dart';

const webScreenSize = 600;

const homeScreenItems = [
  FeedScreen(),
  Text('Search'),
  AddPostScreen(),
  Text('Notif'),
  Text('Profile'),
];
