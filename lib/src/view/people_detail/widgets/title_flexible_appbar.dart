part of 'people_detail_sliver_appbar.dart';

class _TitleFlexibleSpaceBar extends StatelessWidget {
  const _TitleFlexibleSpaceBar({
    Key? key,
    required this.isCollapse,
    required this.iconBackButton,
    required this.iconMoreButton,
    required this.peopleName,
  }) : super(key: key);

  final bool isCollapse;
  final IconButton iconBackButton;
  final IconButton iconMoreButton;

  final String peopleName;

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        if (!isCollapse) return const SizedBox();
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            iconBackButton,
            Expanded(
              child: Text(
                peopleName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: bodyFontWhite.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            iconMoreButton,
          ],
        );
      },
    );
  }
}
