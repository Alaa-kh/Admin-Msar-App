// import 'package:flutter/material.dart';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:photo_view/photo_view.dart';

// class AppSwipeImagePreview extends StatefulWidget {
//   final List<String> images;
//   final int initialIndex;

//   const AppSwipeImagePreview({
//     super.key,
//     required this.images,
//     required this.initialIndex,
//   });

//   @override
//   State<AppSwipeImagePreview> createState() => _AppSwipeImagePreviewState();
// }

// class _AppSwipeImagePreviewState extends State<AppSwipeImagePreview> {
//   late final PageController _controller;
//   int _current = 0;

//   @override
//   void initState() {
//     super.initState();
//     _current = widget.initialIndex;
//     _controller = PageController(initialPage: widget.initialIndex);
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _controller,
//             itemCount: widget.images.length,
//             onPageChanged: (i) => setState(() => _current = i),
//             itemBuilder: (context, index) {
//               final url = widget.images[index];

//               return Hero(
//                 tag: 'hero_${url.hashCode}',
//                 child: PhotoView(
//                   imageProvider: CachedNetworkImageProvider(url),
//                   backgroundDecoration: const BoxDecoration(
//                     color: Colors.black,
//                   ),
//                   minScale: PhotoViewComputedScale.contained,
//                   enableRotation: false,
//                   maxScale: PhotoViewComputedScale.covered * 3,
//                   loadingBuilder: (context, event) =>
//                       const Center(child: CircularProgressIndicator()),
//                   errorBuilder: (context, error, stackTrace) => const Center(
//                     child: Icon(Icons.error, color: Colors.white, size: 40),
//                   ),
//                 ),
//               );
//             },
//           ),

//           SafeArea(
//             child: Align(
//               alignment: Alignment.topLeft,
//               child: Padding(
//                 padding: const EdgeInsets.only(left: 8, top: 8),
//                 child: GestureDetector(
//                   onTap: () => Navigator.pop(context),
//                   child: Container(
//                     padding: const EdgeInsets.all(8),
//                     decoration: const BoxDecoration(
//                       color: Colors.black54,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_forward,
//                       color: Colors.white,
//                       size: 28,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           /// 🔢 مؤشر رقم الصورة
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Text(
//                 '${_current + 1} / ${widget.images.length}',
//                 style: const TextStyle(
//                   color: Colors.white70,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
