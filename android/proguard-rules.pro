-keep class us.google.protobuf.** { *; }
-keep class com.google.crypto.tink.** { *; }
-keep class androidx.security.crypto.** { *; }

# Keep public classes and methods
-keep public class com.shotcoder.smc.** {
    public *;
}

# Keep specific classes and methods
-keep class com.shotcoder.smc.models.** { *; }

# Exclude specific classes from obfuscation
-keep class androidx.** { *; }
-keep class com.google.android.material.** { *; }