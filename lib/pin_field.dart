// Remember to change the number of _Square
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kLength = 5;
const _kFontSize = 30.0;

class PinField extends StatelessWidget {
  final Color? color;
  final FocusNode? node;
  final void Function(String) onFilled;
  final PinController? pinController;
  const PinField({
    Key? key,
    this.color,
    this.node,
    this.pinController,
    required this.onFilled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final nodeX = node ?? FocusNode();

    final stateNumber = pinController?._statePin ?? ValueNotifier<String>('');

    void onChange(text) {
      if (text.length == _kLength) {
        nodeX.unfocus();
      }

      onFilled(text);
      stateNumber.value = text;
    }

    return Stack(
      children: [
        // Only way to control keyboard in Flutter :( is using TextField
        TextField(
          enableInteractiveSelection: false,
          controller: pinController?._textController,
          focusNode: nodeX,
          autofocus: false,
          maxLength: _kLength,
          autocorrect: false,
          style: const TextStyle(
            color: Colors.transparent,
            fontSize:
                _kFontSize, // it is a hidden textfield which should remain transparent and extremely small
          ),
          onChanged: onChange,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          showCursor: false,
          scrollPadding: const EdgeInsets.only(bottom: 30),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: InputBorder.none,
            counterText: '',
            fillColor: Colors.red,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
          ),
        ),
        IgnorePointer(
          child: ValueListenableBuilder<String>(
            valueListenable: stateNumber,
            builder: (_, number, __) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _Square(
                      color: color,
                      number: number.isNotEmpty && number.isNotEmpty
                          ? number[0]
                          : ''),
                  const SizedBox(
                    width: 9,
                  ),
                  _Square(
                      color: color,
                      number: number.isNotEmpty && number.length >= 2
                          ? number[1]
                          : ''),
                  const SizedBox(
                    width: 9,
                  ),
                  _Square(
                      color: color,
                      number: number.isNotEmpty && number.length >= 3
                          ? number[2]
                          : ''),
                  const SizedBox(
                    width: 9,
                  ),
                  _Square(
                      color: color,
                      number: number.isNotEmpty && number.length >= 4
                          ? number[3]
                          : ''),
                  const SizedBox(
                    width: 9,
                  ),
                  _Square(
                      color: color,
                      number: number.isNotEmpty && number.length >= 5
                          ? number[4]
                          : ''),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}

class PinController {
  final _textController = TextEditingController();
  final _statePin = ValueNotifier<String>('');

  String get text => _textController.text;

  void clear() {
    _textController.clear();
    _statePin.value = '';
  }
}

class _Square extends StatelessWidget {
  final String number;
  final Color? color;
  const _Square({Key? key, required this.number, this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51,
      width: 51,
      child: DecoratedBox(
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(7)),
            border: Border.all(width: 1, color: Colors.cyan)),
        child: Center(
          child: Text(
            number,
            style: const TextStyle(
              fontSize: _kFontSize,
              height: 1.35,
            ),
            textScaleFactor: 1,
          ),
        ),
      ),
    );
  }
}
