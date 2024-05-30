import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:moonlyt/modules/screen/navigation/my_bottom_navigation_bar.dart';

import 'package:moonlyt/modules/wallet/transaction_view_model.dart';
import 'package:moonlyt/modules/wallet/wallet_balance_view_model.dart';

class WalletView extends ConsumerStatefulWidget {
  const WalletView({super.key});

  @override
  ConsumerState<WalletView> createState() => _WalletViewState();
}

class _WalletViewState extends ConsumerState<WalletView> {
  void _claimMylt() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
                side: const BorderSide(color: Colors.white, width: 1.0)),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            titlePadding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            actionsPadding: const EdgeInsets.symmetric(horizontal: 20),
            backgroundColor: const Color(0xFF333333).withOpacity(0.5),
            content: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.5),
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              height: 50,
              width: 100,
              child: const Text("10000 MYLT"),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  ref.read(walletBalanceProvider.notifier).updateBalance(10000);
                  ref
                      .read(transactionRecordsProvider.notifier)
                      .addTransactionRecord(
                        DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        10000,
                        "Claim",
                      );

                  Navigator.of(context).pop();
                },
                child: Container(
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 0.5),
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Text(
                      'Claim',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final transactionRecords = ref.watch(transactionRecordsProvider);
    return WillPopScope(
      onWillPop: () async {
        ref.read(selectedIndexProvider.notifier).state = 0;
        return true;
      },
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset('assets/background_dark.png',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
            SafeArea(
              child: Container(
                padding: EdgeInsets.only(right: 20, left: 20, top: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Wallet",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 30,
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.red.withOpacity(0.2),
                              ),
                              width: 80,
                              child:
                                  ref.watch(walletBalanceProvider).balance == 0
                                      ? Text(
                                          "Claim",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        )
                                      : Text(
                                          "Claimed",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18),
                                        ),
                            ),
                            onTap: () {
                              if (ref.watch(walletBalanceProvider).balance ==
                                  0) {
                                _claimMylt();
                              }
                              ;
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: 20,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(color: Colors.white, width: 0.3),
                      ),
                      width: double.infinity,
                      height: 60,
                      child: Text(
                        'b740f5 ... e6de55',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      alignment: Alignment.centerLeft,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white.withOpacity(0.2),
                        border: Border.all(color: Colors.white, width: 0.3),
                      ),
                      width: double.infinity,
                      height: 80,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total",
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Text(
                              textAlign: TextAlign.right,
                              '${ref.watch(walletBalanceProvider).balance} MYLT',
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.red,
                          border: Border.all(color: Colors.white, width: 2),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Text(
                          textAlign: TextAlign.center,
                          "Send",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onTap: () {
                        context.pushNamed('send');
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 30,
                      child: Text(
                        "Transaction history",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height,
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: transactionRecords.length,
                              itemBuilder: (context, index) {
                                final transaction = transactionRecords[index];
                                return Container(
                                  height: 50,
                                  margin: EdgeInsets.only(top: 10),
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.white.withOpacity(0.2),
                                    border: Border.all(
                                        color: Colors.white, width: 0.3),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.type,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            transaction.date,
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: Colors.white70,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        "${transaction.amount} MYLT",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
