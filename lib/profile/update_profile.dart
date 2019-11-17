import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_alert/flutter_alert.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hosrem_app/api/auth/degree.dart';
import 'package:hosrem_app/api/auth/field.dart';
import 'package:hosrem_app/api/auth/user.dart';
import 'package:hosrem_app/auth/auth_service.dart';
import 'package:hosrem_app/common/app_colors.dart';
import 'package:hosrem_app/common/base_state.dart';
import 'package:hosrem_app/common/date_time_utils.dart';
import 'package:hosrem_app/common/text_styles.dart';
import 'package:hosrem_app/profile/bloc/profile_update_bloc.dart';
import 'package:hosrem_app/profile/bloc/profile_update_event.dart';
import 'package:hosrem_app/profile/bloc/profile_update_state.dart';
import 'package:hosrem_app/profile/degree_service.dart';
import 'package:hosrem_app/profile/field_service.dart';
import 'package:hosrem_app/widget/button/primary_button.dart';
import 'package:hosrem_app/widget/dialog/multi_select_dialog.dart';
import 'package:hosrem_app/widget/dialog/multi_select_dialog_item.dart';
import 'package:hosrem_app/widget/text/edit_text_field.dart';
import 'package:hosrem_app/widget/text/static_multiple_text_field.dart';
import 'package:hosrem_app/widget/text/static_text_field.dart';
import 'package:loading_overlay/loading_overlay.dart';

/// Update profile page.
@immutable
class UpdateProfile extends StatefulWidget {
  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends BaseState<UpdateProfile> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<MultiSelectDialogItem<String>> _degreeItems = <MultiSelectDialogItem<String>>[];
  final List<MultiSelectDialogItem<String>> _fieldItems = <MultiSelectDialogItem<String>>[];
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _workingPlaceController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _fieldController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  final Set<String> _selectedDegrees = {};
  final Set<String> _selectedFields = {};
  List<Degree> lstDegrees = <Degree>[];
  List<Field> lstFields = <Field>[];
  String degrees = '';
  List<String> fields = <String>[];
  ProfileUpdateBloc _profileUpdateBloc;
  int _index = 0;
  bool inited = false;
  bool _validFullName = true;
  bool _validEmail = true;
  User _user;
  @override
  void initState() {
    super.initState();

    _profileUpdateBloc = ProfileUpdateBloc(authService: AuthService(apiProvider),
        degreeService: DegreeService(apiProvider), fieldService: FieldService(apiProvider));
    _profileUpdateBloc.dispatch(LoadProfileEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProfileUpdateBloc>(
      builder: (BuildContext context) => _profileUpdateBloc,
      child: BlocListener<ProfileUpdateBloc, ProfileUpdateState>(
        listener: (BuildContext context, ProfileUpdateState state) {
          if (state is ProfileFailure) {
            _scaffoldKey.currentState.showSnackBar(
              SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is UpdateProfileSuccess) {
            _showUpdateSuccessDialog();
          }
        },
        child: BlocBuilder<ProfileUpdateBloc, ProfileUpdateState>(
          bloc: _profileUpdateBloc,
          builder: (BuildContext context, ProfileUpdateState state) {
            if (state is ProfileDataUpdate) {
              _user = state.user;
              if (!inited) {
                _emailController.text = state.user.email;
                _fullNameController.text = state.user.fullName;
                _addressController.text = state.user.address;
                _workingPlaceController.text = state.user.company;
                _positionController.text = state.user.position;
                _departmentController.text = state.user.department;
              }
              _birthdayController.text = _user.dob != null ? DateTimeUtils.formatAsStandard(_user.dob) : '';
              if (state.degrees != null && state.degrees.isNotEmpty && _degreeItems.isEmpty) {
                  for(int i = 0; i < state.degrees.length; i++){
                    _degreeItems.add(MultiSelectDialogItem<String>(state.degrees[i].id, state.degrees[i].name));
                  }
                }
              if (state.fields != null && state.fields.isNotEmpty && _fieldItems.isEmpty) {
                for(int i = 0; i < state.fields.length; i++){
                  _fieldItems.add(MultiSelectDialogItem<String>(state.fields[i].id, state.fields[i].name));
                }
              }
              fields.clear();
              lstDegrees = state.user.degrees;
              lstFields = state.user.fields;
              // init degrees
              if (lstDegrees != null && lstDegrees.isNotEmpty) {
                degrees = lstDegrees?.map((Degree degree) {
                  _selectedDegrees.add(degree.id);
                  return degree.name;
                })?.join(', ');
                _degreeController.text = '${lstDegrees.length.toString()} ${AppLocalizations.of(context).tr('my_profile.selected')}';
              } else {
                _degreeController.text = '0 ${AppLocalizations.of(context).tr('my_profile.selected')}';
              }
              // init fields
              if (lstFields != null && lstFields.isNotEmpty) {
                for(int i = 0; i < lstFields.length; i++){
                  _selectedFields.add(lstFields[i].id);
                  fields.add(lstFields[i].name);
                }
                _fieldController.text = '${lstFields.length.toString()} ${AppLocalizations.of(context).tr('my_profile.selected')}';
              } else {
                _fieldController.text = '0 ${AppLocalizations.of(context).tr('my_profile.selected')}';
              }
              inited = true;
            }
            return Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(AppLocalizations.of(context).tr('my_profile.my_profile')),
                centerTitle: true
              ),
              body: LoadingOverlay(
                isLoading: state is ProfileLoading,
                child: Stack(
                  children: <Widget>[
                    Stepper(
                      type: StepperType.horizontal,
                      steps: <Step>[
                        Step(
                          title: const Text(''),
                          isActive: _index == 0,
                          content: buildFirstStep(state),
                        ),
                        Step(
                          title: const Text(''),
                          isActive: _index == 1,
                          content: buildSecondStep(state),
                        ),
                        Step(
                          title: const Text(''),
                          isActive: _index == 2,
                          content: buildThirdStep(state),
                        ),
                      ],
                      currentStep: _index,
                      onStepTapped: (int index) {
                        if (_validateRegisterForm()) {
                          setState(() {
                            _index = index;
                          });
                        }
                      },
                      controlsBuilder: (BuildContext context,
                        {VoidCallback onStepContinue, VoidCallback onStepCancel}) => Container(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                          const Divider(),
                          Container(
                            color: AppColors.backgroundConferenceColor,
                            padding: const EdgeInsets.fromLTRB(27.0, 20.0, 27.0, 12.0),
                            child: Column(children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: _index < 2 ? PrimaryButton(
                                      text: AppLocalizations.of(context).tr('my_profile.next'),
                                      fontSize: 16.0,
                                      onPressed: () => _onNextPress(),
                                    ) : PrimaryButton(
                                      text: AppLocalizations.of(context).tr('my_profile.save'),
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                      onPressed: _onSaveButtonPressed,
                                    )
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8.0),
                              Material(
                                child: InkWell(
                                  onTap: () {
                                    _onBackPress();
                                  },
                                  child: Text(
                                    AppLocalizations.of(context).tr('my_profile.back'),
                                    style: TextStyles.textStyle11PrimaryBlueBold,
                                  ),
                                ),
                              ),
                            ],),
                          ),
                        ],)
                      ),
                    )
                  ]
                ),
              ),
            );
          }
        )
      )
    );
  }

  Widget buildFirstStep(ProfileUpdateState state) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: EditTextField(
                title: AppLocalizations.of(context).tr('registration.member_name'),
                hint: AppLocalizations.of(context).tr('registration.full_name_hint'),
                error: _validFullName ? null : AppLocalizations.of(context).tr('registration.full_name_is_required'),
                onTextChanged: (String value) => setState(() => _validFullName = value.isNotEmpty),
                controller: _fullNameController,
              )
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        InkWell(
          onTap: () {
            _selectDate(state);   // Call Function that has showDatePicker()
          },
          child: IgnorePointer(
            child: EditTextField(
              title: AppLocalizations.of(context).tr('registration.birthday'),
              hint: AppLocalizations.of(context).tr('registration.birthday_hint'),
              controller: _birthdayController,
            )
          ),
        ),
        const SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            Expanded(
              child: EditTextField(
                title: AppLocalizations.of(context).tr('registration.address'),
                hint: AppLocalizations.of(context).tr('registration.address_hint'),
                controller: _addressController,
                line: 2,
              )
            ),
          ],
        ),
        Row(
          children: <Widget>[
            Expanded(
              child: EditTextField(
                title: AppLocalizations.of(context).tr('registration.email'),
                hint: AppLocalizations.of(context).tr('registration.email_hint'),
                error: _validEmail ? null : AppLocalizations.of(context).tr('registration.email_is_required'),
                onTextChanged: (String value) => setState(() => _validEmail = value.isNotEmpty),
                controller: _emailController,
                enabled: false
              )
            ),
          ],
        ),
        const SizedBox(height: 150.0),
      ]
    );
  }

  Widget buildSecondStep(ProfileUpdateState state) {
    return Column (
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              child: EditTextField(
                title: AppLocalizations.of(context).tr('registration.working_place'),
                hint: AppLocalizations.of(context).tr('registration.working_place_hint'),
                controller: _workingPlaceController,
              )
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            Expanded(
              child: EditTextField(
                title: AppLocalizations.of(context).tr('registration.position'),
                hint: AppLocalizations.of(context).tr('registration.position_hint'),
                controller: _positionController,
              )
            ),
          ],
        ),
        const SizedBox(height: 20.0),
        Row(
          children: <Widget>[
            Expanded(
              child: EditTextField(
                title: AppLocalizations.of(context).tr('registration.department'),
                hint: AppLocalizations.of(context).tr('registration.department_hint'),
                controller: _departmentController,
              )
            ),
          ],
        ),
        const SizedBox(height: 150.0),
      ],
    );
  }

  Widget buildThirdStep(ProfileUpdateState state) {
    return Column (
      children: <Widget>[
        InkWell(
          onTap: () {
            _showDegreeSelect(context, _degreeItems, state);   // Call Function that has select()
          },
          child: IgnorePointer(
            child: EditTextField(
              title: AppLocalizations.of(context).tr('registration.degree'),
              hint: AppLocalizations.of(context).tr('registration.degree_hint'),
              controller: _degreeController,
            )
          ),
        ),
        const SizedBox(height: 16.0),
        StaticTextField('', degrees),
        const SizedBox(height: 28.0),
        InkWell(
          onTap: () {
            _showFieldSelect(context, _fieldItems, state);   // Call Function that has select()
          },
          child: IgnorePointer(
            child: EditTextField(
              title: AppLocalizations.of(context).tr('registration.field'),
              hint: AppLocalizations.of(context).tr('registration.field_hint'),
              controller: _fieldController,
            )
          ),
        ),
        const SizedBox(height: 20.0),
        StaticMultipleTextField (
          '',
          fields ?? <String>[]
        ),
        SizedBox(height: fields.length * 32.0),
      ],
    );
  }

  void _showUpdateSuccessDialog() {
    showAlert(
      context: context,
      body: AppLocalizations.of(context).tr('my_profile.your_profile_updated'),
      actions: <AlertAction>[
        AlertAction(text: 'OK', onPressed: () => Navigator.pop(context))
      ]
    );
  }

  Future<Null> _selectDate(ProfileDataUpdate state) async {
      final DateTime picked = await showDatePicker(
          context: context,
          initialDate: state.user.dob ?? DateTime.now(),
          firstDate: DateTime(1900),
          lastDate: DateTime.now()
      );

      _profileUpdateBloc.dispatch(ChangeProfileEvent(state.user.copyWith(dob: picked)));
  }

  Future<void> _showDegreeSelect(BuildContext context, List<MultiSelectDialogItem<String>> items, ProfileDataUpdate state) async {
    final Set<String> selectedDegrees = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return MultiSelectDialog<String> (
          items: items,
          initialSelectedValues: _selectedDegrees,
        );
      },
    );
    if(selectedDegrees != null) {
      _selectedDegrees.clear();
      lstDegrees.clear();
      for(int i = 0; i < _degreeItems.length; i++){
        if (selectedDegrees.contains(_degreeItems[i].value)) {
          lstDegrees.add(Degree(_degreeItems[i].value, _degreeItems[i].label));
        }
      }
      _profileUpdateBloc.dispatch(ChangeProfileEvent(state.user.copyWith(degrees: lstDegrees)));
    }
  }

  Future<void> _showFieldSelect(BuildContext context, List<MultiSelectDialogItem<String>> items, ProfileDataUpdate state) async {
    final Set<String> selectedFields = await showDialog<Set<String>>(
      context: context,
      builder: (BuildContext context) {
        return  MultiSelectDialog<String> (
          items: items,
          initialSelectedValues: _selectedFields,
        );
      },
    );
    if(selectedFields != null) {
      _selectedFields.clear();
      lstFields.clear();
      for(int i = 0; i < _fieldItems.length; i++){
        if (selectedFields.contains(_fieldItems[i].value)) {
          lstFields.add(Field(_fieldItems[i].value, _fieldItems[i].label, null));
        }
      }
      _profileUpdateBloc.dispatch(ChangeProfileEvent(state.user.copyWith(fields: lstFields)));
    }
  }

  bool _validateRegisterForm() {
    if (_index ==  0 || _index ==  3) {
      if (_fullNameController.text.isEmpty) {
        return false;
      }
      if (_emailController.text.isEmpty) {
        return false;
      }
    }
    return true;
  }

  void _onNextPress() {
    if (_validateRegisterForm()) {
      if (_index < 2) {
        setState(() {
          _index = _index + 1;
        });
      }
    }
  }

  void _onBackPress() {
    if (_validateRegisterForm()) {
      if (_index > 0) {
        setState(() {
          _index = _index - 1;
        });
      }
    }
  }

  void _onSaveButtonPressed() {
    if (_validateRegisterForm()) {
      final String email = _emailController.text;
      final String fullName = _fullNameController.text;
      final DateTime birthday = _birthdayController.text.isNotEmpty ? DateTimeUtils.parseDate(_birthdayController.text) : null;
      final String address = _addressController.text;
      final String department = _departmentController.text;
      final String workingPlace = _workingPlaceController.text;
      final String position = _positionController.text;
      final List<Degree> degrees = <Degree> [];
      final List<Field> fields = <Field> [];
      for(int i = 0; i < _degreeItems.length; i++){
        if (_selectedDegrees.contains(_degreeItems[i].value)) {
          degrees.add(Degree(_degreeItems[i].value, _degreeItems[i].label));
        }
      }
      for(int i = 0; i < _fieldItems.length; i++){
        if (_selectedFields.contains(_fieldItems[i].value)) {
          fields.add(Field(_fieldItems[i].value, _fieldItems[i].label, ''));
        }
      }
      final User user = _user.copyWith(
        email: email,
        fullName: fullName,
        dob: birthday,
        address: address,
        company: workingPlace,
        department: department,
        position: position,
        degrees: degrees,
        fields: fields,
      );

      _profileUpdateBloc.dispatch(SaveProfileEvent(user));
    }
  }

  @override
  void dispose() {
    _profileUpdateBloc.dispose();
    super.dispose();
  }
}

