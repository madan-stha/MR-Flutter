import 'package:flutter/material.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:smc_flutter/src/src.dart';

class MapsList extends StatefulWidget {
  final Coords location;
  final String title;
  final Coords currentLocation;
  final String destinationTitle;
  final Function onMapSelected;
  final String type;

  const MapsList(
      {super.key,
      required this.location,
      required this.title,
      required this.currentLocation,
      required this.destinationTitle,
      required this.onMapSelected,
      required this.type});

  @override
  State<MapsList> createState() => _MapsListState();
}

class _MapsListState extends State<MapsList> {
  List<AvailableMap> availableMaps = [];
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  @override
  void initState() {
    installedMaps();
    super.initState();
  }

  installedMaps() async {
    availableMaps = await MapLauncher.installedMaps;
    setState(() {});
  }

  Future<void> _navigateToMap(AvailableMap map) async {
    setState(() {
      _isLoading = true;
    });

    try {
      print('called--${widget.type}--');
      await widget.onMapSelected(map);
      print('called--${widget.type}--');
      setState(() {
        _isLoading = false;
      });
      await map.showDirections(
        destination: widget.location,
        origin: widget.currentLocation,
        originTitle: widget.title,
        destinationTitle: widget.destinationTitle,
        directionsMode: DirectionsMode.driving,
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });

      CustomToast.show(
        'Failed to open map',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: availableMaps.length,
        itemBuilder: (context, index) {
          return ButtonsBouncingEffect(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(
                  16,
                ),
              ),
              child: ListTile(
                onTap: () => _navigateToMap(availableMaps[index]),
                title: Text(
                  availableMaps[index].mapName,
                  style: AppStyles.text16PxMedium,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SvgHelper.fromSource(
                    path: availableMaps[index].icon,
                    height: 30.0,
                    width: 30.0,
                  ),
                ),
              ),
            ),
          );
        });
  }
}
