import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({Key? key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  LatLng? _selectedLocation; // Store the selected location

  void _openMap() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return GestureDetector(
          onTap: () {},
          child: Column(
            children: <Widget>[
              Container(
                height: 400,
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: _selectedLocation ?? LatLng(37.7749, -122.4194), // Initial location (San Francisco)
                    zoom: 15.0,
                  ),
                  markers: {
                    if (_selectedLocation != null)
                      Marker(
                        markerId: const MarkerId('user_location'),
                        position: _selectedLocation!,
                        infoWindow: const InfoWindow(
                          title: 'User Location',
                          snippet: 'This is the user\'s location.',
                        ),
                      ),
                  },
                  onTap: (LatLng location) {
                    setState(() {
                      _selectedLocation = location;
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('Close Map'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: UserProfileBody(
        openMap: _openMap,
        selectedLocation: _selectedLocation,
      ),
    );
  }
}

class UserProfileBody extends StatefulWidget {
  final Function openMap;
  final LatLng? selectedLocation;

  UserProfileBody({
    required this.openMap,
    required this.selectedLocation,
  });

  @override
  _UserProfileBodyState createState() => _UserProfileBodyState();
}

class _UserProfileBodyState extends State<UserProfileBody> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userIdController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.selectedLocation != null)
          Container(
            height: 200,
            child: GoogleMap(
              initialCameraPosition: CameraPosition(
                target: widget.selectedLocation!,
                zoom: 15.0,
              ),
              markers: {
                Marker(
                  markerId: const MarkerId('user_location'),
                  position: widget.selectedLocation!,
                  infoWindow: const InfoWindow(
                    title: 'User Location',
                    snippet: 'This is the user\'s location.',
                  ),
                ),
              },
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User Information",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.0),
              TextFormField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: "User Name"),
              ),
              TextFormField(
                controller: _userIdController,
                decoration: InputDecoration(labelText: "User ID"),
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(labelText: "Password"),
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(labelText: "Email"),
              ),
              TextFormField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: "Phone Number"),
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: "User Location",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.map),
                    onPressed: () {
                      // Open the map to select a location
                      widget.openMap();
                    },
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  // Handle button action here (e.g., update profile)
                },
                child: Text("Update Profile"),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
