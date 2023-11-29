import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  Function (String text) onSearch;
  TextEditingController searchController;
   Search({Key? key, required this.searchController, required this.onSearch}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.searchController,
      onChanged:  widget.onSearch,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 12,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        filled: true,
        fillColor: Colors.grey.shade800,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(
            color: Colors.transparent,
          ),
        ),
        hintText: "Search notes...",
        hintStyle: const TextStyle(color: Colors.grey),
      ),
    );
  }
}
