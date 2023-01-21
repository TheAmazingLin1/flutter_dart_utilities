/// Use this to access the utilities instead of creating your
/// own instance.
///
/// ```dart
/// $style.corners.lg;
/// ```
AppStyle get $style => AppStyle();

/// Style utilities to avoid littering the codebase with
/// magic numbers and to have some consistency in the design.
class AppStyle {
  /// Rounded edge corner radii
  late final corners = _Corners();

  /// Padding and margin values
  late final insets = _Insets(scale);

  // ignore: public_member_api_docs
  late final double scale = 1;

  /// Shared sizes
  late final sizes = _Sizes();
}

class _Corners {
  late final double full = 1000;
  late final double lg = 32;
  late final double md = 8;
  late final double sm = 4;
}

class _Sizes {
  double get maxContentWidth1 => 800;
  double get maxContentWidth2 => 600;
  double get maxContentWidth3 => 500;

  double get tabletXl => 1000;
  double get tabletLg => 800;
  double get tabletSm => 600;
  double get phoneLg => 400;
}

class _Insets {
  _Insets(this._scale);

  late final double offset = 80 * _scale;

  late final double xxl = 56 * _scale;
  late final double xl = 48 * _scale;
  late final double lg = 32 * _scale;
  late final double md = 24 * _scale;
  late final double sm = 16 * _scale;
  late final double xs = 8 * _scale;
  late final double xxs = 4 * _scale;

  final double _scale;
}
