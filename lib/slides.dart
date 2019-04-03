import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' show parse;
import 'package:flutter/material.dart';
import 'cuts.dart';

class Slides extends StatefulWidget {
	var url;
	var s;

	Slides(this.url, this.s);

	createState() => _SlidesState();
}

class _SlidesState extends State<Slides> {
	var _load;

	initState() {
		super.initState();

		_load = http.read(widget.url).then((doc) => compute(_fetch, [doc, widget.s]));
	}

	_text(s) => s.h != null
		? Column(children: [Text(s.h, style: tS.copyWith(fontSize: 24.0)), pad(Text(s.t), .0, 16.0)])
		: Text(s.t);

	_slide(s, i) => Material(
		borderRadius: BorderRadius.circular(16.0),
		elevation: 7,
		child: padAll(s.hasData ? _text(s.data[i]) : Center(child: CircularProgressIndicator()), 24.0),
	);

	_page(s, i) => Column(children: [padAll(_slide(s, i), 16.0), Spacer()]);

	build(ct) => FutureBuilder(future: _load, builder: (ctx, s) => PageView.builder(itemBuilder: (ictx, i) => _page(s, i)));
}

_fetch(w) {
	var els = parse(w[0]).querySelector('#mw-content-text .mw-parser-output').children;

	it() sync* {
		for (var el in els ?? []) {
			var ln = el.localName;
			if (el.querySelector('> style') == null && (ln == 'p' || ln.startsWith('h')))
				yield* ln == 'p' ? el.text.replaceAll(RegExp(r'\[\d+\]'), '').split(RegExp(r'\.(?=\s[A-Z])|\.$|\.\s+$')).map((s) => s.trim()).where((s) => !s.isEmpty) : [_S(el.text)];
		}
	}

	var r = [];
	var i = 0;
	var s = _S('Who are they?');
	for (var p in it()) {
		if (p is String) {
			s.t += '$p. ';
			if (++i >= w[1]) {
				r.add(s);

				s = _S(); i = 0;
			}
		} else {
			if (!s.t.isEmpty) r.add(s);
			s = p; i = 0;
		}
	}

	return r;
}

class _S {
	var h;
	var t;

	_S([this.h, this.t = '']);
}
