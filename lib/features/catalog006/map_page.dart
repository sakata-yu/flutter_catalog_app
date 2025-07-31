import 'dart:async';

import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

import 'view_model/map_view_model.dart';

@RoutePage()
class MapPage extends HookConsumerWidget {
  const MapPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(mapViewModelProvider);
    final viewModel = ref.read(mapViewModelProvider.notifier);
    final mapController = MapController();
    bool isInitialized = false;

    /// 概要: 位置情報権限を取得し、現在位置を継続して取得する関数
    ///
    /// Returns:
    /// - 説明: 現在情報を継続して取得するStreamSubscription
    ///
    Future<StreamSubscription<Position>?> getCurrentLocationStream() async {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('位置情報サービスが無効です')),
        );
        return null;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('位置情報へのアクセスを許可してください')),
          );
        }
        return null;
      }

      return Geolocator.getPositionStream(
        locationSettings: LocationSettings(
          accuracy: LocationAccuracy.best,
          distanceFilter: 5,
        ),
      ).listen((position) {
        final latLng = LatLng(position.latitude, position.longitude);
        viewModel.setCurrentPosition(latLng);
        if (isInitialized) {
          mapController.move(latLng, mapController.camera.zoom);
        }
      });
    }

    useEffect(() {
      StreamSubscription<Position>? subscription;
      () async {
        subscription = await getCurrentLocationStream();
      }();

      return subscription?.cancel;
    }, []);

    final currentPosition = state.currentPosition;

    return Scaffold(
      appBar: AppBar(title: const Text('FlutterMap')),
      body: currentPosition == null
          ? const Center(child: CircularProgressIndicator())
          : FlutterMap(
              mapController: mapController,
              options: MapOptions(
                initialCenter: currentPosition,
                onMapReady: () async {
                  isInitialized = true;
                  final position = await Geolocator.getCurrentPosition();
                  final latLng = LatLng(position.latitude, position.longitude);
                  mapController.move(latLng, mapController.camera.zoom);
                },
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.your_app',
                ),
                MarkerLayer(
                  markers: [
                    Marker(
                      point: currentPosition,
                      width: 50,
                      height: 50,
                      child: const Icon(
                        Icons.my_location,
                        color: Colors.blue,
                        size: 40,
                      ),
                    )
                  ],
                ),
              ],
            ),
    );
  }
}
