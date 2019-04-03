import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';

class Pic extends StatefulWidget {
	var flr;
	var time;
	var anim;

	var b;
	var h;

	Pic(this.flr, this.time, this.h, this.b, this.anim);

	createState() => _PicState();
}

class _PicState extends State<Pic> with SingleTickerProviderStateMixin {
	var _ctrl;
	var _actor;

	initState() {
		super.initState();

		_ctrl = AnimationController(vsync: this, duration: widget.time);

		if (widget.anim == null)
			_ctrl..addStatusListener((status) {
						if (status == AnimationStatus.completed) _ctrl..reset()..forward();
					})
					..addListener(() => setState(() {}))
					..forward();
	}

	build(ctx) {
		var w = MediaQuery.of(ctx).size.width;

		if (_actor == null)
			_actor = SizedBox(width: w, height: w * widget.h, child: FlareActor('assets/${widget.flr}.flr', animation: widget.anim));

		return Positioned(
			bottom: widget.b,
			left: -_ctrl.value * w,
			child: Row(children: [_actor, _actor]),
		);
	}
}
