/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package duell.run.main;

import duell.helpers.DuellConfigHelper;

import haxe.io.Path;

class Defines
{
    public static inline var NODE_MAC_URL: String = "https://nodejs.org/dist/v4.2.4/node-v4.2.4-darwin-x64.tar.gz";
    public static inline var NODE_LNX_URL: String = "https://nodejs.org/dist/v4.2.4/node-v4.2.4-linux-x64.tar.gz";
    public static inline var NODE_WIN_URL: String = "https://nodejs.org/dist/v4.2.4/win-x64/node.exe";

    public static inline var DUELL_SDK_FOLDER_NAME: String = "node4_2_4";
    public static inline var SETUP_COMPLETE_FILE: String = ".setup";
    public static inline var SETUP_VERSION: Int = 1;
    public static inline var DUELL_HELP_ARGUMENT: String = "-help";

    public static function getNodeFolder(): String
    {
        return Path.join([DuellConfigHelper.getDuellConfigFolderLocation(), "SDKs", DUELL_SDK_FOLDER_NAME]);
    }
}
