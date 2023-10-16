import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:test_tech_digital_paca/res/color.dart';
import 'package:test_tech_digital_paca/utils/utils.dart';
import 'package:test_tech_digital_paca/view_model/tv_show_view_model.dart';

class TVShowDetails extends StatelessWidget {
  TVShowDetails({super.key, required this.tvShow});

  final TVShowViewModel tvShow;

  final Utils utils = Utils();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkBlue,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                decoration: const BoxDecoration(),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 2,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                    ).createShader(
                        Rect.fromLTRB(0, 100, rect.width, rect.height));
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.network(
                    tvShow.bannerUrl.toString(),
                    fit: BoxFit.fitHeight,
                    errorBuilder: (context, error, stack) {
                      return const Icon(
                        Icons.error,
                        color: Colors.red,
                      );
                    },
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(tvShow.title,
                            style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 100,
                        child: Row(
                          children: [
                            Column(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(
                                  height: 60,
                                  width: 60,
                                  child: SfRadialGauge(axes: <RadialAxis>[
                                    RadialAxis(
                                        endAngle: -90,
                                        startAngle: -90,
                                        showTicks: false,
                                        showLabels: false,
                                        radiusFactor: 1,
                                        axisLineStyle: AxisLineStyle(
                                            thickness: 5,
                                            color:
                                                Colors.green.withOpacity(0.5)),
                                        pointers: <GaugePointer>[
                                          RangePointer(
                                            width: 5,
                                            value: tvShow.rate.toDouble(),
                                            color: Colors.green,
                                          )
                                        ],
                                        annotations: <GaugeAnnotation>[
                                          GaugeAnnotation(
                                              widget: Text('${tvShow.rate}%',
                                                  style: const TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.normal,
                                                      color: Colors.white)),
                                              angle: 90,
                                              positionFactor: 0.1)
                                        ])
                                  ]),
                                ),
                                const Text("Note du public",
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15.0),
                              child: VerticalDivider(
                                width: 22,
                                color: Colors.white,
                                thickness: 1,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(utils.durationToString(tvShow.duration),
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                                Text(tvShow.year,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                                Text(tvShow.type,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.normal)),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        alignment: Alignment.centerLeft,
                        child: const Text("Synopsis :",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text(tvShow.description,
                              style: const TextStyle(
                                  fontSize: 14,
                                  height: 1.3,
                                  color: Colors.white,
                                  fontWeight: FontWeight.normal)))
                    ],
                  ))
            ],
          ),
        ));
  }
}
