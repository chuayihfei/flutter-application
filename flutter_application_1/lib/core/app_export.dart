export 'package:connectivity_plus/connectivity_plus.dart';
export 'package:flutter_application_1/core/errors/exceptions.dart';
export 'package:flutter_application_1/core/errors/failures.dart';
export 'package:flutter_application_1/core/network/network_info.dart';
export 'package:flutter_application_1/core/utils/date_time_utils.dart';
export 'package:flutter_application_1/core/utils/image_constants.dart';
export 'package:flutter_application_1/core/utils/logger.dart';
export 'package:flutter_application_1/core/utils/navigator_service.dart';
export 'package:flutter_application_1/core/utils/pref_utils.dart';
export 'package:flutter_application_1/core/utils/progress_dialog_utils.dart';
export 'package:flutter_application_1/core/utils/size_utils.dart';
export 'package:flutter_application_1/core/utils/validation_functions.dart';
export 'package:flutter_application_1/data/models/selectionPopupModel/selection_popup_model.dart';
export 'package:flutter_application_1/localization/app_localization.dart';
export 'package:flutter_application_1/theme/app_decoration.dart';
export 'package:flutter_application_1/theme/custom_text_style.dart';
export 'package:flutter_application_1/theme/theme_helper.dart';
export 'package:flutter_application_1/theme/provider/theme_provider.dart';
export 'package:flutter_application_1/theme/custom_button_style.dart';
export 'package:flutter_application_1/widgets/custom_image_view.dart';
export 'package:flutter_application_1/routes/app_routes.dart';
export 'package:provider/provider.dart';
export 'dart:developer';

extension StringExtensions on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1)}";
  }
}
