import 'package:flutter/material.dart';
import 'package:mmt_mobile/src/extension/number_extension.dart';

import '../src/style/app_color.dart';

class TextFieldWidget extends StatefulWidget {
  Icon? suffixIcon, prefixIcon;
  TextInputAction? inputAction;
  double? borderRadius, height, width;
  Color? backgroundColor, accentColor;
  bool? isShadow, isPassword, showWarning;
  String? hintText;
  FocusNode focusNode;
  TextEditingController controller;
  String? Function(String?)? validator;
  ValueChanged<String>? onChange;

  TextFieldWidget(
      {super.key,
      required this.focusNode,
      required this.controller,
      this.suffixIcon,
      this.onChange,
      this.prefixIcon,
      this.borderRadius,
      this.inputAction,
      this.accentColor,
      this.backgroundColor,
      this.height,
      this.width,
      this.isShadow,
      this.isPassword,
      this.showWarning,
      this.hintText,
      this.validator});

  @override
  State<TextFieldWidget> createState() => _TextFieldWidgetState();
}

class _TextFieldWidgetState extends State<TextFieldWidget> {
  bool isFocus = false;
  bool _hidePassword = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.focusNode.addListener(() {
      if (!widget.focusNode.hasFocus) {
        // Call function when the text field loses focus
        setState(() {
          isFocus = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
        // height: widget.height,
        duration: 500.millisecond,
        decoration: BoxDecoration(
            boxShadow: (widget.isShadow == true)
                ? [
                    const BoxShadow(
                        color: Colors.grey, blurRadius: 2, spreadRadius: 1)
                  ]
                : [const BoxShadow(spreadRadius: 0, blurRadius: 0)],
            borderRadius: widget.borderRadius?.borderRadius,
            border: Border.all(
                width: (widget.showWarning ?? false) ? 2 : 1,
                color: (widget.showWarning ?? false)
                    ? AppColors.dangerColor
                    : _hidePassword
                        ? Colors.black
                        : widget.backgroundColor ?? Colors.black),
            color: widget.suffixIcon == null
                ? isFocus
                    ? widget.accentColor
                    : widget.backgroundColor
                : widget.backgroundColor),
        child: Stack(
          children: <Widget>[
            widget.suffixIcon == null
                ? Container()
                : Align(
                    alignment: Alignment.centerRight,
                    child: AnimatedContainer(
                      alignment: Alignment.centerRight,
                      width: isFocus ? 500 : 40,
                      height: isFocus ? widget.height : 30,
                      margin: EdgeInsets.only(
                          right: isFocus ? 0 : 7, top: isFocus ? 0 : 10),
                      duration: 500.millisecond,
                      decoration: BoxDecoration(
                        borderRadius: isFocus
                            ? widget.borderRadius?.borderRadius
                            : const BorderRadius.all(Radius.circular(60)),
                        color: _hidePassword
                            ? widget.accentColor
                            : widget.accentColor?.withOpacity(0.8),
                      ),
                    ),
                  ),
            widget.suffixIcon == null
                ? Container()
                : GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.isPassword == true) {
                          setState(() {
                            _hidePassword = !_hidePassword;
                            print("Hide Password : $_hidePassword");
                          });
                        }
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 15, top: 10),
                      alignment: Alignment.centerRight,
                      child: Icon(
                        widget.suffixIcon?.icon,
                        color: Colors.white,
                      ),
                    ),
                  ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Icon(widget.prefixIcon?.icon,
                        color: isFocus
                            ? widget.backgroundColor
                            : widget.accentColor),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(
                      margin: const EdgeInsets.only(right: 50, top: 3),
                      child: TextFormField(
                        onChanged: widget.onChange,
                        textInputAction:
                            widget.inputAction ?? TextInputAction.done,
                        validator: widget.validator,
                        controller: widget.controller,
                        focusNode: widget.focusNode,
                        cursorWidth: 2,
                        obscureText:
                            widget.isPassword == true ? _hidePassword : false,
                        // keyboardType: widget.inputType,
                        style: TextStyle(
                          // fontFamily: widget.fontFamily,
                          // fontStyle: widget.fontStyle,
                          // fontWeight: widget.fontWeight,
                          // wordSpacing: widget.wordSpacing,
                          // textBaseline: widget.textBaseline,
                          fontSize: 18,
                          letterSpacing: 2,
                          color: isFocus
                              ? widget.backgroundColor
                              : widget.accentColor,
                        ),
                        // autofocus: widget.autofocus,
                        // autocorrect: widget.autocorrect,
                        // focusNode: widget.focusNode,
                        // enabled: widget.enabled,
                        // maxLength: widget.maxLength,
                        // maxLines: widget.maxLines,
                        // minLines: widget.minLines,
                        // onChanged: widget.onChanged,
                        onTap: () {
                          setState(() {
                            isFocus = true;
                          });
                          // if (widget.onTap != null) {
                          //   widget.onTap();
                          // }
                        },
                        onTapOutside: (event) {
                          setState(() {
                            isFocus = false;
                          });
                        },
                        onFieldSubmitted: (t) {
                          setState(() {
                            isFocus = false;
                          });
                          // widget.onSubmitted(t);
                        },
                        decoration: InputDecoration(
                            errorStyle: const TextStyle(height: 0),
                            hintText: widget.hintText,
                            isDense: true,
                            hintStyle: TextStyle(
                                color: isFocus
                                    ? widget.backgroundColor
                                    : widget.accentColor),
                            border: InputBorder.none),
                        cursorColor: isFocus
                            ? widget.backgroundColor
                            : widget.accentColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

// import 'package:flutter/material.dart';
// import 'package:logistic/src/extension/number_extension.dart';
//
// import '../src/style/app_color.dart';
//
// class TextFieldWidget extends StatefulWidget {
//   final Icon? suffixIcon, prefixIcon;
//   final TextInputAction? inputAction;
//   final double? borderRadius, height, width;
//   final Color? backgroundColor, accentColor;
//   final bool? isShadow, isPassword, showWarning;
//   final String? hintText;
//   final FocusNode focusNode;
//   final TextEditingController controller;
//   final String? Function(String?)? validator;
//
//   TextFieldWidget({super.key,
//     required this.focusNode,
//     required this.controller,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.borderRadius,
//     this.inputAction,
//     this.accentColor,
//     this.backgroundColor,
//     this.height,
//     this.width,
//     this.isShadow,
//     this.isPassword,
//     this.showWarning,
//     this.hintText,
//     this.validator});
//
//   @override
//   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// }
//
// class _TextFieldWidgetState extends State<TextFieldWidget> {
//   bool isFocus = false;
//   bool _hidePassword = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     widget.focusNode.addListener(() {
//       if (!widget.focusNode.hasFocus) {
//         // Call function when the text field loses focus
//         setState(() {
//           isFocus = false;
//         });
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       // height: widget.height,
//         duration: 500.millisecond,
//         decoration: BoxDecoration(
//             boxShadow: (widget.isShadow == true)
//                 ? [
//               const BoxShadow(
//                   color: Colors.grey, blurRadius: 2, spreadRadius: 1)
//             ]
//                 : [const BoxShadow(spreadRadius: 0, blurRadius: 0)],
//             borderRadius: widget.borderRadius?.borderRadius,
//             border: Border.all(
//                 width: (widget.showWarning ?? false) ? 2 : 1,
//                 color: (widget.showWarning ?? false)
//                     ? AppColors.dangerColor
//                     : _hidePassword
//                     ? Colors.black
//                     : widget.backgroundColor ?? Colors.black),
//             color: widget.suffixIcon == null
//                 ? isFocus
//                 ? widget.accentColor
//                 : widget.backgroundColor
//                 : widget.backgroundColor),
//         child: Stack(
//           children: <Widget>[
//             widget.suffixIcon == null
//                 ? Container()
//                 : Align(
//               alignment: Alignment.centerRight,
//               child: AnimatedContainer(
//                 alignment: Alignment.centerRight,
//                 width: isFocus ? 500 : 40,
//                 height: isFocus ? widget.height : 30,
//                 margin: EdgeInsets.only(
//                     right: isFocus ? 0 : 7, top: isFocus ? 0 : 10),
//                 duration: 500.millisecond,
//                 decoration: BoxDecoration(
//                   borderRadius: isFocus
//                       ? widget.borderRadius?.borderRadius
//                       : const BorderRadius.all(Radius.circular(60)),
//                   color: _hidePassword
//                       ? widget.accentColor
//                       : widget.accentColor?.withOpacity(0.8),
//                 ),
//               ),
//             ),
//             widget.suffixIcon == null
//                 ? Container()
//                 : GestureDetector(
//               onTap: () {
//                 setState(() {
//                   if (widget.isPassword == true) {
//                     setState(() {
//                       _hidePassword = !_hidePassword;
//                       print("Hide Password : $_hidePassword");
//                     });
//                   }
//                 });
//               },
//               child: Container(
//                 margin: const EdgeInsets.only(right: 15, top: 10),
//                 alignment: Alignment.centerRight,
//                 child: Icon(
//                   widget.suffixIcon?.icon,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//             Center(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Expanded(
//                     flex: 1,
//                     child: Icon(
//                         widget.prefixIcon?.icon,
//                         color:
//                         isFocus ? widget.backgroundColor : widget.accentColor
//                     ),
//                   ),
//                   Expanded(
//                     flex: 5,
//                     child: Container(
//                       margin: const EdgeInsets.only(right: 50, top: 3),
//                       child: TextFormField(
//                         textInputAction:
//                         widget.inputAction ?? TextInputAction.done,
//                         validator: widget.validator,
//                         controller: widget.controller,
//                         focusNode: widget.focusNode,
//                         cursorWidth: 2,
//                         obscureText:
//                         widget.isPassword == true ? _hidePassword : false,
//                         // keyboardType: widget.inputType,
//                         style: TextStyle(
//                           // fontFamily: widget.fontFamily,
//                           // fontStyle: widget.fontStyle,
//                           // fontWeight: widget.fontWeight,
//                           // wordSpacing: widget.wordSpacing,
//                           // textBaseline: widget.textBaseline,
//                           fontSize: 18,
//                           letterSpacing: 2,
//                           color: isFocus
//                               ? widget.backgroundColor
//                               : widget.accentColor,
//                         ),
//                         // autofocus: widget.autofocus,
//                         // autocorrect: widget.autocorrect,
//                         // focusNode: widget.focusNode,
//                         // enabled: widget.enabled,
//                         // maxLength: widget.maxLength,
//                         // maxLines: widget.maxLines,
//                         // minLines: widget.minLines,
//                         // onChanged: widget.onChanged,
//                         onTap: () {
//                           setState(() {
//                             isFocus = true;
//                           });
//                           // if (widget.onTap != null) {
//                           //   widget.onTap();
//                           // }
//                         },
//                         onTapOutside: (event) {
//                           setState(() {
//                             isFocus = false;
//                           });
//                         },
//                         onFieldSubmitted: (t) {
//                           setState(() {
//                             isFocus = false;
//                           });
//                           // widget.onSubmitted(t);
//                         },
//                         decoration: InputDecoration(
//                             errorStyle: const TextStyle(height: 0),
//                             hintText: widget.hintText,
//                             isDense: true,
//                             hintStyle: TextStyle(
//                                 color: isFocus
//                                     ? widget.backgroundColor
//                                     : widget.accentColor),
//                             border: InputBorder.none),
//                         cursorColor: isFocus
//                             ? widget.backgroundColor
//                             : widget.accentColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }
//
//
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/material.dart';
// // import 'package:logistic/src/extension/number_extension.dart';
// //
// // class TextFieldWidget extends StatefulWidget {
// //   Icon? suffixIcon, prefixIcon;
// //
// //   double? borderRadius, height, width;
// //   Color? backgroundColor, accentColor;
// //   bool? isShadow,isPassword;
// //   String? hintText;
// //   FocusNode focusNode;
// //   TextEditingController controller;
// //   String? Function(String?)? validator;
// //
// //
// //   TextFieldWidget(
// //       {super.key,
// //         required this.focusNode,
// //         required this.controller,
// //       this.suffixIcon,
// //         this.prefixIcon,
// //       this.borderRadius,
// //       this.accentColor,
// //       this.backgroundColor,
// //         this.height,
// //         this.width,
// //       this.isShadow,
// //         this.isPassword,
// //       this.hintText,
// //       this.validator});
// //
// //   @override
// //   State<TextFieldWidget> createState() => _TextFieldWidgetState();
// // }
// //
// // class _TextFieldWidgetState extends State<TextFieldWidget> {
// //
// //   bool isFocus = false;
// //   bool _hidePassword = true;
// //
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     widget.focusNode.addListener(() {
// //       if (!widget.focusNode.hasFocus) {
// //         // Call function when the text field loses focus
// //         setState(() {
// //           isFocus = false;
// //         });
// //       }
// //     });
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //
// //     return AnimatedContainer(
// //       // height: widget.height,
// //       duration: 500.millisecond,
// //       decoration: BoxDecoration(
// //           boxShadow: ( widget.isShadow == true )
// //               ? [ const BoxShadow(color: Colors.grey, blurRadius: 2, spreadRadius: 1)]
// //               : [ const BoxShadow(spreadRadius: 0, blurRadius: 0)],
// //           borderRadius: widget.borderRadius?.borderRadius,
// //           border: Border.all(
// //             color: _hidePassword ? Colors.black : widget.backgroundColor ?? Colors.black
// //           ),
// //           color: widget.suffixIcon == null
// //               ? isFocus
// //                   ? widget.accentColor
// //                   : widget.backgroundColor
// //               : widget.backgroundColor),
// //       child : Stack(
// //         children: <Widget>[
// //           widget.suffixIcon == null
// //               ? Container()
// //               : Align(
// //             alignment: Alignment.centerRight,
// //             child: AnimatedContainer(
// //               alignment: Alignment.centerRight,
// //               width: isFocus ? 500 : 40,
// //               height: isFocus ? widget.height : 30,
// //               margin: EdgeInsets.only(right: isFocus ? 0 : 7,  top: isFocus ? 0 : 10),
// //               duration: 500.millisecond,
// //               decoration: BoxDecoration(
// //                 borderRadius: isFocus
// //                     ? widget.borderRadius?.borderRadius
// //                     : const BorderRadius.all(Radius.circular(60)),
// //                 color: _hidePassword ? widget.accentColor : widget.accentColor?.withOpacity(0.8),
// //               ),
// //             ),
// //           ),
// //           widget.suffixIcon == null
// //               ? Container()
// //               : GestureDetector(
// //             onTap: () {
// //               setState(() {
// //                 if(widget.isPassword == true){
// //                   setState(() {
// //                     _hidePassword = !_hidePassword;
// //                     print("Hide Password : $_hidePassword");
// //                   });
// //                 }
// //               });
// //             },
// //             child: Container(
// //               margin: const EdgeInsets.only(right: 15, top: 10),
// //               alignment: Alignment.centerRight,
// //               child: Icon(
// //                 widget.suffixIcon?.icon,
// //                 color: Colors.white,
// //               ),
// //             ),
// //           ),
// //           Center(
// //             child: Row(
// //               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //               children: <Widget>[
// //                 Expanded(
// //                   flex: 1,
// //                   child: Icon(
// //                     widget.prefixIcon?.icon,
// //                     color:
// //                     isFocus ? widget.backgroundColor : widget.accentColor,
// //                   ),
// //                 ),
// //                 Expanded(
// //                   flex: 5,
// //                   child: Container(
// //                     margin: const EdgeInsets.only(right: 50, top: 3),
// //                     child: TextFormField(
// //                       validator: widget.validator,
// //                       controller: widget.controller,
// //                       focusNode: widget.focusNode,
// //                       // controller: widget.controller,
// //                       cursorWidth: 2,
// //                       obscureText: widget.isPassword == true ?  _hidePassword : false,
// //                       // keyboardType: widget.inputType,
// //                       style: TextStyle(
// //                         // fontFamily: widget.fontFamily,
// //                         // fontStyle: widget.fontStyle,
// //                         // fontWeight: widget.fontWeight,
// //                         // wordSpacing: widget.wordSpacing,
// //                         // textBaseline: widget.textBaseline,
// //                         fontSize: 18,
// //                         letterSpacing: 2,
// //                         color: isFocus ? widget.backgroundColor : widget.accentColor,
// //                       ),
// //                       // autofocus: widget.autofocus,
// //                       // autocorrect: widget.autocorrect,
// //                       // focusNode: widget.focusNode,
// //                       // enabled: widget.enabled,
// //                       // maxLength: widget.maxLength,
// //                       // maxLines: widget.maxLines,
// //                       // minLines: widget.minLines,
// //                       // onChanged: widget.onChanged,
// //                       onTap: () {
// //                         setState(() {
// //                           isFocus = true;
// //                         });
// //                         // if (widget.onTap != null) {
// //                         //   widget.onTap();
// //                         // }
// //                       },
// //                       onTapOutside: (event) {
// //                         setState(() {
// //                           isFocus = false;
// //                         });
// //                       },
// //                       onFieldSubmitted: (t) {
// //                         setState(() {
// //                           isFocus = false;
// //                         });
// //                         // widget.onSubmitted(t);
// //                       },
// //                       textInputAction: TextInputAction.done,
// //                       decoration: InputDecoration(
// //                           errorStyle: const TextStyle(height: 0),
// //                           hintText: widget.hintText,
// //                           isDense: true,
// //                           hintStyle: TextStyle(
// //                             color : isFocus ? widget.backgroundColor : widget.accentColor
// //                           ),
// //                           border: InputBorder.none),
// //                       cursorColor:
// //                       isFocus ? widget.backgroundColor : widget.accentColor,
// //                     ),
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       )
// //     );
// //   }
// // }
