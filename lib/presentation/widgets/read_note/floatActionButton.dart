import 'package:flutter/material.dart';
import 'package:notes_app/presentation/routes/app_routes.dart';
import 'package:share/share.dart';

class FAB extends StatefulWidget {
  final String text;
  final int id;
  final Function deleteNote;
  const FAB(this.text, this.id, this.deleteNote);
  @override
  _FABState createState() => _FABState();
}

class _FABState extends State<FAB> with SingleTickerProviderStateMixin {
  bool isOpened = false;
  AnimationController _animationController;
  Animation<double> _animationIcon;
  Animation<double> _translateButton;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    )..addListener(() {
        setState(() {});
      });
    _animationIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Widget buttonEdit() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Navigator.pushReplacementNamed(context, AppRoutes.editNote,
              arguments: widget.id);
        },
        tooltip: "Edit",
        heroTag: "edit",
        child: Icon(
          Icons.edit,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget buttonDelete() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: widget.deleteNote,
        tooltip: "Delete",
        heroTag: "delete",
        child: Icon(
          Icons.delete,
          color: Theme.of(context).errorColor,
        ),
      ),
    );
  }

  Widget buttonShare() {
    return Container(
      child: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          Share.share(widget.text);
        },
        heroTag: "share",
        tooltip: "Share",
        child: Icon(
          Icons.share,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  Widget buttonToggle() {
    return Container(
      child: FloatingActionButton(
        heroTag: "toggle",
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () {
          animate();
        },
        tooltip: "toggle",
        child: AnimatedIcon(
          icon: AnimatedIcons.menu_close,
          progress: _animationIcon,
          color: Theme.of(context).accentColor,
        ),
      ),
    );
  }

  animate() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    setState(() {
      isOpened = !isOpened;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 3.0, 0.0),
            child: buttonEdit()),
        Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 2.0, 0.0),
            child: buttonShare()),
        Transform(
            transform: Matrix4.translationValues(
                0.0, _translateButton.value * 1.0, 0.0),
            child: buttonDelete()),
        buttonToggle(),
      ],
    );
  }
}
