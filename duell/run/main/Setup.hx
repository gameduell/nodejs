/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package duell.run.main;

import duell.run.main.Defines.*;

import duell.helpers.PathHelper;
import duell.helpers.LogHelper;
import duell.helpers.PlatformHelper;
import duell.helpers.DownloadHelper;
import duell.helpers.ExtractionHelper;
import duell.run.main.Defines.*;

import haxe.io.Path;

import sys.FileSystem;
import sys.io.File;

enum SetupState
{
    NOT_DONE;
    NEEDS_UPDATE;
    DONE;
}

class Setup
{
    public static function getSetupState(): SetupState
    {
        var nodeFolder = getNodeFolder();

        if (FileSystem.exists(nodeFolder))
        {
            var setupFilePath = Path.join([nodeFolder, SETUP_COMPLETE_FILE]);
            if (FileSystem.exists(setupFilePath))
            {
                var setupContent = File.getContent(setupFilePath);

                var setupNumber: Null<Int> = Std.parseInt(setupContent);

                if (setupNumber != null)
                {
                    if (setupNumber == SETUP_VERSION)
                    {
                        return DONE;
                    }
                    else
                    {
                        return NEEDS_UPDATE;
                    }
                }
                else
                {
                    return NEEDS_UPDATE;
                }
            }
        }

        return NOT_DONE;
    }

    public static function setup(): Void
    {
        installNodeAndNPM();

        /// save setup complete file
        File.saveContent(Path.join([getNodeFolder(), SETUP_COMPLETE_FILE]), "" + SETUP_VERSION);
    }

    private static function installNodeAndNPM(): Void
    {
        LogHelper.info("[Nodejs] Installing Node and NPM");

		var nodeFolder = getNodeFolder();

		/// clean up previous installation

        if (FileSystem.exists(nodeFolder))
        {
            LogHelper.info("[Nodejs] Deleting previous installation before setup...");
            PathHelper.removeDirectory(nodeFolder);
        }

		/// get correct url

        var downloadURL = NODE_MAC_URL;

        if (PlatformHelper.hostPlatform == Platform.WINDOWS)
        {
            /// TODO windows is different
            downloadURL = NODE_WIN_URL;
        }
        else if (PlatformHelper.hostPlatform == Platform.LINUX)
        {
            downloadURL = NODE_LNX_URL;
        }

        /// download

        LogHelper.info("[Nodejs] Downloading from " + downloadURL);
        DownloadHelper.downloadFile(downloadURL);

        /// create the directory

        PathHelper.mkdir(nodeFolder);

        /// extract

        LogHelper.info("[Nodejs] Extracting...");

		var zipName = Path.withoutDirectory(downloadURL);
        var zipNameWithoutExtension = zipName.substring(0, zipName.length - ".tag.gz".length);

        ExtractionHelper.extractFile(zipName, nodeFolder, zipNameWithoutExtension);
    }

    public static function addNodeBinariesToPath(): Void
    {
        var envPathArray = Sys.getEnv("PATH").split(":");
        envPathArray.push(Path.join([getNodeFolder(), "bin"]));
        Sys.putEnv("PATH", envPathArray.join(":"));
    }
}
