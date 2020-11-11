class MyActivity : AppCompatActivity() {

    /**
     * Load and invoke class from "assets/classes.dex"
     */
    fun loadClassFromDex() {
        
        // Copy classes.dex to cache dir
        val path = File(cacheDir.absolutePath + "/classes.dex")
        assets.open("classes.dex").copyTo(path.outputStream())

        // load class by name ('my.package.name.ClassName')
        DexClassLoader(path.absolutePath, null, null, null)
            .loadClass("com.my.class.Here")
            .constructors.first() // get class constructor
            .newInstance(this) // send param to constructor and create instance
    
    }
}