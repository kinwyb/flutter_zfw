import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../components/api/home.dart';

class HomeBanner extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new BannerPageState();
}

class BannerPageState extends State<HomeBanner> {
  List<IndexBanner> banners = new List<IndexBanner>();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var data = await HomeAPI.banners();
    setState(() {
      this.banners = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: 200.0,
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: banners.length,
          // pagination: new SwiperPagination(
          //     builder: DotSwiperPaginationBuilder(
          //   color: Colors.black54,
          //   activeColor: Colors.white,
          // )),
          // control: new SwiperControl(),
          scrollDirection: Axis.horizontal,
          autoplay: banners.length > 1,
          loop: false,
          onTap: (index) => print('点击了第$index个'),
        ));
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      banners[index].Img,
      fit: BoxFit.fill,
    ));
  }
}
