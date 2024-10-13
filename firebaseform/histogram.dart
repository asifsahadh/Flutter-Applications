import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AgeHistogram extends StatefulWidget {
  @override
  _AgeHistogramState createState() => _AgeHistogramState();
}

class _AgeHistogramState extends State<AgeHistogram> {
  List<charts.Series<AgeData, String>> _seriesBarData = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFromFirestore();
  }

  void _fetchDataFromFirestore() async {
    List<int> ageList = [];

    // Fetch Student Data from Firebase Firestore
    await FirebaseFirestore.instance.collection('form').get().then((querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        String ageString = doc['Age'];  // Fetch the age as a string
        int? Age = int.tryParse(ageString);  // Convert the string to an integer safely

        if (Age != null) {
          ageList.add(Age);  // Add to age list if the conversion is successful
        }
      });

      _createAgeHistogram(ageList);
    });
  }

  void _createAgeHistogram(List<int> ageList) {
    // Create age range bins
    Map<String, int> ageBins = {
      '10-15' : 0,
      '16-20' : 0,
      '21-25' : 0,
      '26-30' : 0,
    };

    // Sort ages into the appropriate bin
    for (var Age in ageList) {
      if (Age >= 10 && Age <= 15) {
        ageBins['10-15'] = ageBins['10-15']! + 1;
      } else if (Age >= 16 && Age <= 20) {
        ageBins['16-20'] = ageBins['16-20']! + 1;
      } else if (Age >= 21 && Age <= 25) {
        ageBins['21-25'] = ageBins['21-25']! + 1;
      } else if (Age >= 26 && Age <= 30) {
        ageBins['26-30'] = ageBins['26-30']! + 1;
      }
    }

    // Convert age bin data into a chart series
    List<AgeData> data = ageBins.entries
        .map((entry) => AgeData(entry.key, entry.value))
        .toList();

    setState(() {
      _seriesBarData = [
        charts.Series(
          domainFn: (AgeData ageData, _) => ageData.ageRange,
          measureFn: (AgeData ageData, _) => ageData.count,
          id: 'Age',
          data: data,
          fillColorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault
        )
      ];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Age Histogram", style: TextStyle(fontWeight: FontWeight.bold))),
      body: _seriesBarData.isEmpty
        ? Center(child: CircularProgressIndicator())
        : Padding(
        padding: const EdgeInsets.all(16.0),
        child: charts.BarChart(
          _seriesBarData,
          animate: true,
        ),
      )
    );
  }
}

class AgeData {
  final String ageRange;
  final int count;

  AgeData(this.ageRange, this.count);
}