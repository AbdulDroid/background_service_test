import 'package:flutter/material.dart';
import '../../extensions/stringextensions.dart';
import '../../data/models/get_new_borns_response/newborn.dart';
import '../../extensions/datetimeextensions.dart';

class NewbornCard extends StatelessWidget {
  final NewBorn data;

  const NewbornCard({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 2.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
            side: const BorderSide(
                width: 1, color: Color.fromARGB(255, 207, 206, 206))),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 10.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.attributes!.name!.capitalize,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                    ),
                  ),
                  Text(
                    data.attributes!.gender!.capitalize,
                    style: const TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                    ),
                  ),
                ],
              ),
              Text(
                "DOB:${data.attributes!.gestation!.toFormattedDate}",
                style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
