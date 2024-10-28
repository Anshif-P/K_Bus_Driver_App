import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:k_bus_driver/controller/add_bus_bloc/add_bus_bloc.dart';
import 'package:k_bus_driver/util/constance/text_style.dart';
import 'package:k_bus_driver/util/snack_bar/snack_bar.dart';
import 'package:k_bus_driver/util/validation/validation.dart';
import 'package:k_bus_driver/view/screen_add_routes.dart';
import 'package:k_bus_driver/widgets/comman/button.dart';
import 'package:k_bus_driver/widgets/comman/textfield.dart';

class ScreenAddBus extends StatelessWidget {
  ScreenAddBus({super.key});

  final TextEditingController busNameController = TextEditingController();
  final TextEditingController busNumberController = TextEditingController();
  final TextEditingController ownerNameController = TextEditingController();
  final TextEditingController ownerPhoneController = TextEditingController();
  final TextEditingController assistentPhoneController =
      TextEditingController();
  final GlobalKey<FormState> addBusKey = GlobalKey<FormState>();

  final ValueNotifier<String?> selectedBusTypeNotifier = ValueNotifier(null);
  final ValueNotifier<Color> selectedColorNotifier = ValueNotifier(Colors.blue);

  final List<String> busTypes = [
    'Super Fast',
    'Limited Stop',
    'Local',
  ];
  final ValueNotifier<bool> isLoadingNotifier = ValueNotifier(false);

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
                    validator: (value) =>
                        Validations.vehicleNumberValidation(value),
                  ),
                ),
                Text(
                  'Bus Color',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ValueListenableBuilder<Color>(
                    valueListenable: selectedColorNotifier,
                    builder: (context, color, _) => GestureDetector(
                      onTap: () => pickColor(context),
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Pick a Color',
                          style:
                              AppText.mediumdark.copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ),
                Text(
                  'Bus Type',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ValueListenableBuilder<String?>(
                    valueListenable: selectedBusTypeNotifier,
                    builder: (context, selectedBusType, _) =>
                        DropdownButtonFormField<String>(
                      value: selectedBusType,
                      items: busTypes.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        selectedBusTypeNotifier.value = newValue;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      validator: (value) =>
                          value == null ? 'Please select a bus type' : null,
                    ),
                  ),
                ),
                Text(
                  'Bus Owner Name',
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
                  'Owner Number',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    isNumber: true,
                    controller: ownerPhoneController,
                    validator: (value) => Validations.numberValidation(value),
                  ),
                ),
                Text(
                  'Assistant Number',
                  style: AppText.mediumdark,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: TextFieldWidget(
                    isNumber: true,
                    controller: assistentPhoneController,
                    validator: (value) => Validations.numberValidation(value),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AddBusBloc, AddBusState>(
                  listener: (context, state) {
                    if (state is AddBusDetailsSuccessState) {
                      isLoadingNotifier.value = false;
                      CustomSnackBar.showSnackBar(
                          context, 'Bus Details Added Successfully');
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => const ScreenAddRoutes()));
                    } else if (state is AddBusDetailsFailedState) {
                      isLoadingNotifier.value = false;
                      CustomSnackBar.showSnackBar(context, state.message);
                    } else if (state is AddBusLoadingState) {
                      isLoadingNotifier.value = true;
                    }
                  },
                  builder: (context, state) => ValueListenableBuilder<bool>(
                    valueListenable: isLoadingNotifier,
                    builder: (context, isLoading, _) => ButtonWidget(
                        onpressFunction: () => addBusFnc(context),
                        text: 'Add',
                        loadingCheck: isLoading,
                        colorCheck: true),
                  ),
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
          busColor: selectedColorNotifier.value.toString(),
          busType: selectedBusTypeNotifier.value!,
          ownerName: ownerNameController.text,
          ownerPhone: ownerPhoneController.text,
          assistentPhon: assistentPhoneController.text));
    }
  }

  void pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Pick a color'),
        content: SingleChildScrollView(
          child: BlockPicker(
            pickerColor: selectedColorNotifier.value,
            onColorChanged: (color) {
              selectedColorNotifier.value = color;
            },
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
