import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

final List<String> problem = [
  'Lighting',
  'Openness',
  'Visibility',
  'People',
  'Security',
  'Walk Path',
  'Public Transport',
  'Gender Usage',
  'Safe Feeling',
];

final List<String> problemDescriptions = [
  'Availability of enough light \nto see all around you',
  'Ability to see and \nmove in all directions',
  'Vendors, shops, building \nentrances, windows and \nbalconies from where you can be seen',
  'Number of people\n around you',
  'Presence of police or\n security guards',
  'Either a pavement or \nroad with space to walk',
  'Availability of public \ntransport like metro, buses, autos,\nrickshaws',
  'Presence of women and \nchildren near you',
  'How safe do you feel'
];

class RatingsTabPage extends StatefulWidget {
  const RatingsTabPage({Key? key}) : super(key: key);

  @override
  State<RatingsTabPage> createState() => _RatingsTabPageState();
}

class _RatingsTabPageState extends State<RatingsTabPage> {
  late final List<double> _rating = List.filled(9, 1);
  final int _ratingBarMode = 1;
  final double _initialRating = 2.0;

  @override
  void initState() {
    super.initState();
    for (var i = 0; i < 9; i++) {
      _rating[i] = _initialRating;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Builder(
        builder: (context) => Scaffold(
          body: ListView.builder(
              itemCount: 9,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ListTile(
                    leading: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          problem[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        Text(
                          problemDescriptions[index],
                          style: const TextStyle(
                              fontWeight: FontWeight.normal, fontSize: 10),
                        ),
                      ],
                    ),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _ratingBar(index),
                        Text(
                          'Rating: '+_rating[index].toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }

  Widget _ratingBar(int index) {
    return RatingBar.builder(
      initialRating: _initialRating,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.0),
      itemSize: 30,
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Icon(
              Icons.sentiment_very_dissatisfied,
              color: Colors.red,
            );
          case 1:
            return const Icon(
              Icons.sentiment_dissatisfied,
              color: Colors.redAccent,
            );
          case 2:
            return const Icon(
              Icons.sentiment_neutral,
              color: Colors.amber,
            );
          case 3:
            return const Icon(
              Icons.sentiment_satisfied,
              color: Colors.lightGreen,
            );
          case 4:
            return const Icon(
              Icons.sentiment_very_satisfied,
              color: Colors.green,
            );
          default:
            return Container();
        }
      },
      onRatingUpdate: (rating) {
        setState(() {
          _rating[index] = rating;
          print(_rating[index]);
        });
      },
      updateOnDrag: true,
    );
  }
}
