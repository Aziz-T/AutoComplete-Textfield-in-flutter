import 'package:flutter/material.dart';

class AutoCompleteTextfield extends StatefulWidget {
  const AutoCompleteTextfield({Key? key, required this.textEditingController}) : super(key: key);
  final TextEditingController textEditingController;
  @override
  _AutoCompleteTextfieldState createState() => _AutoCompleteTextfieldState();
}

class _AutoCompleteTextfieldState extends State<AutoCompleteTextfield> {

  bool isLoading = false;

  late List<String> autoCompleteData;

  late TextEditingController controller;



  Future fetchAutoCompleteData() async {
    autoCompleteData = [];
    setState(() {
      isLoading = true;
    });


    setState(() {
      isLoading = false;
      autoCompleteData.add("Aziz");
      autoCompleteData.add("Ali");
      autoCompleteData.add("Burak");
      autoCompleteData.add("Çağıl");
      autoCompleteData.add("Enis");
      autoCompleteData.add("Karı");
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = widget.textEditingController;
    fetchAutoCompleteData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container ( child:  isLoading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Autocomplete(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<String>.empty();
                } else {
                  return autoCompleteData.where((word) => word
                      .toLowerCase()
                      .contains(textEditingValue.text.toLowerCase()));
                }
              },
              optionsViewBuilder:
                  (context, Function(String) onSelected, options) {
                return Container(
                 // height: size.height ,

                  child: Material(
                    elevation: 4,
                    child: ListView.separated(
                      padding: EdgeInsets.zero,
                      itemBuilder: (context, index) {
                        final option = options.elementAt(index);

                        return ListTile(
                           title: Text(option.toString()),
                        /*  title: SubstringHighlight(
                            text: option.toString(),
                            term: controller.text,
                            textStyleHighlight: TextStyle(fontWeight: FontWeight.w700),
                          ),*/
                          subtitle: Text("This is subtitle"),
                          onTap: () {
                            onSelected(option.toString());
                          },
                        );
                      },
                      separatorBuilder: (context, index) => Divider(),
                      itemCount: options.length,
                    ),
                  ),
                );
              },
              onSelected: (selectedString) {
                print("selected"+selectedString.toString());
                setState(() {
                  widget.textEditingController.text = selectedString.toString();
                });
              },
              fieldViewBuilder:
                  (context, controller, focusNode, onEditingComplete) {
                this.controller = controller;

                return TextField(
                  controller: controller,
                  focusNode: focusNode,
                  onEditingComplete: onEditingComplete,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    hintText: "Search Something",
                    labelText: "İsim"
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
