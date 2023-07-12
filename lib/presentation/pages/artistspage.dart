// import 'package:dune/data_sources/search_results/models/artistpagedataclass.dart';
// import 'package:dune/data_sources/search_results/requests/search_results_service.dart';
// import 'package:dune/presentation/pages/common/tracks_list_view.dart';
// import 'package:dune/presentation/pages/search_result_widgets/albums_result_widget.dart';
// import 'package:dune/presentation/pages/search_result_widgets/artists_result_widget.dart';
// import 'package:dune/presentation/providers/controllers.dart';
// import 'package:fluent_ui/fluent_ui.dart';
// import 'package:flutter/material.dart' as mat;
// import 'package:dune/data_sources/search_results/models/albumsdataclass.dart'
//     as albumD;
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import 'package:dune/data_sources/search_results/models/artistsdataclass.dart'
//     as artistD;
//
// class ArtistsPage extends ConsumerStatefulWidget {
//   final String channelId;
//
//   const ArtistsPage({Key? key, required this.channelId}) : super(key: key);
//
//   @override
//   _ArtistsPageState createState() => _ArtistsPageState();
// }
//
// class _ArtistsPageState extends ConsumerState<ArtistsPage>
//     with
//         AutomaticKeepAliveClientMixin<ArtistsPage>,
//         SingleTickerProviderStateMixin {
//   late ArtistsPageData _artistsPage;
//
//   bool status = false;
//   bool fetched = false;
//   late mat.TabController _tabController;
//
//   final ScrollController _scrollController = ScrollController();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = mat.TabController(length: 5, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//     _tabController.dispose();
//     _scrollController.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     Typography typography = FluentTheme.of(context).typography;
//     const spacer = SizedBox(width: 10.0);
//     const biggerSpacer = SizedBox(width: 40.0);
//     Size size = MediaQuery.of(context).size;
//     var height = MediaQuery.of(context).size.height;
//
//     if (!status) {
//       status = true;
//       SearchMusic.getArtistPage(widget.channelId).then((value) => {
//             if (mounted)
//               {
//                 setState(() {
//                   _artistsPage = value;
//                   fetched = true;
//                 })
//               }
//           });
//     }
//     return Stack(
//       children: [
//         (!fetched)
//             ? const SizedBox()
//             : CustomScrollView(
//                 //scrollBehavior: const CupertinoScrollBehavior(),
//                 physics: const BouncingScrollPhysics(),
//                 controller: ScrollController(),
//                 slivers: [
//                   mat.SliverAppBar(
//                     //leadingWidth: 0,
//                     titleSpacing: 0,
//
//                     toolbarHeight: 10,
//                     collapsedHeight: 30,
//                     // titleSpacing: 5,
//                     pinned: true,
//                     elevation: 0,
//                     //snap: true,
//                     floating: true,
//                     actions: <Widget>[
//                       mat.IconButton(
//                         icon: const Icon(mat.Icons.more_horiz_rounded),
//                         tooltip: 'Comment Icon',
//                         onPressed: () {},
//                       ), //IconButton
//                     ],
//
//                     expandedHeight: height / 2,
//                     stretch: true,
//                     flexibleSpace: mat.FlexibleSpaceBar(
//                       titlePadding: const mat.EdgeInsets.only(
//                           left: 20, bottom: 60, right: 20),
//                       title: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.end,
//                         children: [
//                           Container(
//                             alignment: Alignment.bottomLeft,
//                             width: 200,
//                             child: Column(
//                                 crossAxisAlignment:
//                                     mat.CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     _artistsPage.name.toString(),
//                                     style: const mat.TextStyle(fontSize: 35),
//                                   ),
//                                   Row(
//                                     children: [
//                                       const mat.Icon(mat.Icons.subscriptions),
//                                       spacer,
//                                       Text(
//                                         _artistsPage.subscribers.toString(),
//                                         style: const mat.TextStyle(
//                                             fontSize: 10, letterSpacing: 0.2),
//                                         maxLines: 2,
//                                         softWrap: true,
//                                         overflow: TextOverflow.ellipsis,
//                                       ),
//                                     ],
//                                   )
//                                 ]),
//                           ),
//                           Container(
//                               margin: const EdgeInsets.only(right: 10),
//                               // width: 85,
//                               child: mat.ElevatedButton(
//                                 style: mat.ButtonStyle(
//                                     backgroundColor:
//                                         mat.MaterialStateProperty.all(ref
//                                             .watch(appThemeControllerProvider)
//                                             .primaryColor)),
//                                 onPressed: () {},
//                                 child: const Text('Play'),
//                               )),
//                         ],
//                       ),
//                       stretchModes: const [
//                         mat.StretchMode.zoomBackground,
//                         mat.StretchMode.blurBackground,
//                       ],
//                       background: ShaderMask(
//                         blendMode: BlendMode.luminosity,
//                         shaderCallback: (bounds) {
//                           return const LinearGradient(
//                                   begin: Alignment.topCenter,
//                                   end: Alignment.bottomCenter,
//                                   colors: [Colors.transparent, Colors.black])
//                               .createShader(bounds);
//                         },
//                         child: FadeInImage(
//                             placeholder: const AssetImage('assets/artist.jpg'),
//                             width: size.width,
//                             height: size.height,
//                             fit: BoxFit.cover,
//                             image: NetworkImage(
//                               _artistsPage.thumbnails!.last.url.toString(),
//                             )),
//                       ),
//                     ),
//
//                     bottom: mat.TabBar(
//                       indicatorWeight: 5,
//                       indicatorSize: mat.TabBarIndicatorSize.label,
//                       automaticIndicatorColorAdjustment: true,
//                       isScrollable: true,
//                       indicator: mat.UnderlineTabIndicator(
//                           borderSide: BorderSide(
//                               width: 4.0,
//                               color: ref
//                                   .watch(appThemeControllerProvider)
//                                   .primaryColor)),
//                       tabs: const [
//                         mat.Tab(text: 'Albums'),
//                         mat.Tab(text: 'Songs'),
//                         mat.Tab(text: 'Related'),
//                         mat.Tab(text: 'Singles'),
//                         mat.Tab(text: 'Videos'),
//                       ],
//                       controller: _tabController,
//                     ),
//                   ),
//                   SliverFillRemaining(
//                       child: mat.TabBarView(
//                           physics: const BouncingScrollPhysics(),
//                           controller: _tabController,
//                           children: [
//                         _artistsPage.albums?.results != null
//                             ? GridView.builder(
//                                 gridDelegate:
//                                     const SliverGridDelegateWithMaxCrossAxisExtent(
//                                   maxCrossAxisExtent: 200.0,
//                                   mainAxisSpacing: 20.0,
//                                   crossAxisSpacing: 10.0,
//                                   childAspectRatio: 1 / 1.3,
//                                 ),
//                                 itemCount: _artistsPage.albums?.results?.length,
//                                 // shrinkWrap: true,
//                                 physics: const BouncingScrollPhysics(),
//                                 itemBuilder: (context, index) {
//                                   return SizedBox();
//                                   // mat.Material(
//                                   // child:AlbumCard(
//                                   //     albums: albumD.Albums(
//                                   //         title: _artistsPage
//                                   //             .albums!.results![index].title
//                                   //             .toString(),
//                                   //         year: _artistsPage
//                                   //             .albums!.results![index].year
//                                   //             .toString(),
//                                   //         type: '',
//                                   //         isExplicit: false,
//                                   //         category: 'artist',
//                                   //         artists: List<albumD.Artist>.from(
//                                   //             [albumD.Artist(name: _artistsPage.name.toString(), id: 'lol')]),
//                                   //         duration: '',
//                                   //         browseId: _artistsPage.albums!
//                                   //             .results![index].browseId
//                                   //             .toString(),
//                                   //         thumbnails: _artistsPage.albums!
//                                   //             .results![index].thumbnails
//                                   //             ?.map(
//                                   //                 (e) => albumD.Thumbnail(width: e.width, height: e.height, url: e.url.toString()))
//                                   //             .toList())));
//                                 },
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 20, 10, 10),
//                               )
//                             : const Text('No result'),
//                         // TrackList(songQuery: _artistsPage.name.toString()),
//                         _artistsPage.related?.results != null
//                             ? GridView(
//                                 gridDelegate:
//                                     const SliverGridDelegateWithMaxCrossAxisExtent(
//                                   maxCrossAxisExtent: 200.0,
//                                   mainAxisSpacing: 10.0,
//                                   crossAxisSpacing: 10.0,
//                                   childAspectRatio: 1 / 1.5,
//                                 ),
//                                 padding:
//                                     const EdgeInsets.fromLTRB(10, 20, 10, 10),
//                                 children: List.generate(
//                                     _artistsPage.related!.results!.length,
//                                     (index) {
//                                   //List<artistD.Thumbnail> thumbs = []
//
//                                   return mat.Material(
//                                     child: ArtistCard(
//                                         artists: artistD.Artists(
//                                             subscribers: '',
//                                             artist: _artistsPage
//                                                 .related!.results![index].title,
//                                             browseId: _artistsPage.related!
//                                                 .results![index].browseId,
//                                             category: 'null',
//                                             radioId: 'null',
//                                             resultType: 'null',
//                                             shuffleId: 'null',
//                                             thumbnails: _artistsPage.related!
//                                                 .results![index].thumbnails
//                                                 ?.map((e) => artistD.Thumbnail(
//                                                     width: e.width,
//                                                     height: e.height,
//                                                     url: e.url.toString()))
//                                                 .toList())),
//                                   );
//                                 }))
//                             : const Text('No result'),
//                         const Text('lol'),
//                         mat.ElevatedButton(
//                           onPressed: () {
//                             // print(context.watch<PlayerNotifiers>().searchVal);
//                             print(_artistsPage
//                                 .related?.results?.first.thumbnails?.first.url);
//                           },
//                           child: const Text('lol2'),
//                         ),
//                       ]))
//                 ],
//               ),
//         // Positioned.fill(
//         //   top: 12,
//         //   left: 10,
//         //   child: Align(
//         //       alignment: Alignment.topLeft,
//         //       child: FloatingBackButton(
//         //         onPressed: () {
//         //           Navigator.of(context).pop();
//         //         },
//         //       )),
//         // ),
//       ],
//     );
//   }
//
//   @override
//   bool get wantKeepAlive => true;
// }
//
// // class MySliverAppBar extends SliverPersistentHeaderDelegate {
// //   final double expandedHeight;
// //
// //   MySliverAppBar({required this.expandedHeight});
// //
// //   @override
// //   Widget build(
// //       BuildContext context, double shrinkOffset, bool overlapsContent) {
// //     var size = MediaQuery.of(context).size;
// //
// //     return Stack(
// //       fit: StackFit.expand,
// //       overflow: Overflow.visible,
// //       children: [
// //         Opacity(
// //           opacity: 1- shrinkOffset / expandedHeight,
// //           child:  CachedNetworkImage(
// //
// //             fit: BoxFit.cover,
// //             errorWidget: (context, url, error) => const Image(
// //               fit: BoxFit.cover,
// //               image: AssetImage('assets/artist.jpg'),
// //             ),
// //             imageUrl: _,
// //             placeholder: (context, url) => const Image(
// //                 fit: BoxFit.fill,
// //                 image: AssetImage('assets/artist.jpg')),
// //           ),
// //         ),
// //
// //         Center(
// //           child: Opacity(
// //             opacity: shrinkOffset / expandedHeight,
// //             child: Text(
// //               "MySliverAppBar",
// //               style: TextStyle(
// //                 color: Colors.white,
// //                 fontWeight: FontWeight.w700,
// //                 fontSize: 23,
// //               ),
// //             ),
// //           ),
// //         ),
// //
// //       ],
// //     );
// //   }
// //
// //   @override
// //   double get maxExtent => expandedHeight;
// //
// //   @override
// //   double get minExtent => mat.kToolbarHeight;
// //
// //   @override
// //   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// // }
