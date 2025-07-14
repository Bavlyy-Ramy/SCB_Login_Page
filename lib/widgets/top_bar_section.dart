import 'package:flutter/material.dart';

class TopBarSection extends StatefulWidget {
  @override
  _TopBarSectionState createState() => _TopBarSectionState();
}

class _TopBarSectionState extends State<TopBarSection> with TickerProviderStateMixin {
  bool isArabic = true;
  late AnimationController _languageAnimationController;
  late Animation<double> _languageAnimation;

  @override
  void initState() {
    super.initState();
    _languageAnimationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _languageAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _languageAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _languageAnimationController.dispose();
    super.dispose();
  }

  void toggleLanguage() {
    setState(() {
      isArabic = !isArabic;
    });

    // Animation feedback
    _languageAnimationController.reset();
    _languageAnimationController.forward();

    // Language switching
    if (isArabic) {
      _setLocaleToArabic();
    } else {
      _setLocaleToEnglish();
    }
  }

  void _setLocaleToArabic() {
    // TODO: Implement Arabic localization
  }

  void _setLocaleToEnglish() {
    // TODO: Implement English localization
  }

  void openMenu() {
    // TODO: Implement menu action
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo with image
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/images/unnamed.webp',
                fit: BoxFit.contain,
              ),
            ),
          ),

          // Right controls
          Row(
            children: [
              // Language switch with animation
              GestureDetector(
                onTap: toggleLanguage,
                child: AnimatedBuilder(
                  animation: _languageAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: 1.0 + (_languageAnimation.value * 0.1),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            AnimatedSwitcher(
                              duration: Duration(milliseconds: 300),
                              child: Text(
                                isArabic ? 'العربية' : 'English',
                                key: ValueKey(isArabic),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              SizedBox(width: 15),

              // Menu button
              GestureDetector(
                onTap: openMenu,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20,
                        height: 2,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 2),
                      ),
                      Container(
                        width: 20,
                        height: 2,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 2),
                      ),
                      Container(
                        width: 20,
                        height: 2,
                        color: Colors.white,
                        margin: EdgeInsets.symmetric(vertical: 2),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
