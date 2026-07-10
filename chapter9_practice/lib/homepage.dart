import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final MapController _mapController = MapController();

  static const LatLng _klCenter = LatLng(3.153, 101.703);
  static const double _startZoom = 14;
  static const double _minZoom = 4;
  static const double _maxZoom = 19;

  static const LatLng _twinTowers = LatLng(3.1579, 101.7116);
  static const LatLng _klTower = LatLng(3.1528, 101.7039);
  static const LatLng _merdeka = LatLng(3.1487, 101.6935);

  void _recenterMap() {
    _mapController.move(_klCenter, _startZoom);
  }

  void _changeZoom(double amount) {
    final camera = _mapController.camera;
    final nextZoom = (camera.zoom + amount).clamp(_minZoom, _maxZoom);
    _mapController.move(camera.center, nextZoom);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
        title: const Text(
          'KL Landmark Explorer',
          style: TextStyle(fontSize: 20),
        ),
      ),
      body: Stack(
        children: [
          _buildMap(),
          _ZoomButtons(
            onZoomIn: () => _changeZoom(1),
            onZoomOut: () => _changeZoom(-1),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.indigo,
        onPressed: _recenterMap,
        tooltip: 'Recenter map',
        child: const Icon(Icons.my_location, color: Colors.white),
      ),
    );
  }

  Widget _buildMap() {
    return FlutterMap(
      mapController: _mapController,
      options: const MapOptions(
        initialCenter: _klCenter,
        initialZoom: _startZoom,
        minZoom: _minZoom,
        maxZoom: _maxZoom,
        interactionOptions: InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.doubleTapZoom,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.chapter9_practice',
        ),
        MarkerLayer(
          markers: [
            _landmarkMarker(
              _twinTowers,
              'Petronas Twin Towers (3.1579, 101.7116)',
              Colors.red,
            ),
            _landmarkMarker(
              _klTower,
              'KL Tower (Menara KL) (3.1528, 101.7039)',
              Colors.green,
            ),
            _landmarkMarker(
              _merdeka,
              'Merdeka Square (3.1487, 101.6935)',
              Colors.blue,
            ),
          ],
        ),
      ],
    );
  }

  Marker _landmarkMarker(LatLng point, String name, Color color) {
    return Marker(
      point: point,
      width: 60,
      height: 60,
      alignment: Alignment.topCenter,
      child: GestureDetector(
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(name), duration: const Duration(seconds: 2)),
          );
        },
        child: Icon(Icons.location_pin, size: 50, color: color),
      ),
    );
  }
}

class _ZoomButtons extends StatelessWidget {
  final VoidCallback onZoomIn;
  final VoidCallback onZoomOut;

  const _ZoomButtons({required this.onZoomIn, required this.onZoomOut});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ZoomButton(icon: Icons.add, tooltip: 'Zoom in', onPressed: onZoomIn),
          const SizedBox(height: 10),
          _ZoomButton(
            icon: Icons.remove,
            tooltip: 'Zoom out',
            onPressed: onZoomOut,
          ),
        ],
      ),
    );
  }
}

class _ZoomButton extends StatelessWidget {
  final IconData icon;
  final String tooltip;
  final VoidCallback onPressed;

  const _ZoomButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.small(
      heroTag: tooltip,
      backgroundColor: Colors.white,
      foregroundColor: Colors.indigo,
      tooltip: tooltip,
      onPressed: onPressed,
      child: Icon(icon),
    );
  }
}
