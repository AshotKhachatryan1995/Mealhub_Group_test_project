import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/details_bloc/details_bloc.dart';
import '../blocs/details_bloc/details_event.dart';
import '../blocs/details_bloc/details_state.dart';
import '../middleware/models/user.dart';
import '../middleware/repositories/api_repository_impl.dart';
import '../shared/navigation_widget.dart';

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

  User? _user;

  @override
  void initState() {
    super.initState();
    _detailsBloc = DetailsBloc(ApiRepositoryImpl())
      ..add(LoadUserEvent())
      ..add(LoadPhotosEvent());
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
    _user = user;
    _nameController.text = user.name;
    _emailController.text = user.email;
    _phoneController.text = user.phone;
    _locationController.text = user.address.city + user.address.street;

    return Padding(
        padding: const EdgeInsets.all(20),
        child: Stack(children: [
          Column(children: [
            _renderDetailsItem(rowName: 'Name', controller: _nameController),
            _renderDetailsItem(rowName: 'Email', controller: _emailController),
            _renderDetailsItem(rowName: 'Phone', controller: _phoneController),
            _renderDetailsItem(
                rowName: 'Location', controller: _locationController),
          ]),
          _renderPhotoCarousel(),
          Positioned.fill(
              child: ValueListenableBuilder(
                  valueListenable: _isEditMode,
                  builder: (context, bool isEditMode, child) => isEditMode
                      ? Align(
                          alignment: Alignment.bottomCenter,
                          child: TextButton(
                              onPressed: _onSaveDetails,
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

  Widget _renderDetailsItem(
      {required String rowName, required TextEditingController controller}) {
    return Row(children: [
      Text('$rowName: '),
      const SizedBox(width: 20),
      Expanded(
          child: ValueListenableBuilder(
              valueListenable: _isEditMode,
              builder: (context, bool isEditMode, child) => TextFormField(
                  controller: controller,
                  readOnly: !isEditMode,
                  decoration: const InputDecoration(border: InputBorder.none))))
    ]);
  }

  Widget _renderPhotoCarousel() {
    return Positioned.fill(
        child: Align(
            child: CarouselSlider(
      options: CarouselOptions(height: 200.0),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.amber),
                child: Text(
                  'text $i',
                  style: const TextStyle(fontSize: 16.0),
                ));
          },
        );
      }).toList(),
    )));
  }
}

extension _DetailsScreenStateAddition on _DetailsScreenState {
  void _onEditTap() {
    _isEditMode.value = !_isEditMode.value;

    _resetDetails();
  }

  void _resetDetails() {
    _nameController.text = _user?.name ?? '';
    _emailController.text = _user?.email ?? '';
    _phoneController.text = _user?.phone ?? '';
    _locationController.text =
        (_user?.address.city ?? '') + (_user?.address.street ?? '');
  }

  void _onSaveDetails() {
    _isEditMode.value = false;
    final user = _user;

    if (user != null) {
      _detailsBloc.add(SaveDetailsEvent(
          user: user.userFromController(
              nameOfUser: _nameController.text,
              emailOfUser: _emailController.text,
              phoneOfUser: _phoneController.text)));
    }
  }
}

extension _UserAddition on User {
  User userFromController(
          {required String nameOfUser,
          required String emailOfUser,
          required String phoneOfUser}) =>
      User(
          id: id,
          name: nameOfUser,
          username: username,
          email: emailOfUser,
          address: address,
          phone: phoneOfUser,
          website: website,
          company: company);
}
