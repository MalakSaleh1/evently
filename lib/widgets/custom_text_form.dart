import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/app_colors.dart';
import '../core/app_provider/app_provider.dart';
class CustomTextForm extends StatefulWidget {
   CustomTextForm({super.key,required this.text,required this.controller,required this.validator});
 String text;
 String? icon;
 String? suffixIcon;
 TextEditingController controller;
  String? Function(String?)? validator;


 CustomTextForm.icon({super.key,required this.text,required this.icon,required this.controller,required this.validator});
 CustomTextForm.suffixIcon({super.key,required this.text,required this.icon,required this.suffixIcon,required this.controller,required this.validator});

  @override
  State<CustomTextForm> createState() => _CustomTextFormState();
}

class _CustomTextFormState extends State<CustomTextForm> {

  bool  isPasswordVisible=false;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AppProvider>(context);
    ThemeData theme = Theme.of(context);
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      style: theme.textTheme.titleSmall,
      obscureText: !isPasswordVisible,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerColor,
              )
          ),
          focusedBorder:OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide(
                color: theme.dividerColor,
              )
          ) ,
          filled: true,
          fillColor: theme.primaryColorLight,
          hintText: widget.text,
          hintStyle: theme.textTheme.titleSmall,
          prefixIcon:widget.icon!=null? ImageIcon(AssetImage(widget.icon!),color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,):SizedBox(),
          suffixIcon: widget.suffixIcon!=null?IconButton(onPressed: () { setState(() {
            isPasswordVisible = !isPasswordVisible;
          }); }, icon: ImageIcon( AssetImage(widget.suffixIcon!),color:provider.themeMode==ThemeMode.light? AppColors.lightTextFieldColor:AppColors.darkTextFieldColor,)):SizedBox(),),

    );
  }
}
