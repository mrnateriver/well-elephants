import 'dart:math' as m;

import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'slides.dart';
import 'cuts.dart';

main() => runApp(MaterialApp(title: 'Well, elephants', home: Builder(builder: body)));

const url = 'https://en.wikipedia.org/wiki/Elephant';

const z = Radius.zero;
const r = Radius.circular(24.0);

b(c, [l = true, o]) => Material(
	borderRadius: BorderRadius.horizontal(right: l ? r : z, left: l ? z : r),
	elevation: 7.0,
	clipBehavior: Clip.antiAlias,
	child: InkWell(
		child: pad(Center(child: c), l ? 40.0 : 24.0, 16.0, 24.0, 16.0),
		onTap: o,
	),
);

title(s) => SizedBox(height: s * 2 + 32, child: Row(
	crossAxisAlignment: CrossAxisAlignment.stretch,
	mainAxisAlignment: MainAxisAlignment.spaceBetween,
	children: [
		b(Text('Well,\nelephants', style: tS.copyWith(color: Color(0xFFEF6C00), fontSize: s))),
		b(SvgPicture.asset('assets/wiki_logo.svg', width: s * 1.5), false, () async => await canLaunch(url) && await launch(url)),
	],
));

Widget body(ictx) {
	var q = MediaQuery.of(ictx);
	var ey = m.max(q.padding.bottom, 10.0);
	var th = m.min(64.0, q.size.width * 0.105);

	var c = Column(
		children: [
			pad(title(th), .0, 16.0, .0, 16.0),
			Expanded(child: Slides(url, q.size.height ~/ 224)),
		],
	);

	return Stack(
		children: [
			f(Container(decoration: BoxDecoration(gradient: LinearGradient(end: Alignment.bottomCenter, colors: [Color(0xFFAAE6F5), Colors.white])))),
			v('mountains1', 260, 0.5, 50.0),
			v('mountains2', 260, 0.5, 30.0),
			v('grass1', 100, 0.25, 5.0),
			v('grass2', 80, 0.25, -10.0),
			v('tree', 60, 0.7178, ey),
			v('elephant', 0, 0.5, ey, 'walking'),
			f(Container(height: ey, color: Color(0xFFA1887F)), t: null),
			f(c, t: q.padding.top),
		],
	);
}
