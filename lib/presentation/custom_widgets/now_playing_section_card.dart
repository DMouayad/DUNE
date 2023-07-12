// import 'package:dune/presentation/pages/common/tracks_list_view.dart';
// import 'package:dune/presentation/providers/controllers.dart';
// import 'package:dune/presentation/providers/shared_providers.dart';
// import 'package:dune/support/extensions/context_extensions.dart';
// import 'package:dune/support/enums/now_playing_section_display_mode.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// class NowPlayingCard extends ConsumerWidget {
//   const NowPlayingCard({this.backgroundColor = Colors.transparent, super.key});
//   final Color backgroundColor;
//
//   @override
//   Widget build(BuildContext context, ref) {
//     final currentTrack = ref.watch(playbackControllerProvider).currentTrack;
//     final displayMode = ref.watch(nowPlayingSectionDisplayModeProvider);
//
//     return Container(
//       decoration: BoxDecoration(
//         color: backgroundColor,
//         borderRadius: const BorderRadius.horizontal(left: Radius.circular(8)),
//       ),
//       child: Stack(
//         children: [
//           if (currentTrack == null)
//             const _NonPlayingPlaceHolder()
//           else
//             Padding(
//               padding: const EdgeInsets.symmetric(
//                 vertical: 12,
//                 horizontal: 4,
//               ),
//               child: Column(
//                 children: [
//                   if (displayMode != NowPlayingSectionDisplayMode.pinned) ...[
//                     ListTile(
//                       title: Text(
//                         "NOW PLAYING",
//                         textAlign: TextAlign.center,
//                         style: context.textTheme.titleMedium?.copyWith(
//                           color: context.colorScheme.primary,
//                           fontWeight: FontWeight.w500,
//                           // fontStyle: FontStyle.italic,
//                         ),
//                       ),
//                     ),
//                     const Divider(),
//                   ],
//                   Expanded(
//                     child: TracksListView(
//                       AsyncValue.data(ref.watch(playbackControllerProvider).tracks),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           Positioned(
//             top: 7,
//             right: 6,
//             child: IconButton(
//               tooltip: displayMode.isPinned ? "Unpin" : "Pin",
//               icon: Icon(
//                 displayMode.isPinned
//                     ? CupertinoIcons.pin_slash
//                     : CupertinoIcons.pin,
//                 size: 14,
//                 color: context.colorScheme.onPrimaryContainer.withOpacity(.63),
//               ),
//               onPressed: () {
//                 ref.read(nowPlayingSectionDisplayModeProvider.notifier).state =
//                     displayMode.isPinned
//                         ? NowPlayingSectionDisplayMode.hidden
//                         : NowPlayingSectionDisplayMode.pinned;
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// //
// // class NowPlayingTrackCard extends StatelessWidget {
// //   const NowPlayingTrackCard(this.track, {super.key});
// //   final BaseTrack track;
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return LayoutBuilder(
// //       builder: (BuildContext context, BoxConstraints constraints) {
// //         return Column(
// //           children: [
// //             Expanded(
// //               flex: 2,
// //               child: Card(
// //                 clipBehavior: Clip.antiAlias,
// //                 shape: RoundedRectangleBorder(
// //                   borderRadius: BorderRadius.circular(8.0),
// //                 ),
// //                 child: ShaderMask(
// //                   blendMode: BlendMode.luminosity,
// //                   shaderCallback: (bounds) {
// //                     return const LinearGradient(
// //                             begin: Alignment.topCenter,
// //                             end: Alignment.bottomCenter,
// //                             colors: [Colors.transparent, Colors.black])
// //                         .createShader(bounds);
// //                   },
// //                   child: ExtendedImage.network(
// //                     track.thumbnails.byOrder(ref.wa),
// //                     fit: BoxFit.contain,
// //                     cache: false,
// //                     shape: BoxShape.rectangle,
// //                     borderRadius: BorderRadius.circular(8),
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             Expanded(
// //               flex: 0,
// //               child: Text(
// //                 track.title,
// //                 style: context.textTheme.titleMedium?.copyWith(
// //                   color: context.colorScheme.surfaceTint.withOpacity(.8),
// //                   fontWeight: FontWeight.w500,
// //                 ),
// //                 textAlign: TextAlign.center,
// //               ),
// //             ),
// //             if (track.artistsNames.isNotEmpty)
// //               Text(
// //                 track.artistsNames,
// //                 textAlign: TextAlign.center,
// //                 style: context.textTheme.titleMedium?.copyWith(),
// //               ),
// //           ],
// //         );
// //       },
// //     );
// //   }
// // }
//
// class _NonPlayingPlaceHolder extends StatelessWidget {
//   const _NonPlayingPlaceHolder({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.queue_music,
//             color: context.colorScheme.surfaceTint.withOpacity(.6),
//             size: 40,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               "Currently playing track/playlist\n will show up here",
//               style: context.textTheme.bodyMedium?.copyWith(
//                 color: context.colorScheme.primary.withOpacity(.6),
//                 fontWeight: FontWeight.w500,
//               ),
//               textAlign: TextAlign.center,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
