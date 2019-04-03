import 'package:flutter/widgets.dart';
import 'pic.dart';

const tS = TextStyle(fontFamily: 'BalooChettan', height: 0.7);
v(a, s, [h = 1.0, b = .0, anim]) => Pic(a, Duration(seconds: s), h, b, anim);
p(c, {t, b, l, r}) => Positioned(top: t, bottom: b, left: l, right: r, child: c);
f(c, {t = .0, b = .0, l = .0, r = .0}) => p(c, t: t, b: b, l: l, r: r);
padAll(c, p) => pad(c, p, p, p, p);
pad(c, [l = .0, t = .0, r = .0, b = .0]) => Padding(padding: EdgeInsets.fromLTRB(l, t, r, b), child: c);
