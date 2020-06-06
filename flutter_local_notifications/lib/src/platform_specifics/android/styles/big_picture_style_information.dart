import '../../../../flutter_local_notifications.dart';
import '../bitmap.dart';
import '../enums.dart';
import 'default_style_information.dart';

/// Used to pass the content for an Android notification displayed using the big picture style.
class BigPictureStyleInformation extends DefaultStyleInformation {
  const BigPictureStyleInformation(
    this.bigPicture, {
    this.contentTitle,
    this.summaryText,
    this.htmlFormatContentTitle = false,
    this.htmlFormatSummaryText = false,
    this.largeIcon,
    bool htmlFormatContent = false,
    bool htmlFormatTitle = false,
    this.hideExpandedLargeIcon = false,
  }) : super(htmlFormatContent, htmlFormatTitle);

  /// Overrides ContentTitle in the big form of the template.
  final String contentTitle;

  /// Set the first line of text after the detail section in the big form of the template.
  final String summaryText;

  /// Specifies if the overridden ContentTitle should have formatting applied through HTML markup.
  final bool htmlFormatContentTitle;

  /// Specifies if formatting should be applied to the first line of text after the detail section in the big form of the template.
  final bool htmlFormatSummaryText;

  /// The bitmap that will override the large icon when the big notification is shown.
  final AndroidBitmap largeIcon;

  /// The bitmap to be used as the payload for the BigPicture notification.
  final AndroidBitmap bigPicture;

  /// Hides the large icon when showing the expanded notification.
  final bool hideExpandedLargeIcon;

  /// Creates a [Map] object that describes the [BigPictureStyleInformation] object.
  ///
  /// Mainly for internal use to send the data over a platform channel.
  @override
  Map<String, dynamic> toMap() {
    return super.toMap()
      ..addAll(_convertBigPictureToMap())
      ..addAll(_convertLargeIconToMap())
      ..addAll(<String, dynamic>{
        'contentTitle': contentTitle,
        'summaryText': summaryText,
        'htmlFormatContentTitle': htmlFormatContentTitle,
        'htmlFormatSummaryText': htmlFormatSummaryText,
        'hideExpandedLargeIcon': hideExpandedLargeIcon
      });
  }

  Map<String, dynamic> _convertBigPictureToMap() {
    if (bigPicture is AndroidResourceBitmap) {
      return <String, dynamic>{
        'bigPicture': bigPicture.icon,
        'bigPictureBitmapSource': AndroidBitmapSource.DrawableBitmap.index,
      };
    } else if (bigPicture is AndroidFilePathBitmap) {
      return <String, dynamic>{
        'bigPicture': bigPicture.icon,
        'bigPictureBitmapSource': AndroidBitmapSource.FilePath.index,
      };
    } else {
      return <String, dynamic>{};
    }
  }

  Map<String, dynamic> _convertLargeIconToMap() {
    if (largeIcon is AndroidDrawable) {
      return <String, dynamic>{
        'largeIcon': largeIcon.icon,
        'largeIconBitmapSource': AndroidBitmapSource.Drawable.index,
      };
    } else if (largeIcon is AndroidResourceBitmap) {
      return <String, dynamic>{
        'largeIcon': largeIcon.icon,
        'largeIconBitmapSource': AndroidBitmapSource.DrawableBitmap.index,
      };
    } else if (largeIcon is AndroidFilePathBitmap) {
      return <String, dynamic>{
        'largeIcon': largeIcon.icon,
        'largeIconBitmapSource': AndroidBitmapSource.FilePath.index,
      };
    } else {
      return <String, dynamic>{};
    }
  }
}
