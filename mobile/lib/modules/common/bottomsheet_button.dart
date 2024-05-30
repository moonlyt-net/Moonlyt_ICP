import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ShowBottomSheetButton extends StatefulWidget {
  const ShowBottomSheetButton({super.key});

  @override
  State<ShowBottomSheetButton> createState() => _ShowBottomSheetButtonState();
}

class _ShowBottomSheetButtonState extends State<ShowBottomSheetButton> {
  String buttonText = 'WebtoonFDFDFDF All';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        alignment: Alignment.center,
        width: 160,
        height: 30,
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.only(left: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white.withOpacity(0.2),
          border: Border.all(color: Colors.white),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              Icons.auto_stories_outlined,
              color: Colors.white,
            ),
            Container(
                padding: EdgeInsets.only(left: 5),
                width: 100,
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            ),
          ],
        ),
      ),
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) {
            return SizedBox(
              height: 200,
              child: ListWheelScrollView(
                itemExtent: 50,
                diameterRatio: 1.5,
                useMagnifier: true,
                magnification: 1.5,
                children: List<Widget>.generate(
                  10,
                  (index) => Center(
                    child: GestureDetector(
                      child: Text(
                        'Item $index',
                        style: const TextStyle(fontSize: 20),
                      ),
                      onTap: () {
                        setState(() {
                          buttonText = 'Item $index';
                        });
                        context.canPop();
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
