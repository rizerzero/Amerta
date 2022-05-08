part of 'people_detail_sliver_appbar.dart';

class _ImageFlexibleAppBar extends StatelessWidget {
  const _ImageFlexibleAppBar({
    Key? key,
    required this.peopleId,
    this.imagePath,
  }) : super(key: key);

  final String peopleId;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: peopleId,
      child: Center(
        child: DecoratedBox(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                blurRadius: 2.0,
                color: black.withOpacity(.5),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.file(
              File(imagePath ?? ''),
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, trace) => Image.asset(
                kLogo,
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
