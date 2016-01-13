package duell.build.plugin.library.sample;

typedef LibraryConfigurationData = {
    CONFIG_ID: String,
}

class LibraryConfiguration
{
    private static var configuration: LibraryConfigurationData = null;
    private static var parsingDefines: Array<String> = ["sample"];

    public static function getData(): LibraryConfigurationData
    {
        if (configuration == null)
        {
            initConfig();
        }

        return configuration;
    }

    public static function getConfigParsingDefines(): Array<String>
    {
        return parsingDefines;
    }

    public static function addParsingDefine(str: String): Void
    {
        parsingDefines.push(str);
    }

    private static function initConfig(): Void
    {
        configuration =
        {
            CONFIG_ID : ""
        };
    }
}
