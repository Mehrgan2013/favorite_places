import 'dart:io';
import 'package:favorite_places/pviders/user_Places.dart';
import 'package:favorite_places/screens/add_location.dart';
import 'package:favorite_places/widgets/image_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddPlaceScreen extends ConsumerStatefulWidget {
  const AddPlaceScreen({super.key});
//
  @override
  ConsumerState<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends ConsumerState<AddPlaceScreen> {
  final _titleControler = TextEditingController();
  File? _image;
  // ******************** */
//File? _selectedImage;
  //************************ */

  void _tackeImage(File? image) {
    _image = image!;
  }

  void savePlace() {
    final enteredTitle = _titleControler.text;

    //***************************** */
    //  if (enteredTitle.isEmpty || _image == null) {
    if (enteredTitle.isEmpty || _image == null) {
      return;
    }
    ref.read(userPlacesProvider.notifier).addPlace(enteredTitle, _image);
    Navigator.of(context).pop();
  }

  @override
  void dispose() {
    super.dispose();
    _titleControler.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a new Place'),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(labelText: 'Title'),
                controller: _titleControler,
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onBackground),
                // style: Theme.of(context).textTheme.titleMedium!.copyWith(
                //     color: Theme.of(context).colorScheme.onBackground),
              ),
              const SizedBox(height: 20),
              //Image Input
              ImageInput(onPickImage: _tackeImage),
              //*************************** */
              //ImageInput(onPickImage: (image){_selectedImage=image;}),
              //***************************** */
              const SizedBox(height: 20),
              LocationInput(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  //const SizedBox.expand(), // so wrong
                  TextButton(
                      onPressed: //_isSending
                          // ? null
                          // :
                          () {
                        //  _formKey.currentState!.reset();
                      },
                      child: const Text('Reset')),
                  ElevatedButton.icon(
                      onPressed: () {
                        savePlace();
                      },
                      // _isSending ? null : savePlace(),
                      icon: const Icon(Icons.add),
                      label: //_isSending
                          //?
                          //const SizedBox(
                          // height: 16,
                          //width: 16,
                          //  child: CircularProgressIndicator())
                          //:
                          const Text('Add Place'))
                ],
              )
            ],
          ),
        ));
  }
}
