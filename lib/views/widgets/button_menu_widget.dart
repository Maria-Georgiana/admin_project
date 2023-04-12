// import 'package:flutter/material.dart';
//
// class ButtonMenuWidget extends StatelessWidget {
//   final IconData icon;
//   final Function()? onPressed;
//
//   const ButtonMenuWidget({Key? key, required this.icon, this.onPressed})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onPressed!(); // !-in cazul in care este null va trimite o eroare in consola
//       },
//       child: Container(
//         width: 50,
//         height: 50,
//         decoration: BoxDecoration(
//           color: Colors.transparent,
//           border: Border.all(width: 1, color: Colors.black87),
//           borderRadius: BorderRadius.circular(16),
//         ),
//         child: Icon(
//           icon,
//           color: Colors.black87,
//         ),
//       ),
//     );
//   }
// }
