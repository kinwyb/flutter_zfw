import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:zfw/components/adapt.dart';
import '../components/api/beans/common.dart';
import 'activitySizeUtil.dart';

// 活动详情轮播图片
class ActivityImages extends StatelessWidget {
  final List<ImgInfo> imgs;
  ActivitySizeUtil get _size => getActivitySizeUtil();

  ActivityImages({Key key, this.imgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: _size.imgContainerHeight,
        child: Swiper(
          itemBuilder: _swiperBuilder,
          itemCount: this.imgs.length,
          pagination: new SwiperPagination(
              builder: DotSwiperPaginationBuilder(
            color: Colors.black54,
            activeColor: Colors.white,
            space: 3.2,
          )),
          // control: new SwiperControl(),
          scrollDirection: Axis.horizontal,
          autoplay: this.imgs.length > 1,
          loop: true,
          onTap: (index) => print('点击了第$index个'),
        ));
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      this.imgs[index].src,
      fit: BoxFit.fill,
    ));
  }
}

// 商品图片
class ActivityDescImages extends StatelessWidget {
  final List<ImgInfo> imgs;

  ActivityDescImages({Key key, this.imgs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Widget> wgs = List<Widget>();
    for (var i in imgs) {
      var wg = Image.network(i.src);
      wgs.add(wg);
    }
    return Column(
      children: wgs,
    );
  }
}
