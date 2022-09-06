import 'package:mealhub_group_test_project/blocs/details_bloc/details_bloc.dart';
import 'package:mealhub_group_test_project/blocs/details_bloc/details_event.dart';
import 'package:mealhub_group_test_project/blocs/details_bloc/details_state.dart';
import 'package:mealhub_group_test_project/middleware/models/user.dart';
import 'package:mealhub_group_test_project/middleware/repositories/api_repository_impl.dart';
import 'package:mealhub_group_test_project/shared/navigation_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  late DetailsBloc _detailsBloc;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final ValueNotifier<bool> _isEditMode = ValueNotifier(false);

  @override
  void initState() {
    super.initState();
    _detailsBloc = DetailsBloc(ApiRepositoryImpl())..add(LoadUserEvent());
  }

  @override
  void dispose() {
    _detailsBloc.close();
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _locationController.dispose();
    _isEditMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (_) => _detailsBloc,
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Column(children: [
              NavigationWidget(title: 'User Details', child: _renderEditIcon()),
              Expanded(child: _render()),
            ])));
  }

  Widget _render() {
    return BlocBuilder<DetailsBloc, DetailsState>(builder: (context, state) {
      if (state is UserLoadedState) {
        return _renderDeatils(user: state.user);
      }

      if (state is UserNotLoadedState) {
        Navigator.pop(context);
      }

      return const Align(
          child: CircularProgressIndicator(
        color: Colors.black,
        strokeWidth: 2,
      ));
    });
  }

  Widget _renderEditIcon() {
    return ValueListenableBuilder(
        valueListenable: _isEditMode,
        builder: (context, bool isEditMode, child) {
          return GestureDetector(
              onTap: _onEditTap,
              child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.all(10),
                  decoration: isEditMode
                      ? BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  spreadRadius: 2,
                                  offset: const Offset(-2, -2),
                                  blurRadius: 1)
                            ])
                      : null,
                  child: const Icon(Icons.edit)));
        });
  }

  Widget _renderDeatils({required User user}) {
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _locationController.text = user.address.city + user.address.street;

    return Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(children: [
          Column(children: [
            Row(children: [
              const Text('Name: '),
              const SizedBox(
                width: 20,
              ),
              _renderTextField(_nameController)
            ]),
            Row(children: [
              const Text('Email: '),
              const SizedBox(width: 20),
              _renderTextField(_emailController)
            ]),
            Row(children: [
              const Text('Phone: '),
              const SizedBox(width: 20),
              _renderTextField(_phoneController)
            ]),
            Row(children: [
              const Text('Location: '),
              const SizedBox(width: 20),
              _renderTextField(_locationController)
            ]),
          ]),
          Positioned.fill(
              child: ValueListenableBuilder(
                  valueListenable: _isEditMode,
                  builder: (context, bool isEditMode, child) => isEditMode
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              onPressed: () {},
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey),
                                child: const Text('Save Changes',
                                    style: TextStyle(color: Colors.white)),
                              )))
                      : const SizedBox()))
        ]));
  }

  Widget _renderTextField(TextEditingController controller) {
    return Expanded(
        child: ValueListenableBuilder(
            valueListenable: _isEditMode,
            builder: (context, bool isEditMode, child) => TextFormField(
                controller: controller,
                readOnly: !isEditMode,
                decoration: const InputDecoration(border: InputBorder.none))));
  }

  void _onEditTap() {
    _isEditMode.value = !_isEditMode.value;
  }
}
