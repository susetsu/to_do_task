import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:intl/intl.dart';
import 'package:todo_list_bloc/config/config.dart';
import 'package:todo_list_bloc/infrastructure/models/task.dart';
import 'package:todo_list_bloc/presentation/bloc/task_bloc.dart';
import 'package:todo_list_bloc/presentation/shared/widgets/toast.dart';

import '../../shared/shared.dart';

class AddUpdateTaskScreen extends StatelessWidget {
  static const name = 'add-task';
  const AddUpdateTaskScreen({super.key, this.task});
  final Task? task;
  @override
  Widget build(BuildContext context) {
    final theme = AppTheme().getTheme();
    final formKey = GlobalKey<FormBuilderState>();
    String text = 'Crear';
    if (task != null) {
      text = 'Actualizar';
    }

    return FadeIn(
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20.0),
            bottom: Radius.circular(20.0),
          ),
        ),
        contentPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        title: ClipRRect(
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(20.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            color: theme.primaryColor,
            child: Center(
              child: Text(
                "Agregar tarea",
                style:
                    theme.textTheme.displayMedium!.copyWith(color: Colors.white),
              ),
            ),
          ),
        ),
        content: Padding(
          padding: const EdgeInsetsDirectional.all(16.0),
          child: _MakeTaskBody(
            formKey: formKey,
            nameValue: task?.title ?? '',
            dateValue: task?.initDate ?? DateTime.now(),
            endDateValue: task?.endDate,
            isCompletedValue: task?.isCompleted ?? false,
          ),
        ),
        actions: [
          TextButton(
            child: const Text('Cancelar'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: Text(text),
            onPressed: () {
              try {
                final saveValidate = formKey.currentState?.saveAndValidate();
                if (saveValidate == true) {
                  final formData = formKey.currentState!.value;
                  if (formData['endDate'] != null &&
                      formData['endDate'].isBefore(formData['initDate'])) {
                    ToastWidget().showMessage(
                        text:
                            "La fecha de culminación debe ser mayor a la fecha inicial",
                        color: Colors.red);
                    return;
                  }
      
                  if (formData['endDate'] != null &&
                      formData['isCompleted'] == false) {
                    ToastWidget().showMessage(
                        text:
                            "Si selecciona una fecha de culminación, asegúrese de que el interruptor de \"¿Tarea completada?\" esté activado.",
                        color: Colors.red);
                    return;
                  }
                  appRouter.pop();
      
                  switch (text) {
                    case "Actualizar":
                      final Task taskUpdated = Task(
                          id: task!.id,
                          title: formData['title'],
                          initDate: formData['initDate'],
                          endDate: formData['endDate'],
                          isCompleted: formData['isCompleted']);
                      context.read<TaskBloc>().updateTask(taskUpdated);
      
                      break;
      
                    default:
                      context.read<TaskBloc>().addTask(
                          formData['title'],
                          formData['initDate'],
                          formData['endDate'],
                          formData['isCompleted']);
                      break;
                  }
                }
              } on Exception catch (e) {
                debugPrint("Ocurrio un error al $text la informacion: $e");
                ToastWidget().showMessage(
                    text: "Ocurrió un error al $text la información",
                    color: Colors.red);
              }
            },
          ),
        ],
      ),
    );
  }
}

class _MakeTaskBody extends StatelessWidget {
  const _MakeTaskBody({
    required this.formKey,
    required this.nameValue,
    required this.dateValue,
    this.endDateValue = null,
    this.isCompletedValue = false,
  });

  final GlobalKey<FormBuilderState> formKey;
  final String nameValue;
  final DateTime dateValue;
  final DateTime? endDateValue;
  final bool isCompletedValue;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          onChanged: () {
            formKey.currentState!.save();
            debugPrint(formKey.currentState!.value.toString());
          },
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                elevation: 10,
                shadowColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: FormBuilderTextField(
                  name: 'title',
                  initialValue: nameValue,
                  keyboardType: TextInputType.text,
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(
                        errorText: 'Debe completar el campo'),
                    FormBuilderValidators.maxWordsCount(20,
                        errorText: 'Máximo 20 caracteres')
                  ]),
                  decoration: inputDecoration(text: 'Nombre'),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                elevation: 10,
                shadowColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: FormBuilderDateTimePicker(
                  validator: FormBuilderValidators.required(
                      errorText: 'Debe completar el campo'),
                  name: 'initDate',
                  cursorColor: Colors.white,
                  initialValue: dateValue,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialDate: dateValue,
                  inputType: InputType.both,
                  firstDate: DateTime(1700, 1, 1),
                  format: DateFormat('dd/MM/yyyy hh:mm a'),
                  lastDate: DateTime.now(),
                  decoration: inputDecoration(
                    text: 'Fecha de inicio',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        formKey.currentState!.fields['initDate']
                            ?.didChange(null);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Material(
                elevation: 10,
                shadowColor: Colors.white,
                borderRadius: BorderRadius.circular(15),
                child: FormBuilderDateTimePicker(
                  validator: FormBuilderValidators.compose([
                    (val) {
                      final isCompleted =
                          formKey.currentState?.fields['isCompleted']?.value ??
                              false;
                      if (isCompleted && val == null) {
                        return 'Debe completar este campo';
                      }
                      return null;
                    }
                  ]),
                  name: 'endDate',
                  cursorColor: Colors.white,
                  initialValue: endDateValue,
                  initialEntryMode: DatePickerEntryMode.calendar,
                  initialDate:
                      endDateValue ?? dateValue.add(const Duration(days: 1)),
                  inputType: InputType.both,
                  firstDate: dateValue,
                  format: DateFormat('dd/MM/yyyy hh:mm a'),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  decoration: inputDecoration(
                    text: 'Fecha de culminación',
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () {
                        formKey.currentState!.fields['endDate']
                            ?.didChange(null);
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              FormBuilderSwitch(
                name: 'isCompleted',
                initialValue: isCompletedValue,
                title: const Text('¿Tarea completada?'),
                decoration: inputDecoration(text: 'Estado de la tarea'),
                onChanged: (val) {
                  if (val == true) {
                    // Si la tarea está completada, podrías habilitar el campo de fecha
                    // Esto solo lo muestra, pero no abre automáticamente el calendario
                    final endDateField =
                        formKey.currentState?.fields['endDate'];
                    endDateField?.didChange(
                        endDateField.value); // Mantener el valor actual
                    endDateField
                        ?.validate(); // Validar pero no abrir el calendario
                  }
                },
              ),
            ],
          )),
    );
  }
}
