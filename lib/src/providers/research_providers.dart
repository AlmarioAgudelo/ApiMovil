import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:maquetacion_proyecto/src/models/ResearchDetail.dart';
import '../models/research_model.dart';

class ResearchProvider extends ChangeNotifier {
  List<Research> _researches = [];
  bool _isLoading = false;

  List<Research> get researches => _researches;
  bool get isLoading => _isLoading;

  ResearchProvider() {
    getResearches();
  }

  Future<void> getResearches() async {
    _isLoading = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api-bird-field-logs.coderhub.run/api/external/research',
    );

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer a5962ab499689bb2fbd3a27f646062248cc5fecc3178435474e1ee44772efdbe',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('getResearches status: ${response.statusCode}');
      debugPrint('getResearches body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        List dataList = [];
        if (jsonData is Map && jsonData['data'] is List) {
          dataList = jsonData['data'];
        } else if (jsonData is List) {
          dataList = jsonData;
        } else if (jsonData is Map && jsonData['results'] is List) {
          dataList = jsonData['results'];
        }

          final images = [
            'https://as2.ftcdn.net/v2/jpg/03/05/06/07/1000_F_305060700_HValp62AU5V1ZTWb2kegfnefp7r5kgDs.jpg',
            'https://t4.ftcdn.net/jpg/03/26/85/39/240_F_326853980_bGasifo1BJnt1yNanZpqJCaHf4TSOKJp.jpg',
            'https://t3.ftcdn.net/jpg/02/13/91/28/240_F_213912880_xnktHsNMhemX8QWeqTBnzrAgG46roIpb.jpg'
          ];

          _researches = dataList.asMap().entries.map((entry) {
            try {
              Map<String, dynamic> json;
              if (entry.value is Map<String, dynamic>) {
                json = entry.value as Map<String, dynamic>;
              } else if (entry.value is Map) {
                json = Map<String, dynamic>.from(entry.value as Map);
              } else {
                json = <String, dynamic>{};
              }
              json['imageUrl'] = images[entry.key % images.length];
              return Research.fromJson(json);
            } catch (e) {
              debugPrint('Error parsing research item: $e');
              return Research.fromJson(<String, dynamic>{'imageUrl': images[0]});
            }
          }).toList();        debugPrint('getResearches: loaded ${_researches.length} researches');
        if (_researches.isNotEmpty) {
          debugPrint('first raw item: ${dataList.first}');
        }
      } else {
        _researches = [];
      }
    } catch (e, st) {
      debugPrint('getResearches error: $e\n$st');
      _researches = [];
    }

    _isLoading = false;
    notifyListeners();
  }

  ResearchDetail? _currentResearchDetail;
  bool _isLoadingDetail = false;

  ResearchDetail? get currentResearchDetail => _currentResearchDetail;
  bool get isLoadingDetail => _isLoadingDetail;

  Future<void> getResearchDetail(String uuid) async {
    _isLoadingDetail = true;
    notifyListeners();

    final url = Uri.parse(
      'https://api-bird-field-logs.coderhub.run/api/external/details/research/$uuid',
    );

    debugPrint('getResearchDetail: Fetching details for UUID: $uuid');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization':
              'Bearer a5962ab499689bb2fbd3a27f646062248cc5fecc3178435474e1ee44772efdbe',
          'Content-Type': 'application/json',
        },
      );

      debugPrint('getResearchDetail status: ${response.statusCode}');
      debugPrint('getResearchDetail body: ${response.body}');

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        
        if (jsonData is Map && jsonData['data'] != null) {
          _currentResearchDetail = ResearchDetail.fromJson(jsonData['data']);
          debugPrint('getResearchDetail: Loaded research with ${_currentResearchDetail?.samplePoints.length} sample points');
        } else {
          debugPrint('getResearchDetail: Invalid JSON structure - missing data field');
          _currentResearchDetail = null;
        }
      } else {
        debugPrint('getResearchDetail: Request failed with status ${response.statusCode}');
        _currentResearchDetail = null;
      }
    } catch (e, st) {
      debugPrint('getResearchDetail error: $e\n$st');
      _currentResearchDetail = null;
    }

    _isLoadingDetail = false;
    notifyListeners();
  }
}
