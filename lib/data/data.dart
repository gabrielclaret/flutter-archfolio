import 'package:flutter_archfolio/model/models.dart';

final User currentUser = User(
  id: 1,
  name: 'Jane Doe',
  username: 'jdoe',
  email: 'jdoe@something.com',
  imageUrl:
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
  description: "Studies Architecture @ University of Architecture",
  location: "New York",
  joined_at: "March 2020",
);

final List<User> recentUsers = [users[1], users[3], users[6]];

final List<User> users = [
  User(
    id: 2,
    name: 'David Brooks',
    username: 'dbrooks',
    email: 'dbrooks@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 3,
    name: 'Jane Doe',
    username: 'jdoe',
    email: 'jdoe@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 4,
    name: 'Matthew Hinkle',
    username: 'mhinkle',
    email: 'mhinkle@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 5,
    name: 'Amy Smith',
    username: 'asmith',
    email: 'asmith@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 6,
    name: 'Ed Morris',
    username: 'emorris',
    email: 'emorris@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 7,
    name: 'Carolyn Duncan',
    username: 'cduncan',
    email: 'cduncan@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 8,
    name: 'Paul Pinnock',
    username: 'ppinnock',
    email: 'ppinnock@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 9,
    name: 'Elizabeth Wong',
    username: 'ewong',
    email: 'ewong@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 10,
    name: 'James Lathrop',
    username: 'jlathrop',
    email: 'jlathrop@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 11,
    name: 'Jessie Samson',
    username: 'jsamson',
    email: 'jsamson@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 12,
    name: 'David Scott',
    username: 'dscott',
    email: 'dscott@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 13,
    name: 'Lee Yun',
    username: 'lyun',
    email: 'lyun@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 14,
    name: 'Carolyn Paul',
    username: 'cpaul',
    email: 'cpaul@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1492562080023-ab3db95bfbce?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1331&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 15,
    name: 'Jean Paul',
    username: 'jpaul',
    email: 'jpaul@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=700&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 16,
    name: 'Lang Buddha',
    username: 'lbuddha',
    email: 'lbuddha@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1521119989659-a83eee488004?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=664&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 17,
    name: 'Tony',
    username: 'tony',
    email: 'tony@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1544005313-94ddf0286df2?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 18,
    name: 'Paul Cornwood',
    username: 'pcornwood',
    email: 'pcornwood@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1519631128182-433895475ffe?ixlib=rb-1.2.1&auto=format&fit=crop&w=1350&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 19,
    name: 'Mari Videl',
    username: 'mvidel',
    email: 'mvidel@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1515077678510-ce3bdf418862?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjF9&auto=format&fit=crop&w=675&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 20,
    name: 'Lara Croft',
    username: 'lcroft',
    email: 'lcroft@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1528892952291-009c663ce843?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=592&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
  User(
    id: 2,
    name: 'Jim Morris',
    username: 'jmorris',
    email: 'jmorris@something.com',
    imageUrl:
        'https://images.unsplash.com/photo-1517841905240-472988babdf9?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=634&q=80',
    description: "Studies Architecture @ University of Architecture",
    location: "New York",
    joined_at: "March 2020",
  ),
];

final List<ExploreCard> exploreCards = [
  ExploreCard(
    user: users[2],
    imageUrl:
        'https://images.unsplash.com/photo-1525286335722-c30c6b5df541?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=334&q=80',
    title: 'Gray Building',
  ),
  ExploreCard(
    user: users[6],
    imageUrl:
        'https://images.unsplash.com/photo-1494948141550-221698c089c2?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=401&q=80',
    title: 'Sky building',
    isViewed: true,
  ),
  ExploreCard(
    user: users[3],
    imageUrl:
        'https://images.unsplash.com/photo-1536154010-6ab8a1d741d2?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=375&q=80',
    title: 'Sky building',
  ),
  ExploreCard(
    user: users[9],
    imageUrl:
        'https://images.unsplash.com/photo-1506146829809-ecf5010c774f?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=401&q=80',
    title: 'Pattern',
    isViewed: true,
  ),
  ExploreCard(
    user: users[7],
    imageUrl:
        'https://images.unsplash.com/photo-1458310336304-9b584acc9b58?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=267&q=80',
    title: 'M format',
  ),
  ExploreCard(
    user: users[2],
    imageUrl:
        'https://images.unsplash.com/photo-1615892141416-64949e3a4791?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=282&q=80',
    title: 'Asian style',
  ),
  ExploreCard(
    user: users[6],
    imageUrl:
        'https://images.unsplash.com/photo-1585940043926-92f50991d354?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=375&q=80',
    title: 'Asian style',
    isViewed: true,
  ),
  ExploreCard(
    user: users[3],
    imageUrl:
        'https://images.unsplash.com/photo-1610114190332-14d22f956ddd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=335&q=80',
    title: 'European',
  ),
  ExploreCard(
    user: users[9],
    imageUrl:
        'https://images.unsplash.com/photo-1566869296469-609a90122355?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
    title: 'European',
    isViewed: true,
  )
];

final List<Post> recentPosts = [posts[1], posts[3]];

final List<Post> posts = [
  Post(
    id: 4,
    userId: users[2].id,
    title: 'Art Work',
    description: 'Check out these cool puppers',
    thumbnail:
        'https://images.unsplash.com/photo-1610114190332-14d22f956ddd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=335&q=80',
    likes: 800,
    views: 1202,
  ),
  Post(
    id: 2,
    userId: users[1].id,
    title: 'Project A',
    description: 'Please enjoy this placeholder text',
    thumbnail:
        'https://images.unsplash.com/photo-1525286335722-c30c6b5df541?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=334&q=80',
    likes: 821,
    views: 2214,
  ),
  Post(
    id: 1,
    userId: users[4].id,
    title: 'Building',
    description: 'This is a very good boi.',
    thumbnail:
        'https://images.unsplash.com/photo-1566869296469-609a90122355?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=334&q=80',
    likes: 221,
    views: 551,
  ),
  Post(
    id: 1,
    userId: users[1].id,
    title: 'Modern Stuff',
    description: 'Adventure 🏔',
    thumbnail:
        'https://images.unsplash.com/photo-1610114190332-14d22f956ddd?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=335&q=80',
    likes: 325,
    views: 1621,
  ),
  Post(
    id: 1,
    userId: users[0].id,
    title: 'Different Type',
    description: 'More placeholder text for the soul',
    thumbnail:
        'https://images.unsplash.com/photo-1458310336304-9b584acc9b58?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=267&q=80',
    likes: 251,
    views: 625,
  ),
  Post(
    id: 1,
    userId: users[1].id,
    title: 'Lorem',
    description: 'A classic.',
    thumbnail:
        'https://images.unsplash.com/photo-1585940043926-92f50991d354?ixlib=rb-1.2.1&ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&auto=format&fit=crop&w=375&q=80',
    likes: 735,
    views: 1526,
  ),
  Post(
    id: 1,
    userId: users[4].id,
    title: 'Ipsum',
    description: 'This is a very good boi.',
    thumbnail:
        'https://images.unsplash.com/photo-1505761671935-60b3a7427bad?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=750&q=80',
    likes: 7256,
    views: 12652,
  ),
  Post(
    id: 1,
    userId: users[3].id,
    title: 'Cool Project',
    description: 'Adventure 🏔',
    thumbnail:
        'https://images.unsplash.com/photo-1511818966892-d7d671e672a2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80',
    likes: 129,
    views: 459,
  ),
  Post(
    id: 1,
    userId: users[0].id,
    title: 'Sky',
    description: 'More placeholder text for the soul',
    thumbnail:
        'https://images.unsplash.com/photo-1461695008884-244cb4543d74?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=889&q=80',
    likes: 320,
    views: 705,
  ),
  Post(
    id: 1,
    userId: users[9].id,
    title: 'Project B',
    description: 'A classic.',
    thumbnail:
        'https://images.unsplash.com/photo-1431576901776-e539bd916ba2?ixid=MXwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHw%3D&ixlib=rb-1.2.1&auto=format&fit=crop&w=751&q=80',
    likes: 1523,
    views: 3001,
  )
];
final List<UserNotification> notifications = [
  UserNotification(
    user: users[1],
    interaction: 'like',
    post: posts[1],
    isViewed: false,
  ),
  UserNotification(
    user: users[2],
    interaction: 'comment',
    post: posts[2],
    isViewed: true,
  ),
  UserNotification(
    user: users[4],
    interaction: 'comment',
    post: posts[3],
    isViewed: true,
  ),
  UserNotification(
    user: users[2],
    interaction: 'follow',
    post: null,
    isViewed: false,
  )
];
