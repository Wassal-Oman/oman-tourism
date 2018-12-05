// import needed libtraries
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// include widget class
class TourismMap extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _TourismMapState();
}

// state widget
class _TourismMapState extends State<TourismMap> {

  // google map controller
  GoogleMapController mapController;

  // map size
  double width = 0.0;
  double height = 0.0;

  // method to create google map
  void _onMapCreated(GoogleMapController controller) {
    setState(() { mapController = controller; });
  }

  @override
  Widget build(BuildContext context) {

    // set map size
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height * 0.50;

    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
            child: SizedBox(
              width: this.width,
              height: this.height,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
              ),
            ),
          ),
          RaisedButton(
            child: const Text('Go to London'),
            onPressed: mapController == null ? null : () {
              mapController.animateCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                  bearing: 270.0,
                  target: LatLng(23.311744, 58.784676),
                  tilt: 0.0,
                  zoom: 10.0,
                ),
              ));
            },
          ),
        ],
      ),
    );
  }
}
