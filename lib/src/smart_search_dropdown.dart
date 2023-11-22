import 'package:flutter/material.dart';

//ignore: must_be_immutable
class SmartSearchDropdown extends StatefulWidget {
  final String labelText;
  final Color labelColor;
  final Color? iconsColor;
  final Widget notFoundWidget;
  final Color hintColor;
  final Color backgroundColor;
  final Color selectedItemColor;
  final bool isLoading;
  final double fontSize;
  final double borderRadius;
  final bool enableSearching;
  late TextEditingController controller;
  final List<SmartSearchDropdownItem> items;
  late String selectedItem;
  final void Function(SmartSearchDropdownItem)? onItemSelected;

  SmartSearchDropdown({
    Key? key,
    this.enableSearching = false,
    this.fontSize = 13,
    this.labelText = 'Search',
    this.labelColor = Colors.black45,
    this.hintColor = Colors.black45,
    this.notFoundWidget = const Text('Not Found'),
    this.iconsColor,
    this.backgroundColor = Colors.white,
    this.selectedItemColor = Colors.blue,
    required this.controller,
    required this.items,
    required this.selectedItem,
    this.onItemSelected,
    this.isLoading = false,
    this.borderRadius = 4,
  }) : super(key: key);

  @override
  SmartSearchDropdownState createState() => SmartSearchDropdownState();
}

class SmartSearchDropdownState extends State<SmartSearchDropdown> {
  bool dropDownIsShown = false;
  List<SmartSearchDropdownItem> combinedListArticles = [];
  List<SmartSearchDropdownItem> myItems = [];
  int selectedIndex = 0;
  @override
  void initState() {
    myItems = widget.items;
    combinedListArticles = widget.items;
    selectedIndex =
        myItems.indexWhere((item) => item.value == widget.selectedItem);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    double height = MediaQuery.sizeOf(context).height;
    selectedIndex = selectedIndex =
        myItems.indexWhere((item) => item.value == widget.selectedItem);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: TextField(
            onTap: () {
              if (!widget.enableSearching) {
                dropDownIsShown = !dropDownIsShown;
                setState(() {});
              }
            },
            readOnly: !widget.enableSearching,
            enabled: widget.isLoading == true ? false : true,
            controller: widget.controller,
            onChanged: (val) {
              if (val.isNotEmpty) {
                _search(val);
              } else {
                setState(() {
                  widget.controller.clear();
                  dropDownIsShown = true;
                  myItems = widget.items;
                });
              }
            },
            decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search, color: Colors.black45),
              labelText: widget.labelText,
              labelStyle: TextStyle(color: widget.labelColor),
              hintStyle: TextStyle(color: widget.hintColor),
              border: const OutlineInputBorder(),
              suffixIcon: widget.isLoading == true
                  ? const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: CircularProgressIndicator(
                        strokeWidth: 0.9,
                      ),
                    )
                  : dropDownIsShown
                      ? IconButton(
                          icon: Icon(
                            Icons.arrow_circle_up_outlined,
                            color:
                                widget.iconsColor ?? widget.selectedItemColor,
                          ),
                          onPressed: () {
                            setState(() {
                              dropDownIsShown = false;
                            });
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            Icons.expand_circle_down_outlined,
                            color:
                                widget.iconsColor ?? widget.selectedItemColor,
                          ),
                          onPressed: () {
                            setState(() {
                              dropDownIsShown = true;
                            });
                          },
                        ),
            ),
          ),
        ),
        Visibility(
          visible: dropDownIsShown,
          child: Container(
            margin:
            const EdgeInsets.only(left: 4, right: 4, bottom: 5, top: 10),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurStyle: BlurStyle.outer,
                  blurRadius: widget.borderRadius,
                ),
              ],
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(4),
            ),
            height: myItems.isNotEmpty
                ? (myItems.length * 55 <= height * 0.325
                ? myItems.length == 1
                ? myItems.length * 68
                : myItems.length * 65
                : height * 0.325)
                : null,
            child: myItems.isEmpty
                ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Not Found'),
                ))
                : ListView.builder(
              padding: const EdgeInsets.only(top: 7),
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: myItems.length,
              itemBuilder: (context, index) {
                var item = myItems[index];
                return InkWell(
                  onTap: () {
                    if (widget.onItemSelected != null) {
                      widget.onItemSelected!(item);
                    }
                    widget.selectedItem = item.value;
                    widget.controller.text = item.description;
                    selectedIndex = index;
                    dropDownIsShown = false;
                    setState(() {});
                  },
                  child: Container(
                    width: width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 5, vertical: 1),
                    decoration: BoxDecoration(
                      //border: Border.all(color: widget.selectedItemColor.withOpacity(0.5),width: 0.5),
                      borderRadius: BorderRadius.circular(4),
                      color: selectedIndex == index
                          ? widget.selectedItemColor
                          : Colors.transparent,
                    ),
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      item.description,
                      style: TextStyle(
                        fontSize: widget.fontSize,
                        overflow: TextOverflow.ellipsis,
                        color: selectedIndex == index
                            ? Colors.white
                            : Colors.black87,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _search(String query) async {
    if (query.isEmpty) {
      setState(() {
        myItems = widget.items;
      });
    } else {
      List<SmartSearchDropdownItem> dataFilter = widget.items
          .where((data) =>
              data.value
                  .toString()
                  .toLowerCase()
                  .contains(query.toString().toLowerCase()) ||
              data.description
                  .toString()
                  .toLowerCase()
                  .contains(query.toLowerCase()))
          .toList();
      setState(() {
        myItems = dataFilter;
      });
    }
  }
}

class SmartSearchDropdownItem {
  final String value;
  final String description;

  SmartSearchDropdownItem({
    required this.value,
    required this.description,
  });
}
