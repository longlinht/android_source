## About 

This is a repository for deep into Android OS. While I read source code, I would write down some comment to clear the Android architecture and principle. Welcome to add pull requests to help me.

## Android Source Code

This repository hold complete Android source code(Froyo). It can be compiled and run image file in emulator.

## Reading Code Notes

#### JNI(Java Native Interface)

It makes Java methods and Native mehtods can call each other.

* Example

Java(MediaScanner) <---> JNI(libmeida_jni.so) <---> Native(libmedia.so)

**JNI must implemented by dynamic library**

```
/* 
* MediaScanner.java
*
*/

public class MediaScanner
{
    static {
        System.loadLibrary("media_jni");
        native_init();
    }

    ...


    private static native final void native_init();

    ...
}

```

This function is JNI implementation of `native_init`

```
/*
* android_media_Media_Scanner.cpp 
*
*/


// This function gets a field ID, which in turn causes class initialization.
// It is called from a static block in MediaScanner, which won't run until the
// first time an instance of this class is used.
static void
android_media_MediaScanner_native_init(JNIEnv *env)
{
     jclass clazz;

    clazz = env->FindClass("android/media/MediaScanner");
    if (clazz == NULL) {
        jniThrowException(env, "java/lang/RuntimeException", "Can't find android/media/MediaScanner");
        return;
    }

    fields.context = env->GetFieldID(clazz, "mNativeContext", "I");
    if (fields.context == NULL) {
        jniThrowException(env, "java/lang/RuntimeException", "Can't find MediaScanner.mNativeContext");
        return;
    }
}

```

But, how know Java method `native_init`'s countpart is `android_media_MediaScanner_native_init`?

* Reigster JNI function

    * Static register

    * Dynamic register

**JNINativeMethod**

```

typedef struct { 
    const char* name; // native function name in Java 
    const char* signature; // Java method's signature, include parameters type and return value type
    void*       fnPtr; // function pointer in JNI layer
} JNINativeMethod;

```

**This array store the relationship of Java method and native function**

```
static JNINativeMethod gMethods[] = {
    {"processDirectory",  "(Ljava/lang/String;Ljava/lang/String;Landroid/media/MediaScannerClient;)V",    
                                                        (void *)android_media_MediaScanner_processDirectory},
    {"processFile",       "(Ljava/lang/String;Ljava/lang/String;Landroid/media/MediaScannerClient;)V",    
                                                        (void *)android_media_MediaScanner_processFile},
    {"setLocale",         "(Ljava/lang/String;)V",      (void *)android_media_MediaScanner_setLocale},
    {"extractAlbumArt",   "(Ljava/io/FileDescriptor;)[B",     (void *)android_media_MediaScanner_extractAlbumArt},
    {"native_init",        "()V",                      (void *)android_media_MediaScanner_native_init},
    {"native_setup",        "()V",                      (void *)android_media_MediaScanner_native_setup},
    {"native_finalize",     "()V",                      (void *)android_media_MediaScanner_native_finalize},
};

```












