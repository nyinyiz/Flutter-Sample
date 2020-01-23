
import 'package:cupertino_app/product_row_item.dart';
import 'package:cupertino_app/search_bar.dart';
import 'package:cupertino_app/styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'model/app_state_model.dart';
import 'search_bar.dart';

class SearchTab extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() {
    return SearchTabState();
  }
}

class SearchTabState extends State<SearchTab> {

  TextEditingController _controller;
  FocusNode _focusNode;
  String _terms = '';

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController()..addListener(_onTextChanged);
    _focusNode = FocusNode();

  }

  @override
  void dispose() {
    _focusNode.dispose();
    _controller.dispose();
    super.dispose();

  }

  void _onTextChanged() {
    setState(() {
      _terms = _controller.text;
    });
  }

  Widget _buildSearchBox() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: SearchBar(
        controller : _controller,
        focusNode : _focusNode
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
  final model = Provider.of<AppStateModel>(context);
  final results = model.search(_terms);

    return DecoratedBox(
      decoration: const BoxDecoration(
        color: Styles.scaffoldBackground,
      ),
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _buildSearchBox(),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) => ProductRowItem(
                  index: index,
                  product: results[index],
                  lastItem: index == results.length -1,
                ),
                itemCount: results.length,
              ),
            )
          ],
        ),
      ),
    );
  }
  
}