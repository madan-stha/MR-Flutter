// import 'package:flutter/material.dart';
// import 'package:smc_flutter/src/src.dart';

// class ServerSelectionService extends StatefulWidget {
//   const ServerSelectionService({super.key});
//   @override
//   State<ServerSelectionService> createState() => _ServerSelectionServiceState();
// }

// class _ServerSelectionServiceState extends State<ServerSelectionService> {
//   String selectedKey = AppConstants.serverKeys[0];
//   final SharedPreferencesService _prefs = SharedPreferencesService();
//   String selectedValue = AppConstants.serverMap[AppConstants.serverKeys[0]]!;

//   void _saveServerPreference(String key, String value) async {
//     await _prefs.setStringPref('server_key', key);
//     await _prefs.setStringPref('server_value', value);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text('Select Server:'),
//         DropdownButtonFormField(
//           value: selectedKey,
//           items: AppConstants.serverKeys.map((String key) {
//             return DropdownMenuItem(
//               value: key,
//               child: Text(key),
//             );
//           }).toList(),
//           isDense: true,
//           onChanged: (String? key) {
//             if (key != null) {
//               setState(() {
//                 selectedKey = key;
//                 selectedValue = AppConstants.serverMap[key]!;
//               });
//               _saveServerPreference(key, selectedValue);
//               GlobalConfig.getBaseUrl();
//             }
//           },
//         ),
//         const SizedBox(height: 10),
//         Text('Selected Server URL: $selectedValue'),
//       ],
//     );
//   }
// }
