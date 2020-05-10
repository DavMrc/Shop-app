import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './widgets/WSplashScreen.dart';
import './screens/screens.dart';
import './providers/providers.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
    // TODO: these might become ChangeNotifierProvider.value()
    providers: [
      ChangeNotifierProvider(
        create: (_) => PAuth(),
      ),
      ChangeNotifierProxyProvider<PAuth, PProducts>(  // products provider, depends on PAuth
        update: (_, auth, previousProducts) => PProducts(
          auth.userId,
          auth.token,
          previousProducts == null ? [] : previousProducts.all
        ),
        create: (_) => null,
      ),
      ChangeNotifierProxyProvider<PAuth, POrders>( // orders provider
        update: (_, auth, previousOrders) => POrders(
          auth.userId,
          auth.token,
          previousOrders == null ? [] : previousOrders.orders
        ),
        create: (_) => null,
      ),
      ChangeNotifierProvider(  // cart provider
        create: (ctx) => PCart(),
      ),
    ],  
      child: Consumer<PAuth>(
        builder: (_, auth, __) => MaterialApp(
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: "Lato",
          ),
          routes: {
            // '/': (_) => SProducts(),
            // '/': (_) => auth.isAuth ? SProducts() : SAuthScreen(),
            '/': (_) => auth.isAuth
            ? SProducts()
            : FutureBuilder(
              future: auth.tryAutoLogin(),
              builder: (_, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return WSplashScreen();
                }else if(snapshot.connectionState == ConnectionState.done){
                  return SAuthScreen();
                }
              },
            ),
            SProductDetail.routeName: (_) => SProductDetail(),
            SCart.routeName: (_) => SCart(),
            SOrders.routeName: (_) => SOrders(),
            SUserProducts.routeName: (_) => SUserProducts(),
            SNewProduct.routeName: (_) => SNewProduct(),
          },
        ),
      ),
    );
  }
}
