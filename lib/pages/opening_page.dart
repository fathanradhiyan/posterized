import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:posterized/const/color.dart';
import 'package:posterized/pages/input_page.dart';
import 'package:posterized/widget/awesome_error_dialog.dart';

class OpeningPage extends StatefulWidget {
  const OpeningPage({Key key}) : super(key: key);

  @override
  _OpeningPageState createState() => _OpeningPageState();
}

class _OpeningPageState extends State<OpeningPage> {
  TextEditingController nameController = TextEditingController();

  bool isNameValid = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 250,
                child: ColorFiltered(
                    colorFilter:
                    ColorFilter.mode(Color(0xFF64B6B6), BlendMode.srcATop),
                    child:Image(image: AssetImage('assets/images/logo.png'),))),
            SizedBox(height: 20,),
            inputNameBar()
          ],
        ),
        bottomSheet: footerButton(),
      ),
    );
  }

  Widget inputNameBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TextField(
            onChanged: (text) {
              setState(() {
                isNameValid = text.isNotEmpty;
              });
            },
            maxLength: 25,
            controller: nameController,
            decoration: InputDecoration(
              counterText: "",
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: ColorsConsts.sky),
                borderRadius: BorderRadius.circular(15),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              prefixIcon: Icon(
                Icons.sports_basketball,
                color: ColorsConsts.sky,
              ),
              labelText: "Name",
              labelStyle: GoogleFonts.ubuntu(color: ColorsConsts.sky),
              hintText: "Input your name",
              hintStyle: GoogleFonts.ubuntu(color: Colors.grey),
              suffixIcon: (isNameValid
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          isNameValid = false;
                          nameController.clear();
                        });
                      },
                      icon: Icon(
                        Icons.clear,
                        color: ColorsConsts.sky,
                      ))
                  : null),
            ),
            keyboardType: TextInputType.text,
            // inputFormatters: <TextInputFormatter>[
            //   FilteringTextInputFormatter.allow(RegExp("[0-9a-zA-Z]")),
            // ],
          )),
    );
  }

  Widget footerButton(){
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: ElevatedButton(
        onPressed: (nameController.text == '')? (){
          errorDialog(context, 'Failed', 'Required Name').show();
        }: (){
          String username = nameController.text;
          Navigator.push(context, MaterialPageRoute(builder: (context) => InputPage(name: username,)));
        },
        child: Text('Next'.toUpperCase(), style: GoogleFonts.cairo(fontWeight: FontWeight.bold),),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            return ColorsConsts.sky;
          }),
          textStyle: MaterialStateProperty.resolveWith((states) {
            // If the button is pressed, return size 40, otherwise 20
            if (states.contains(MaterialState.pressed)) {
              return GoogleFonts.cairo(fontSize: 40);
            }
            return GoogleFonts.cairo(fontSize: 20);
          }),
        ),
      ),
    );
  }
}
