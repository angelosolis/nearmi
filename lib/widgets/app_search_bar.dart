import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/utils/utils.dart';

class AppSearchBar extends StatelessWidget {
  final VoidCallback onSearch;
  final VoidCallback onScan;

  const AppSearchBar({
    Key? key,
    required this.onSearch,
    required this.onScan,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 48,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Theme.of(context).dividerColor.withAlpha(20),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(
                0,
                2,
              ), // changes position of shadow
            ),
          ],
        ),
        child: TextButton(
          onPressed: onSearch,
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.search,
                  color: Theme.of(context).textTheme.labelLarge?.color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    Translate.of(context).translate(
                      'search_location',
                    ),
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
                const VerticalDivider(),
                InkWell(
                  onTap: onScan,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    child: Icon(
                      Icons.qr_code_scanner_outlined,
                      color: Theme.of(context).colorScheme.primary,
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
