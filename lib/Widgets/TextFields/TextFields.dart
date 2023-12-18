import 'package:duke_kanban/Widgets/Others/CustomTexts.dart';
import 'package:flutter/material.dart';
import 'package:duke_kanban/Configuration/ColorConfig.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final int maxLines;
  final bool obscureText;
  final Widget suffix;
  final bool isEnabled;
  final TextInputType type;
  final int mLength;
  final double hSize;
  final Function(String) onChange;
  final Widget prefix;
  final String initText;
  final String lText;
  final String title;
  final bool autoFocus;
  final Color hintColor;
  final Color fillColor;
  final Color textFieldColor;
  final FocusNode focusNode;
  final Function() onEditingComplete;

  final AutovalidateMode autovalidateMode;
  final String Function(String) validator;

  CustomTextField(
      {Key key,
      this.hSize,
      @required this.hintText,
      @required this.controller,
      this.context,
      this.maxLines,
      this.autovalidateMode,
      @required this.obscureText,
      this.suffix,
      this.isEnabled,
      this.type,
      this.mLength,
      this.onChange,
      this.prefix,
      this.initText,
      this.lText,
      this.validator,
      this.autoFocus,
      this.hintColor,
      this.focusNode,
      this.onEditingComplete,

      @required this.fillColor,
      @required this.title,
      this.textFieldColor})
      : super(key: key);
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(
        data: widget.title ?? widget.title,
        fColor: Colors.black,
        fWeight: FontWeight.bold,
      ),
      subtitle: Container(
        color: Colors.transparent,
        child: TextFormField(
          validator: widget.validator,
          autovalidateMode: widget.autovalidateMode,
          focusNode: widget.focusNode,
          onEditingComplete : widget.onEditingComplete, 

          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.textFieldColor ?? Colors.black,
              fontSize: 16.0),
          initialValue: widget.initText,
          textInputAction: TextInputAction.next,
          maxLength: widget.mLength,
          enabled: widget.isEnabled,
          onChanged: widget.onChange,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.type,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            counterText: "",

            hintText: widget.hintText,
            filled: true,
            fillColor: widget.fillColor ?? ColorConfig.primaryAppColor,
            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide:
            //       BorderSide(color: ColorConfig.primaryAppColor, width: 1),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.hintColor ?? Colors.white,
              fontSize: widget.hSize ?? 14.0,
            ),
            labelText: widget.lText,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
        ),
      ),
    );
  }
}

class CustomTextFieldWOTitle extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final int maxLines;
  final bool obscureText;
  final Widget suffix;
  final bool isEnabled;
  final TextInputType type;
  final int mLength;
  final double hSize;
  final Function(String) onChange;
  final Widget prefix;
  final String initText;
  final String lText;
  final String title;
  final bool autoFocus;
  final Color hintColor;
  final Color fillColor;
  final Color textFieldColor;

  CustomTextFieldWOTitle(
      {Key key,
      this.hSize,
      @required this.hintText,
      @required this.controller,
      this.context,
      this.maxLines,
      @required this.obscureText,
      this.suffix,
      this.isEnabled,
      this.type,
      this.mLength,
      this.onChange,
      this.prefix,
      this.initText,
      this.lText,
      this.autoFocus,
      this.hintColor,
      @required this.fillColor,
      @required this.title,
      this.textFieldColor})
      : super(key: key);
  @override
  State<CustomTextFieldWOTitle> createState() => _CustomTextFieldWOTitleState();
}

class _CustomTextFieldWOTitleState extends State<CustomTextFieldWOTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.transparent,
        child: TextFormField(
          style: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.textFieldColor ?? Colors.black,
              fontSize: 16.0),
          initialValue: widget.initText,
          textInputAction: TextInputAction.next,
          maxLength: widget.mLength,
          enabled: widget.isEnabled,
          onChanged: widget.onChange,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.type,
          textCapitalization: TextCapitalization.words,
          decoration: InputDecoration(
            counterText: "",

            hintText: widget.hintText,
            filled: true,
            fillColor: widget.fillColor ?? ColorConfig.primaryAppColor,
            // border: InputBorder.none,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 1),
            ),
            // disabledBorder: OutlineInputBorder(
            //   borderRadius: BorderRadius.circular(10),
            //   borderSide:
            //       BorderSide(color: ColorConfig.primaryAppColor, width: 1),
            // ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: widget.hintColor ?? Colors.white,
              fontSize: widget.hSize ?? 14.0,
            ),
            labelText: widget.lText,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          ),
        ));
  }
}

class CustomTextFieldArea extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final int maxLines;
  final bool obscureText;
  final Widget suffix;
  final bool isEnabled;
  final TextInputType type;
  final int mLength;
  final Function(String) onChange;
  final Widget prefix;
  final String initText;
  final String lText;
  final bool autoFocus;

  const CustomTextFieldArea({
    Key key,
    @required this.hintText,
    @required this.controller,
    this.context,
    this.maxLines,
    @required this.obscureText,
    this.suffix,
    this.isEnabled,
    this.type,
    this.mLength,
    this.onChange,
    this.prefix,
    this.initText,
    this.lText,
    this.autoFocus,
  }) : super(key: key);

  @override
  State<CustomTextFieldArea> createState() => _CustomTextFieldAreaState();
}

class _CustomTextFieldAreaState extends State<CustomTextFieldArea> {
  double _minHeight = 50.0;
  double _maxHeight = 200.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: _minHeight,
          maxHeight: _maxHeight,
        ),
        child: TextFormField(
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: ColorConfig.btnColor2,
            fontSize: 16.0,
          ),
          initialValue: widget.initText,
          textInputAction: TextInputAction.next,
          maxLength: widget.mLength,
          enabled: widget.isEnabled,
          onChanged: widget.onChange,
          controller: widget.controller,
          obscureText: widget.obscureText,
          keyboardType: widget.type,
          textCapitalization: TextCapitalization.words,
          maxLines: widget.maxLines ?? null,
          decoration: InputDecoration(
            counterText: "",
            hintText: widget.hintText,
            filled: true,
            fillColor: Colors.white,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorConfig.primaryAppColor,
                width: 1,
              ),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: ColorConfig.primaryAppColor,
                width: 1,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.white, width: 0),
            ),
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: ColorConfig.btnColor3,
              fontSize: 14.0,
            ),
            labelText: widget.lText,
            prefixIcon: widget.prefix,
            suffixIcon: widget.suffix,
            contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          ),
        ),
      ),
    );
  }
}

class CustomProfileTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final BuildContext context;
  final int maxLines;
  final bool obscureText;
  final Widget suffix;
  final bool isEnabled;
  final TextInputType type;
  final int mLength;
  final double hSize;
  final Function(String) onChange;
  final Widget prefix;
  final String initText;
  final String lText;
  final bool autoFocus;

  CustomProfileTextField(
      {Key key,
      this.hSize,
      @required this.hintText,
      @required this.controller,
      this.context,
      this.maxLines,
      @required this.obscureText,
      this.suffix,
      this.isEnabled,
      this.type,
      this.mLength,
      this.onChange,
      this.prefix,
      this.initText,
      this.lText,
      this.autoFocus})
      : super(key: key);
  @override
  State<CustomProfileTextField> createState() => _CustomProfileTextFieldState();
}

class _CustomProfileTextFieldState extends State<CustomProfileTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: TextFormField(
        style: TextStyle(
            fontWeight: FontWeight.w600, color: Colors.black, fontSize: 16.0),
        initialValue: widget.initText,
        textInputAction: TextInputAction.next,
        maxLength: widget.mLength,
        enabled: widget.isEnabled,
        onChanged: widget.onChange,
        controller: widget.controller,
        obscureText: widget.obscureText,
        keyboardType: widget.type,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          filled: true,
          fillColor: ColorConfig.boxColor,
          // border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white, width: 1),
          ),
          // disabledBorder: OutlineInputBorder(
          //   borderRadius: BorderRadius.circular(10),
          //   borderSide:
          //       BorderSide(color: ColorConfig.primaryAppColor, width: 1),
          // ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white, width: 0),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white, width: 0),
          ),
          hintStyle: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black,
            fontSize: widget.hSize ?? 14.0,
          ),
          labelText: widget.lText,
          prefixIcon: widget.prefix,
          suffixIcon: widget.suffix,
          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        ),
      ),
    );
  }
}
