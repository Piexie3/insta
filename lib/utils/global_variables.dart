import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:insta/presentation/home_screen.dart';

import '../presentation/add_post_screen.dart';
import '../presentation/profile_screen.dart';
import '../presentation/search_screen.dart';

const mobileScreenSize = 600;

 List<Widget>homeScreenItems = [
  const HomeScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const Text('Reels screen'),
  ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid,)

];