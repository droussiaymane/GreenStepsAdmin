import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/utils/utils.dart';

//4

class EmailInputWidget extends StatelessWidget {
  const EmailInputWidget({
    Key? key,
    required TextEditingController emailController,
  })  : _emailController = emailController,
        super(key: key);

  final TextEditingController _emailController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          hintText: 'Adresse mail',
          border: InputBorder.none,
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        controller: _emailController,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "L'email est obligatoire";
          }
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);
          if (!emailValid) {
            return "L'email n'est pas valide";
          }
          return null;
        },
      ),
    );
  }
}

class PassWordInputWidget extends StatelessWidget {
  const PassWordInputWidget({
    Key? key,
    required TextEditingController passwordController,
  })  : _passwordController = passwordController,
        super(key: key);

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(),
      ),
      child: TextFormField(
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          hintText: 'Mot de passe',
          border: InputBorder.none,
        ),
        obscureText: true,
        textInputAction: TextInputAction.done,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
        controller: _passwordController,
        validator: (String? value) {
          //need some work when implementing firbase
          if (value == null || value.isEmpty) {
            return 'Le mot de passe est obligatoire';
          }
          return null;
        },
      ),
    );
  }
}

class SearchInputWidget extends StatelessWidget {
  const SearchInputWidget({Key? key,required this.provider}) : super(key: key);
  final provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        border: Border.all(),
      ),
      child: TextField(
        onChanged : (value){
          provider.changeSearchKey(value);
        },
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric( vertical: 8,horizontal: 16),
          border: InputBorder.none,
          suffixIcon: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {},
          ),
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.none,
        autocorrect: false,
      ),
    );
  }
}


class TextInputWidget extends StatelessWidget {

  const TextInputWidget({
    Key? key,
    required TextEditingController textController,required this.hint, this.isArea = false,
  })  : _textController = textController,
        super(key: key);

  final TextEditingController _textController;
  final String hint;
  final bool isArea;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      // height: isArea ? 50 * 3: 50,
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(),
      ),
      child: TextFormField(
        decoration:  InputDecoration(
          hintStyle: kbody,
          contentPadding: const EdgeInsets.symmetric(vertical: 8,horizontal: 16),
          hintText: hint,
          border: InputBorder.none,
        ),
        keyboardType: isArea ? TextInputType.multiline : TextInputType.text,
        maxLines: isArea ? 4 : 1,
        textInputAction: TextInputAction.next,
        autocorrect: false,
        controller: _textController,
        validator: (String? value) {
          if (value == null || value.isEmpty) {
            return "Ce champ est obligatoire";
          }
          return null;
        },
      ),
    );
  }
}

