import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../view_model/add_shop_vm/pickImage_vm.dart';
import '../../view_model/entry_view_model.dart';
import '../../widgets/add_shop/pickImage_widget.dart';
import '../../widgets/custom_textfield.dart';
class Registration extends StatefulWidget {
  final String title;
  final String? nameCtrl;
  final String? famCtrl;
  final String buttonTitle;
  final VoidCallback onPressed;
  final String? image;
  const Registration({
    Key? key,
    required this.title,
    this.nameCtrl,
    this.famCtrl,
    required this.onPressed,
    required this.buttonTitle,
    this.image,
  }) : super(key: key);

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  @override
  void initState() {
    super.initState();
    final provider = Provider.of<EntryPageVM>(context, listen: false);
    if (widget.famCtrl != null && widget.nameCtrl != null) {
      provider.famController.text = widget.famCtrl!;
      provider.nameController.text = widget.nameCtrl!;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<EntryPageVM>(context, listen: true);
    return Scaffold(
      body: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.title,
                style: Theme.of(context)
                    .textTheme
                    .headline1
                    ?.copyWith(fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 35),
              PickImageTile(
                onPressed: () {
                  context.read<PickImageVM>().pickImagePerson();
                },
                title: 'Profil rasmi',
                image: context.watch<PickImageVM>().imagePerson,
              ),
              const SizedBox(height: 40),
              CustomTextfield(
                hintText: 'Ism',
                controller: provider.nameController,
                validator: (input) =>
                    input!.isEmpty ? 'Ismizni kiriting' : null,
              ),
              const SizedBox(height: 20),

              //familya
              CustomTextfield(
                hintText: 'Familiya',
                controller: provider.famController,
                validator: (input) =>
                    input!.isEmpty ? 'Familyangizni kiriting' : null,
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              TextButton(
                onPressed: widget.onPressed,
                style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 10),
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                        side: const BorderSide(
                            color: Colors.white,
                            width: 0.6,
                            style: BorderStyle.solid))),
                child: !provider.isLoading
                    ? Text(
                        widget.buttonTitle,
                        style:
                            const TextStyle(fontSize: 28, color: Colors.white),
                      )
                    : const CircularProgressIndicator(
                        color: Colors.white,
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
