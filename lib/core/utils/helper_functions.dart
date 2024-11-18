import 'package:dio/dio.dart';
import 'package:echo/core/dependecy_injection.dart';
import 'package:echo/core/utils/extensions.dart';
import 'package:flutter/material.dart';

class HelperFunctions {
  static void showErrorSnackBar({required String message}) {
    BuildContext context = sl<GlobalKey<NavigatorState>>().currentState!.context;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: context.theme.colorScheme.error,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: context.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onError),
        ),
      ),
    );
  }

  static void showSnackBar({required String message, SnackBarAction? snackBarAction}) {
    BuildContext context = sl<GlobalKey<NavigatorState>>().currentState!.context;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        action: snackBarAction,
        backgroundColor: context.theme.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        behavior: SnackBarBehavior.floating,
        content: Text(
          message,
          style: context.textTheme.bodySmall?.copyWith(color: context.theme.colorScheme.onPrimary),
        ),
      ),
    );
  }

  static String getDioExceptionMessage(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Connection Time out. Please try again';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please check your network settings and try again.';
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        if (statusCode != null) {
          switch (statusCode) {
            case 400:
              return "Your request is invalid. Please try again";
            case 401:
              return 'Unauthorized, attempt failed';
            case 403:
              return 'You have reached your daily quota, the next reset is at 00:00 UTC';
            case 429:
              return 'Too Many Requests -- You have made more requests per second than you are allowed';
            default:
              return 'Service Unavailable. Error occured with code $statusCode';
          }
        } else {
          return 'Unkown error has occured. Please Try again';
        }
      default:
        return 'Unkown error has occured. Please Try again';
    }
  }
}
