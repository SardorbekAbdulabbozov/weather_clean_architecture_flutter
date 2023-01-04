import 'package:flutter/material.dart';

class WeatherPageAppBar extends StatelessWidget with PreferredSizeWidget {
  const WeatherPageAppBar({Key? key, required this.onSearchFieldChanged})
      : super(key: key);
  final void Function(String) onSearchFieldChanged;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF352F64),
      elevation: 0,
      centerTitle: false,
      iconTheme: IconThemeData(color: const Color(0xFFEBEBF5).withOpacity(0.6)),
      title: const Text(
        'Weather',
        style: TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 28,
          letterSpacing: 0.36,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(52),
        child: Container(
          margin: const EdgeInsets.all(16).copyWith(
            top: 16,
            bottom: 0,
          ),
          height: 36,
          child: Center(
            child: Material(
              color: Colors.transparent,
              shadowColor: Colors.black45,
              borderRadius: BorderRadius.circular(10),
              elevation: 1,
              child: TextField(
                cursorColor: const Color(0xFFEBEBF5).withOpacity(0.6),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  letterSpacing: -0.41,
                  fontWeight: FontWeight.w400,
                ),
                onChanged: onSearchFieldChanged,
                decoration: InputDecoration(
                  filled: true,
                  hintText: 'Search for a city',
                  hintStyle: TextStyle(
                    color: const Color(0xFFEBEBF5).withOpacity(0.6),
                    fontSize: 17,
                    letterSpacing: -0.41,
                    fontWeight: FontWeight.w400,
                  ),
                  prefixIcon: Icon(Icons.search,
                      color: const Color(0xFFEBEBF5).withOpacity(0.6)),
                  contentPadding:
                      const EdgeInsets.only(bottom: 4, left: 16, right: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusColor: Colors.transparent,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(100);
}
