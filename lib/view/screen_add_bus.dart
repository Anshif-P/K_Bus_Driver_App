import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:k_bus_driver/controller/add_bus_bloc/add_bus_bloc.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/util/snack_bar/snack_bar.dart';
import 'package:k_bus_driver/util/validation/validation.dart';
import 'package:k_bus_driver/view/screen_add_routes.dart';
import 'package:k_bus_driver/view/screen_login.dart';
import 'package:k_bus_driver/widgets/comman/button.dart';
import 'package:k_bus_driver/widgets/comman/textfield.dart';

class ScreenAddBus extends StatelessWidget {
  ScreenAddBus({super.key});
  TextEditingController busNameController = TextEditingController();
  TextEditingController busNumberController = TextEditingController();
  TextEditingController busColorController = TextEditingController();
  TextEditingController busTypeController = TextEditingController();
  TextEditingController ownerNameController = TextEditingController();
  TextEditingController ownerPhoneController = TextEditingController();
  TextEditingController assistentPhoneController = TextEditingController();
  GlobalKey<FormState> addBusKey = GlobalKey<FormState>();
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(Icons.arrow_back_ios)),
        title: Text(
          'Bus Details',
          style: AppText.defautTitleDark,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: SingleChildScrollView(
          child: Form(
            key: addBusKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bus Name',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    controller: busNameController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                Text(
                  'Bus Number',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    controller: busNumberController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                Text(
                  'Bus Color',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    controller: busColorController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                Text(
                  'Bus Type',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    controller: busTypeController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                Text(
                  'Bus OwnerName',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    controller: ownerNameController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                Text(
                  'Owner Numer',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    isNumber: true,
                    controller: ownerPhoneController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                Text(
                  'Assistent Number',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    isNumber: true,
                    controller: assistentPhoneController,
                    validator: (value) => Validations.emtyValidation(value),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AddBusBloc, AddBusState>(
                  listener: (context, state) {
                    if (state is AddBusDetailsSuccessState) {
                      isLoading = false;
                      CustomSnackBar.showSnackBar(
                          context, 'Bus Details Added Successfuly');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ScreenAddRoutes()));
                    } else if (state is AddBusDetailsFailedState) {
                      isLoading = false;
                      CustomSnackBar.showSnackBar(context, state.message);
                    } else if (state is AddBusLoadingState) {
                      isLoading = true;
                    }
                  },
                  builder: (context, state) => ButtonWidget(
                      onpressFunction: () => addBusFnc(context),
                      text: 'Add',
                      loadingCheck: isLoading,
                      colorCheck: true),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addBusFnc(BuildContext context) async {
    if (addBusKey.currentState!.validate()) {
      context.read<AddBusBloc>().add(AddBusDetailsEvent(
          busName: busNameController.text,
          busNumber: busNumberController.text,
          busColor: busColorController.text,
          busType: busTypeController.text,
          ownerName: ownerNameController.text,
          ownerPhone: ownerPhoneController.text,
          assistentPhon: assistentPhoneController.text));
    }
  }
}
