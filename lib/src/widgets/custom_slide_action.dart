import 'package:flutter/material.dart';

import '../src.dart';

/// A custom slide action button widget.
class CustomSlideActionButton extends StatefulWidget {
  final String title;
  const CustomSlideActionButton({
    super.key,
    this.title = 'Slide to Action',
  });

  @override
  State<CustomSlideActionButton> createState() =>
      _CustomSlideActionButtonState();
}

/// The state class for the [CustomSlideActionButton].
class _CustomSlideActionButtonState extends State<CustomSlideActionButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  double _slidePosition = 0.0;
  bool _showPleaseWait = false;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller for slide animation.
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    // Dispose the animation controller to free resources.
    _animationController.dispose();
    super.dispose();
  }

  /// Called when a horizontal drag update is detected.
  /// Updates the slide position based on the drag delta.
  void _handleHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      _slidePosition += details.delta.dx;
    });
  }

  /// Called when a horizontal drag ends.
  /// If the button is fully slid to the end (position >= 100),
  /// it triggers the animation to slide back and navigate to a new screen.
  /// Otherwise, it animates back to the original position.
  void _handleHorizontalDragEnd(DragEndDetails details) {
    if (_slidePosition.abs() >= 100) {
      _animationController.forward().whenComplete(() {
        setState(() {
          _slidePosition = 0.0;
          _showPleaseWait = true;
        });

        // Navigate to the new screen here after a 1-second delay.
        Future.delayed(const Duration(seconds: 1), () {
          Utility.navigateMaterialRoute(
            context,
            const DashboardScreen(),
          ).then((_) {
            setState(() {
              _showPleaseWait = false;
            });
          });
        });
      });
    } else {
      _animationController.reverse().whenComplete(() {
        setState(() {
          _slidePosition = 0.0;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: GestureDetector(
            onHorizontalDragUpdate: _handleHorizontalDragUpdate,
            onHorizontalDragEnd: _handleHorizontalDragEnd,
            child: Container(
              height: 60,
              margin: const EdgeInsets.symmetric(
                horizontal: Dimensions.paddingSizeLarge,
                vertical: Dimensions.paddingSizeLarge,
              ),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
                gradient: LinearGradient(
                  colors: [
                    AppColors.kPrimaryColor,
                    AppColors.kPrimaryColor.withOpacity(
                      0.6,
                    ),
                  ],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(30.0),
              ),
              child: Row(
                mainAxisAlignment: _showPleaseWait
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6.0,
                      vertical: 6.0,
                    ),
                    child: AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(_slidePosition, 0.0),
                          child: _showPleaseWait
                              ? Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  child: const CircularProgressIndicator
                                      .adaptive(),
                                )
                              : Container(
                                  height: 50.0,
                                  width: 50.0,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).canvasColor,
                                    borderRadius: BorderRadius.circular(60.0),
                                  ),
                                  child: const Icon(
                                    Icons.delivery_dining_outlined,
                                  ),
                                ),
                        );
                      },
                    ),
                  ),
                  Gaps.horizontalGapOf(10.0),
                  AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_slidePosition, 0.0),
                        child: Text(
                          _showPleaseWait ? 'Please wait...' : widget.title,
                          style: AppStyles.text16PxRegular.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
