import 'dart:math';

import 'package:flutter_archfolio/screens/create_post_screen.dart';
import 'package:flutter_archfolio/widgets/post_container.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:integration_test/integration_test.dart';

import 'package:flutter_archfolio/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Teste da Welcome Screen', () {
    testWidgets(
        'Cenário: Clica no botão de Sign Up - Verifica os elementos presentes',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('signUpButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      print('Taps Sign Up button');

      print('Verifies elements of Sign Up Screen');
      expect(find.byKey(ValueKey('nameFieldSUScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('usernameFieldSUScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('emailFieldSUScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('passwordFieldSUScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('rpasswordFieldSUScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('signUpButtonSUScreen')), findsOneWidget);
    });

    testWidgets(
        'Cenário: Clica no botão de Login - Verifica os elementos presentes',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('loginButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      print('Taps Login button');

      print('Verifies elements of Login Screen');
      expect(find.byKey(ValueKey('usernameFieldLScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('passwordFieldLScreen')), findsOneWidget);
      expect(find.byKey(ValueKey('loginButtonLScreen')), findsOneWidget);
    });
  });

  group('Teste de Login', () {
    testWidgets(
        'Cenário: Entra na tela de login - Preenche os campos - Realiza o Login - Verifica se teve êxito',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('loginButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();
      print('Taps Login button');

      print('Verifies elements of Login Screen');
      expect(find.byKey(ValueKey('loginButtonLScreen')), findsOneWidget);

      final usernameField = find.byKey(ValueKey('usernameFieldLScreen'));
      final passwordField = find.byKey(ValueKey('passwordFieldLScreen'));
      final loginButton = find.byKey(ValueKey('loginButtonLScreen'));

      await tester.enterText(usernameField, 'test1');
      await tester.enterText(passwordField, 'test1');
      print('Fills username and password fields');

      await tester.tap(loginButton);
      await tester.pumpAndSettle();
      print('Taps Login button');

      print('Checks element of Nav Screen');
      expect(find.byKey(ValueKey('navScreenCustomBar')), findsOneWidget);
    });
  });

  group('Teste da Home Screen', () {
    testWidgets(
        'Cenário: Realiza o login - Clica no primeiro post - Verifica - Volta - Clica no Bookmarks - Verifica',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('loginButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('loginButtonLScreen')), findsOneWidget);

      final usernameField = find.byKey(ValueKey('usernameFieldLScreen'));
      final passwordField = find.byKey(ValueKey('passwordFieldLScreen'));
      final loginButton = find.byKey(ValueKey('loginButtonLScreen'));

      await tester.enterText(usernameField, 'test1');
      await tester.enterText(passwordField, 'test1');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('navScreenCustomBar')), findsOneWidget);

      final firstPost = find.byType(PostContainer).first;

      await tester.tap(firstPost);
      await tester.pumpAndSettle();
      print('Taps first post');

      expect(find.byKey(ValueKey('postTitleViewPostScreen')), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      print('Taps back');

      final bookmarkButton = find.byKey(ValueKey('bookmarkButton'));

      await tester.tap(bookmarkButton);
      await tester.pumpAndSettle();
      print('Taps bookmark button');

      print('Checks element of Bookmark Screen');
      expect(find.byKey(ValueKey('bookmarkScreenText')), findsOneWidget);
    });
  });

  group('Teste da Profile Screen', () {
    testWidgets(
        'Cenário: Realiza o login - Vai para a tela de Perfil - Clica para Editar Perfil - Verifica',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('loginButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('loginButtonLScreen')), findsOneWidget);

      final usernameField = find.byKey(ValueKey('usernameFieldLScreen'));
      final passwordField = find.byKey(ValueKey('passwordFieldLScreen'));
      final loginButton = find.byKey(ValueKey('loginButtonLScreen'));

      await tester.enterText(usernameField, 'test1');
      await tester.enterText(passwordField, 'test1');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('navScreenCustomBar')), findsOneWidget);

      final profileTab = find.byKey(ValueKey('tab4'));

      await tester.tap(profileTab);
      await tester.pumpAndSettle();
      print('Taps profile tab');

      final editProfileButton = find.byKey(ValueKey('editProfileButton'));

      await tester.tap(editProfileButton);
      await tester.pumpAndSettle();
      print('Taps edit profile');

      print('Checks element of Bookmark Screen');
      expect(find.byKey(ValueKey('saveButton')), findsOneWidget);
    });
  });

  group('Teste da Explore Screen', () {
    testWidgets(
        'Cenário: Realiza o login - Vai para a tela de Explore - Clica no primeiro post - Verifica - Volta - Clica no botão de Search - Verifica',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('loginButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('loginButtonLScreen')), findsOneWidget);

      final usernameField = find.byKey(ValueKey('usernameFieldLScreen'));
      final passwordField = find.byKey(ValueKey('passwordFieldLScreen'));
      final loginButton = find.byKey(ValueKey('loginButtonLScreen'));

      await tester.enterText(usernameField, 'test1');
      await tester.enterText(passwordField, 'test1');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('navScreenCustomBar')), findsOneWidget);

      final exploreTab = find.byKey(ValueKey('tab1'));

      await tester.tap(exploreTab);
      await tester.pumpAndSettle();
      print('Taps explore tab');

      final firstPost = find.byType(PostContainer).first;

      await tester.tap(firstPost);
      await tester.pumpAndSettle();
      print('Taps first post');

      expect(find.byKey(ValueKey('postTitleViewPostScreen')), findsOneWidget);

      await tester.tap(find.byTooltip('Back'));
      await tester.pumpAndSettle();
      print('Taps back');

      final searchButton = find.byKey(ValueKey('searchButton'));

      await tester.tap(searchButton);
      await tester.pumpAndSettle();
      print('Taps search button');

      print('Checks element of Search Screen');
      expect(find.byKey(ValueKey('searchField')), findsOneWidget);
    });
  });

  group('Teste da Create Screen', () {
    testWidgets(
        'Cenário: Realiza o login - Vai para a tela de Create - Verifica os campos - Adiciona um conteúdo - Exclui o conteúdo',
        (WidgetTester tester) async {
      app.main();

      await tester.pumpAndSettle();

      final buttonFinder = find.byKey(ValueKey('loginButton'));

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('loginButtonLScreen')), findsOneWidget);

      final usernameField = find.byKey(ValueKey('usernameFieldLScreen'));
      final passwordField = find.byKey(ValueKey('passwordFieldLScreen'));
      final loginButton = find.byKey(ValueKey('loginButtonLScreen'));

      await tester.enterText(usernameField, 'test1');
      await tester.enterText(passwordField, 'test1');
      await tester.tap(loginButton);
      await tester.pumpAndSettle();

      expect(find.byKey(ValueKey('navScreenCustomBar')), findsOneWidget);

      final createTab = find.byKey(ValueKey('tab2'));

      await tester.tap(createTab);
      await tester.pumpAndSettle();
      print('Taps create tab');

      final createContentButton = find.byTooltip('Show menu');

      await tester.tap(createContentButton);
      await tester.pumpAndSettle();
      print('Taps create content button');

      final addTextPopup = find.byKey(ValueKey('addTextPopup'));
      await tester.tap(addTextPopup);
      await tester.pumpAndSettle();
      print('Taps create text popup');

      print('Checks if there is 2 Text Fields');
      expect(find.byType(ContentTextFields), findsNWidgets(2));

      final removeContentButton = find.byKey(ValueKey('removeContentButton'));
      await tester.tap(removeContentButton);
      await tester.pumpAndSettle();
      print('Taps remove content button');
      
       print('Checks if there is 1 Text Field');
      expect(find.byType(ContentTextFields), findsOneWidget);
    });
  });
}
