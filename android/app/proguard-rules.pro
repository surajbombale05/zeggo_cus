# Flutter
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Other rules for third-party dependencies
-keep class com.google.** { *; }
-keepclassmembers enum * { *; }
-keepattributes Signature
-keepattributes Annotation


#applink

# Keep AutoSafeParcelables
-keep public class * extends org.microg.safeparcel.AutoSafeParcelable {
    @org.microg.safeparcel.SafeParcelable.Field *;
    @org.microg.safeparcel.SafeParceled *;
}

# Keep asInterface method cause it's accessed from SafeParcel
-keepattributes InnerClasses
-keepclassmembers interface * extends android.os.IInterface {
    public static class *;
}
-keep public class * extends android.os.Binder { public static *; }


-keepattributes *Annotation*
-dontwarn com.razorpay.**
-keep class com.razorpay.** {*;}
-optimizations !method/inlining/
-keepclasseswithmembers class * {
  public void onPayment*(...);
}

# Flutter and Play Core keep rules

# Keep Flutter classes
-keep class io.flutter.app.** { *; }
-keep class io.flutter.embedding.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.** { *; }

# Keep Google Play Core classes (Fix missing SplitCompat issues)
-keep class com.google.android.play.core.** { *; }
-dontwarn com.google.android.play.core.**

# Keep Firebase Messaging if used
-keep class com.google.firebase.** { *; }
-dontwarn com.google.firebase.**

# Prevent R8 from removing annotations
-keepattributes *Annotation*

# Optional: Prevent aggressive optimization
-dontoptimize
-dontpreverify
-dontshrink


# Fix Missing j2objc Annotations
-keep class com.google.j2objc.annotations.* { *; }
-dontwarn com.google.j2objc.annotations.**

# Fix for java.lang.reflect.AnnotatedType
-keep class java.lang.reflect.AnnotatedType { *; }
-dontwarn java.lang.reflect.AnnotatedType

# Fix Guava
-keep class com.google.common.** { *; }
-dontwarn com.google.common.**


-dontwarn com.squareup.okhttp.**
-keep class com.squareup.okhttp.** { *; }
