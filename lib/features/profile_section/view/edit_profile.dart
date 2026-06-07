import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zeggo_cus/constants/app_colors.dart';
import 'package:zeggo_cus/constants/app_toast.dart';
import 'package:zeggo_cus/features/home_screen/screen/home_screen.dart';
import 'package:zeggo_cus/features/profile_section/bloc/get_profile/get_profile_cubit.dart';
import 'package:zeggo_cus/features/profile_section/bloc/update_profile/update_profile_cubit.dart';
import 'package:zeggo_cus/utils/storage/storage.dart';

class EditProfileScreen extends StatefulWidget {
  final bool isFirstTimeUser;
  const EditProfileScreen({super.key, required this.isFirstTimeUser});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _referralController = TextEditingController();
  File? _profileImage;

  final ImagePicker _picker = ImagePicker();
  XFile? image;
  Future<void> _pickImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _profileImage = File(image?.path ?? "");
      });
    }
  }

  void _submit() {
    if (_nameController.text.trim().isEmpty) {
      AppToast.showError(context, "Error", "Name is required");
      return;
    }
    if (widget.isFirstTimeUser && image == null) {
      AppToast.showError(context, "", "Upload Profile Image");
      return;
    }
    context.read<UpdateProfileCubit>().updateProfile(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      profilePicture: _profileImage,
      firstTimeUser: false,
      mobileNumber: _mobileController.text.trim(),
    );
  }

  @override
  void initState() {
    context.read<GetProfileCubit>().getProfile();
    _loadReferralCode();
    super.initState();
  }

  void _loadReferralCode() async {
    final code = await LocalStorageUtils.getReferralCode();
    if (code != null) {
      setState(() {
        _referralController.text = code;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
      ),
      body: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
        listener: (context, state) {
          if (state is UpdateProfileErrorState) {
            AppToast.showError(context, "Error", state.error);
          }

          if (state is UpdateProfileLoadedState) {
            AppToast.showSuccess(
              context,
              "Success",
              "Profile updated successfully",
            );
            context.read<GetProfileCubit>().getProfile();
            if (widget.isFirstTimeUser) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
                (route) => false,
              );
            } else {
              Navigator.pop(context);
            }
          }
        },
        builder: (context, state) {
          return BlocListener<GetProfileCubit, GetProfileState>(
            listener: (context, state) {
              if (state is GetProfileErrorState) {
                AppToast.showError(context, "", state.error);
                return;
              }
              if (state is GetProfileLoadedState) {
                _nameController.text = state.model.data?.name ?? "";
                _mobileController.text = state.model.data?.phoneNo ?? "";
                _emailController.text = state.model.data?.email ?? "";
              }
            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : null,
                          child: _profileImage == null
                              ? const Icon(Icons.person, size: 55)
                              : null,
                        ),
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  TextField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: "Email",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _mobileController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      LengthLimitingTextInputFormatter(10),
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                    decoration: const InputDecoration(
                      labelText: "Phone",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: _referralController,
                    decoration: const InputDecoration(
                      labelText: "Referral Code (Optional)",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  state is UpdateProfileLoadingState
                      ? const CircularProgressIndicator()
                      : SizedBox(
                          width: double.infinity,
                          height: 50,
                          child: ElevatedButton(
                            onPressed: _submit,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                            ),
                            child: const Text(
                              "Save Changes",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
