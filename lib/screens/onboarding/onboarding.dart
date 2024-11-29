import 'package:flutter/material.dart';
import 'package:listar_flutter_pro/blocs/bloc.dart';
import 'package:listar_flutter_pro/configs/config.dart';
import 'package:listar_flutter_pro/utils/utils.dart';
import 'package:listar_flutter_pro/widgets/app_button.dart';

final onboardingDefault = [
  {
    "title": 'onboard_base_title',
    "description": 'onboard_basic_message',
    "image": Images.intro1,
    "value": 'basic',
    "domain": 'https://demo.listarapp.com',
  },
  {
    "title": 'onboard_professional_title_1',
    "description": 'onboard_professional_message_1',
    "image": Images.intro2,
    "value": 'food',
    "domain": 'https://food.listarapp.com',
  },
  {
    "title": 'onboard_professional_title_2',
    "description": 'onboard_professional_message_2',
    "image": Images.intro3,
    "value": 'real_estate',
    "domain": 'https://realestate.listarapp.com',
  },
  {
    "title": 'onboard_professional_title_3',
    "description": 'onboard_professional_message_3',
    "image": Images.intro4,
    "value": 'event',
    "domain": 'https://event.listarapp.com',
  },
];

class Onboarding extends StatefulWidget {
  final VoidCallback onAction;
  const Onboarding({Key? key, required this.onAction}) : super(key: key);

  @override
  createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: const Alignment(0, 1),
            colors: <Color>[
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.primary.withOpacity(.2),
              Theme.of(context).colorScheme.primary.withOpacity(.1),
            ],
            tileMode: TileMode.mirror,
          ),
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: onboardingDefault.map((item) {
            return Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: DecorationImage(
                        image: AssetImage(item['image'] ?? ''),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    Translate.of(context).translate(item['title']),
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    Translate.of(context).translate(item['description']),
                    style: Theme.of(context).textTheme.titleSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    item['domain'] ?? '',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet() {
    return Container(
      height: 120,
      padding: const EdgeInsets.all(4),
      child: Column(
        children: [
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 0; i < onboardingDefault.length; i++)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 2),
                  child: IndicatorDot(isActive: i == _currentPage),
                ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AppButton(
                Translate.of(context).translate('skip'),
                type: ButtonType.text,
                onPressed: () {
                  widget.onAction();
                },
              ),
              AppButton(
                Translate.of(context).translate('apply'),
                type: ButtonType.text,
                onPressed: () {
                  widget.onAction();
                  AppBloc.applicationCubit.onChangeDomain(
                    onboardingDefault[_currentPage]['domain']!,
                  );
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}

class IndicatorDot extends StatelessWidget {
  final bool isActive;

  const IndicatorDot({Key? key, required this.isActive}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: isActive ? Theme.of(context).colorScheme.primary : Colors.grey,
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
