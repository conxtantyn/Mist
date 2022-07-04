part of 'picker.dart';

class _PickerView extends StatefulWidget {
  @override
  __PickerViewState createState() => __PickerViewState();
}

class __PickerViewState
    extends BaseState<_PickerView, PickerBloc, PickerState> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (Duration duration) {
        context.read<PickerBloc>().add(
              UpdateCountryEvent(countryList),
            );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverPersistentHeader(
            pinned: true,
            floating: true,
            delegate: _ToolBar(
              title: AppLocalizations.of(context)!.countryLabel,
              onSearch: (search) => context.read<PickerBloc>().add(
                    SearchEvent(search),
                  ),
            ),
          ),
        ];
      },
      body: BlocConsumer<PickerBloc, PickerState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Container(
            color: context.read<Skin>().colorScheme.surface,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.countries.length,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                final country = state.countries.elementAt(index);
                return CountryItem(
                  country: country,
                  onTap: () {
                    context.read<MainBloc>().add(
                          UpdateCountryCodeEvent(country.isoCode),
                        );
                    Navigator.of(context).pop(country);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ToolBar extends SliverPersistentHeaderDelegate {
  final String title;

  final Function(String) onSearch;

  _ToolBar({
    required this.title,
    required this.onSearch,
  }) : super();

  @override
  double get maxExtent => kToolbarHeight * 3;

  @override
  double get minExtent => kToolbarHeight * 2;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return oldDelegate.minExtent != minExtent &&
        oldDelegate.maxExtent != maxExtent;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final value = (shrinkOffset / kToolbarHeight).clamp(0.0, 1.0);
    final maxPadding = kMinInteractiveDimension - Dimens.padding;
    final shrinkPadding = Dimens.contentPadding + (value * maxPadding);
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        border: Border(
          bottom: BorderSide(
            color: context.read<Skin>().colorScheme.secondaryVariant,
            width: 1.0,
          ),
        ),
      ),
      child: Stack(
        children: [
          AppBar(
            elevation: 0.0,
            brightness: Brightness.dark,
            backgroundColor: Theme.of(context).backgroundColor,
            iconTheme: Theme.of(context).iconTheme.copyWith(
                  color: context.read<Skin>().colorScheme.onSurface,
                ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: kToolbarHeight - 1,
                  padding: EdgeInsets.symmetric(
                    horizontal: shrinkPadding,
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.headline5,
                    ),
                  ),
                ),
                Container(
                  height: kToolbarHeight,
                  color: context.read<Skin>().colorScheme.surface,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: SearchInput(
                      onChanged: onSearch,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.searchHint,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CountryItem extends StatelessWidget {
  final Country country;

  final VoidCallback onTap;

  CountryItem({
    Key? key,
    required this.country,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).backgroundColor,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: Dimens.contentPadding,
            vertical: Dimens.padding,
          ),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                width: 1.0,
                color: context.read<Skin>().colorScheme.secondaryVariant,
              ),
            ),
          ),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(2.0),
                child: CountryPickerUtils.getDefaultFlagImage(country),
              ),
              SizedBox(width: Dimens.padding),
              Expanded(
                  child: Text(
                country.name,
                style: Theme.of(context).textTheme.subtitle2?.copyWith(
                      color: context.read<Skin>().colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
              )),
              SizedBox(width: Dimens.padding),
              Text(
                "+${country.phoneCode}",
                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                      color: context.read<Skin>().colorScheme.onBackground,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
