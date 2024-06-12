import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'index_bottom_navbar_provider.g.dart';

@riverpod
class IndexBottomNavbar extends _$IndexBottomNavbar {
  @override
  int build() => 0;

  void setIndexBottomNavbar(int indexBottomNavbar) {
    state = indexBottomNavbar;
  }
}
