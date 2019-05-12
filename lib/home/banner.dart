import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zfw/components/api/home.dart';
import 'package:zfw/home/blocs/homebanner_event.dart';
import 'package:zfw/home/homeSizeUtil.dart';
import 'blocs/bloc.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BannerPageState();
}

class BannerPageState extends State<HomeBanner> {
  HomePageSizeUtil get homeSize => new HomePageSizeUtil();
  final HomebannerBloc _bloc = new HomebannerBloc();

  @override
  void initState() {
    super.initState();
    _bloc.dispatch(HomebannerEvent.Load);
  }

  @override
  void dispose() {
    super.dispose();
    _bloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: homeSize.bannerHeight,
        child: BlocBuilder<HomebannerEvent, HomebannerState>(
          bloc: _bloc,
          builder: (context, state) {
            List<IndexBanner> data = state.data ?? [];
            return Swiper(
              itemBuilder: (context, index) {
                return Image.network(
                  data[index].Img,
                  fit: BoxFit.fill,
                );
              },
              itemCount: data.length,
              // pagination: new SwiperPagination(
              //     builder: DotSwiperPaginationBuilder(
              //   color: Colors.black54,
              //   activeColor: Colors.white,
              // )),
              // control: new SwiperControl(),
              scrollDirection: Axis.horizontal,
              autoplay: data.length > 1,
              loop: false,
              onTap: (index) => print('点击了第$index个'),
            );
          },
        ));
  }
}
