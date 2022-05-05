part of '../peoples_summary_page.dart';

class _AppBar extends ConsumerStatefulWidget implements PreferredSizeWidget {
  const _AppBar({
    Key? key,
  }) : super(key: key);

  @override
  _AppBarState createState() => _AppBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _AppBarState extends ConsumerState<_AppBar> {
  bool showTextField = false;
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: primary,
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back),
      ),
      title: Builder(builder: (context) {
        if (!showTextField) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Daftar orang", style: bodyFont),
              Consumer(
                builder: (context, ref, child) {
                  final total = ref.watch(totalPeoplesSummary);
                  return Text(
                    "Total : $total Orang",
                    style: bodyFont.copyWith(color: Colors.white60, fontSize: 12.0),
                  );
                },
              ),
            ],
          );
        }

        return TextField(
          autofocus: true,
          style: bodyFontWhite,
          textInputAction: TextInputAction.search,
          decoration: fn.defaultInputDecoration.copyWith(
            hintStyle: bodyFontWhite.copyWith(color: Colors.white54),
            hintText: "Cari berdasarkan nama",
            suffixIcon: IconButton(
              onPressed: () {
                setState(() => showTextField = !showTextField);
                ref.watch(queryPeoplesSummary.notifier).update((state) => null);
              },
              icon: const Icon(Icons.close),
              color: Colors.white,
            ),
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
          ),
          onSubmitted: (val) {
            ref.watch(queryPeoplesSummary.notifier).update((state) => val);
            setState(() => showTextField = !showTextField);
          },
        );
      }),
      actions: [
        if (!showTextField) ...[
          IconButton(
            onPressed: () => setState(() => showTextField = !showTextField),
            icon: const Icon(Icons.search),
          ),
        ],
      ],
    );
  }
}
