import 'package:flutter/material.dart';

import '../../../core/constants.dart';
import '../../../model/outcome_model.dart';
class OutcomePage extends StatelessWidget {
  final List<OutcomeModel> outcomes;
  final String currency;
  const OutcomePage({Key? key, required this.outcomes, required this.currency})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        titleTextStyle: Theme.of(context)
            .textTheme
            .headline4
            ?.copyWith(color: Colors.white),
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Chiqim daftar',
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '08.12.2021 dan',
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                '31.12.2021 gacha',
                style: Theme.of(context).textTheme.headline4,
              ),
              TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.grey.shade300),
                  onPressed: () {},
                  child: Text(
                    'Filter',
                    style: Theme.of(context).textTheme.headline5,
                  ))
            ],
          ),
          Expanded(
            child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                itemCount: outcomes.length,
                itemBuilder: (ctx, index) => Container(
                      width: double.infinity,
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            color: Colors.black,
                            width: 0.5,
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            outcomes[index].name ?? '',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Text(
                                outcomes[index].count.toString() ?? '',
                                style: Theme.of(context).textTheme.headline4,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                itemUnit[int.parse(
                                            outcomes[index].type.toString()) -
                                        1]
                                    .toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                      backgroundColor: Colors.white24,
                                    ),
                              ),
                              const Spacer(),
                              Text(
                                "1 ${itemUnit[int.parse(outcomes[index].type.toString()) - 1]} narxi: ",
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                      backgroundColor: Colors.white24,
                                    ),
                              ),
                              const SizedBox(width: 5),
                              Text(
                                "${outcomes[index].entryPrice.toString()} $currency",
                                style: Theme.of(context).textTheme.headline4,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Text(
                                'Jami summa: ',
                                style: Theme.of(context).textTheme.headline3,
                              ),
                              Text(
                                '${outcomes[index].totalsum} $currency',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    ?.copyWith(
                                      backgroundColor: Colors.white24,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )),
          )
        ],
      ),
    );
  }
}
