import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

//FICHIER NON UTILISE MAIS A FAIRE EN SORTE DE L'INTEGRER A L'AVENIR

class Analytics {
  final FirebaseAnalytics _analytics = FirebaseAnalytics();
  FirebaseAnalyticsObserver getAnalyticsObserver() => FirebaseAnalyticsObserver(analytics: _analytics);
  
  Future<void> mostViewedItem() async{
    _analytics.logViewItem(
        itemId: 'itemId',
        itemName: 'itemName',
        itemCategory: 'itemCategory'
    );
  }
}