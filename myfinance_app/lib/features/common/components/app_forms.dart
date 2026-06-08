import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myfinance_app/features/common/components/loading_component.dart';

/// Modo do formulário: edit, create, update
enum FormMode { read, edit, create, update }

/// Campo de input padronizado do app
class AppTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final bool isRequired;
  final bool isReadOnly;
  final String? prefixText;
  final TextInputType? inputType;
  final List<TextInputFormatter>? masks;
  final Widget? suffixIcon;

  const AppTextFormField({
    super.key,
    required this.label,
    required this.controller,
    this.isRequired = true,
    this.isReadOnly = false,
    this.prefixText,
    this.inputType = TextInputType.text,
    this.masks,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: isReadOnly,
      keyboardType: inputType,
      controller: controller,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        labelText: label,
        prefixText: prefixText,
        suffixIcon: suffixIcon,
      ),
      inputFormatters: masks,
      validator: isRequired ? appDefaultValidateInput : null,
    );
  }
}

/// fFunção de validação padronizada do app
String? appDefaultValidateInput(String? value) {
  if (value == null || value.trim().isEmpty) {
    return "Obrigatório";
  }
  if (value.length < 3) {
    return "Mínimo 3 caracteres";
  }
  return null;
}

/// Campo de escolha de tipo
class AppRadioGroup<T extends Enum> extends StatelessWidget {
  final T? selectedValue;
  final ValueChanged<T?> onChanged;
  final Map<T, String> options;
  final Axis direction;
  final double height;

  const AppRadioGroup({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.options,
    this.direction = Axis.horizontal,
    this.height = 60,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: direction == .horizontal ? height : null,
      child: RadioGroup<T>(
        groupValue: selectedValue,
        onChanged: onChanged,
        child: direction == .horizontal
            ? Row(
                children: options.entries.map((option) {
                  return Expanded(
                    child: RadioListTile<T>(
                      value: option.key,
                      title: FittedBox(
                        child: Text(option.value),
                      ),
                    ),
                  );
                }).toList(),
              )
            : Column(
                children: options.entries.map(
                  (option) {
                    return RadioListTile<T>(
                      value: option.key,
                      title: FittedBox(
                        child: Text(option.value),
                      ),
                    );
                  },
                ).toList(),
              ),
      ),
    );
  }
}

/// Botões de ação 'Salvar' e 'Cancelar'
class AppActionsButtons extends StatelessWidget {
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;
  final String submitLabel;
  final String cancelLabel;
  final bool isLoading;
  final bool isSubmitEnabled;
  final Color? submitColor;
  final Color? cancelColor;

  const AppActionsButtons({
    super.key,
    required this.onSubmit,
    this.onCancel,
    this.submitLabel = "Salvar",
    this.cancelLabel = "Cancelar",
    this.isLoading = false,
    this.isSubmitEnabled = true,
    this.submitColor,
    this.cancelColor,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        spacing: 16,
        children: [
          // Botão Cancelar
          Expanded(
            child: OutlinedButton(
              onPressed: onCancel ?? () => Navigator.of(context).pop(),
              style: OutlinedButton.styleFrom(
                foregroundColor: cancelColor ?? theme.colorScheme.error,
                side: BorderSide(
                  color: cancelColor ?? theme.colorScheme.error,
                ),
              ),
              child: Text(
                cancelLabel,
                style: textTheme.bodyMedium?.copyWith(
                  color: cancelColor ?? theme.colorScheme.error,
                ),
              ),
            ),
          ),

          // Botão Salvar
          Expanded(
            child: ElevatedButton(
              onPressed: isSubmitEnabled && !isLoading ? onSubmit : null,
              child: isLoading
                  ? const LoadingComponent(height: 20, width: 20)
                  : Text(submitLabel),
            ),
          ),
        ],
      ),
    );
  }
}
