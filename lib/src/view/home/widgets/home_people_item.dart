part of 'home_header_content.dart';

class _HomePeopleItem extends StatelessWidget {
  const _HomePeopleItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  final PeopleTopTenModel item;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fn.vw(context) / 3.5,
      child: Card(
        margin: const EdgeInsets.only(right: 16.0),
        child: InkWell(
          onTap: () {
            context.pushNamed(
              peopleDetailRouteNamed,
              params: {"peopleId": item.id},
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: Hero(
                    tag: item.id,
                    child: ClipOval(
                      child: Builder(builder: (context) {
                        final imageDefault = Image.asset(
                          kLogo,
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                        );
                        if (item.imagePath == null) {
                          return imageDefault;
                        }

                        return Image.file(
                          File(item.imagePath!),
                          fit: BoxFit.cover,
                          width: 50,
                          height: 50,
                          errorBuilder: (context, error, trace) => imageDefault,
                        );
                      }),
                    ),
                  ),
                ),
                Expanded(
                  child: Align(
                    child: Text(
                      item.name,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: bodyFont.copyWith(
                        fontSize: 10.0,
                        color: grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
