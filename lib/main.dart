import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_drawer_challenge/uicolors.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Challenge(),
    );
  }
}

class Challenge extends StatelessWidget {
  const Challenge({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UiColors.catskillWhite,
      drawer: const AnimatedDrawer(),
      drawerEdgeDragWidth: MediaQuery.of(context).size.width,
      appBar: AppBar(
        backgroundColor: UiColors.catskillWhite,
        leading: Builder(builder: (context) {
          return IconButton(
            onPressed: Scaffold.of(context).openDrawer,
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
          );
        }),
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton(
              backgroundColor: UiColors.governorBay,
              mini: true,
              onPressed: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
          ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'ALL PRODUCTS',
              style: TextStyle(color: Colors.black, fontSize: 15),
            ),
            Icon(
              Icons.keyboard_arrow_down_sharp,
              color: Colors.black,
            )
          ],
        ),
      ),
      body: const GridProducts(),
    );
  }
}

class GridProducts extends StatelessWidget {
  const GridProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(15),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        childAspectRatio: 9 / 14,
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 30,
      ),
      itemBuilder: (_, int index) => TweenAnimationBuilder<double>(
          duration: Duration(milliseconds: 300 * (1 + index)),
          tween: Tween(begin: 0.0, end: 1.0),
          curve: Curves.bounceIn,
          child: const Product(),
          builder: (context, value, child) {
            return Opacity(
              opacity: value > 0.3 ? value : 0,
              child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.001)
                    ..rotateY(pi * (1 - value)),
                  child: child!),
            );
          }),
    );
  }
}

class Product extends StatelessWidget {
  const Product({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        Expanded(
          child: ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: FlutterLogo(
                style: FlutterLogoStyle.horizontal,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 6,
        ),
        Text('EU SPRAY DE TOILLETE'),
        SizedBox(
          height: 5,
        ),
        Text('SPRAY'),
        SizedBox(
          height: 10,
        ),
        Text('150USD'),
      ],
    );
  }
}

class AnimatedDrawer extends StatefulWidget {
  const AnimatedDrawer({Key? key}) : super(key: key);

  @override
  State<AnimatedDrawer> createState() => _AnimatedDrawerState();
}

class _AnimatedDrawerState extends State<AnimatedDrawer>
    with SingleTickerProviderStateMixin {
  late AnimationController controller = AnimationController(
      vsync: this, duration: const Duration(milliseconds: 1000))
    ..addListener(() {
      setState(() {});
    });

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const curve = Curves.easeInOut;
    final tween = Tween(begin: 0.0, end: 1.0);
    final anim1 = tween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0, 0.6, curve: curve),
    ));
    final anim2 = tween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.1, 0.7, curve: curve),
    ));
    final anim3 = tween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.2, 0.8, curve: curve),
    ));
    final anim4 = tween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.3, 0.9, curve: curve),
    ));
    final anim5 = tween.animate(CurvedAnimation(
      parent: controller,
      curve: const Interval(0.4, 1, curve: curve),
    ));
    return ColoredBox(
      color: UiColors.governorBay,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Spacer(),
              // Slider(
              //     max: 1,
              //     min: 0,
              //     divisions: 100,
              //     value: controller.value,
              //     onChanged: (_value) {
              //       setState(() {
              //         controller.value = _value;
              //       });
              //     }),
              CascadeText(
                text: 'WRIST WATCH',
                value: anim1.value,
              ),
              const SizedBox(height: 40),
              CascadeText(
                text: 'LEATHER GOODS',
                value: anim2.value,
              ),
              const SizedBox(height: 40),
              CascadeText(
                text: 'PERFUME',
                value: anim3.value,
              ),
              const SizedBox(height: 40),
              CascadeText(
                text: 'JEWELLERY',
                value: anim4.value,
              ),
              const SizedBox(height: 40),
              CascadeText(
                text: 'SKINCARE',
                value: anim5.value,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class CascadeText extends StatefulWidget {
  const CascadeText({
    required this.text,
    Key? key,
    required this.value,
  }) : super(key: key);
  final String text;
  final double value;

  @override
  State<CascadeText> createState() => _CascadeTextState();
}

class _CascadeTextState extends State<CascadeText>
    with SingleTickerProviderStateMixin {
  List<String> get letters => widget.text.split('');

  late AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(
      milliseconds: 1500,
    ),
  )
    ..addListener(() {
      setState(() {});
    })
    ..addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => const Challenge(),
            ));
      }
    });

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const fontSize = 30.0;
    final tween = Tween(begin: 0.0, end: 1.0);
    return GestureDetector(
      onTap: () {
        if (controller.status == AnimationStatus.completed) {
          controller.reverse();
        } else {
          controller.forward();
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            top: 15,
            left: -30 *
                tween
                    .animate(
                      CurvedAnimation(
                        parent: controller,
                        curve: const Interval(0.1, 0.3),
                      ),
                    )
                    .value,
            child: Transform.scale(
              scale: 1 +
                  10000 *
                      tween
                          .animate(
                            CurvedAnimation(
                              parent: controller,
                              curve: const Interval(0.3, 1.0),
                            ),
                          )
                          .value,
              child: Opacity(
                opacity: widget.value,
                child: Transform.translate(
                  offset: Offset(widget.value * 10, 0),
                  child: Transform.scale(
                    scale: 1,
                    alignment: Alignment.center,
                    child: Container(
                      width: 10 + 1000 * controller.value,
                      height: 1,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ),
          ClipRRect(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(
                  width: 40,
                ),
                for (var i = 1; i <= letters.length; i++)
                  Transform.translate(
                    offset: Offset(0, fontSize * i * (1 - widget.value)),
                    child: Text(
                      letters[i - 1],
                      style: const TextStyle(
                          color: Colors.white, fontSize: fontSize),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
