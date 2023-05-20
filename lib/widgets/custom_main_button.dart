import 'package:amazone_clone/utils/utils.dart';
import 'package:flutter/material.dart';

class CustomMainButton extends StatefulWidget {
  final Widget child;
  final Color clolor;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButton({
    Key? key,
    required this.child,
    required this.clolor,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  State<CustomMainButton> createState() => _CustomMainButtonState();
}

class _CustomMainButtonState extends State<CustomMainButton> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
      onPressed: widget.onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: widget.clolor,
        fixedSize: Size(
          screenSize.width * 0.5,
          40,
        ),
      ),
      child: widget.isLoading
          ? const Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0),
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: CircularProgressIndicator(),
              ),
            )
          : widget.child,
    );
  }
}
