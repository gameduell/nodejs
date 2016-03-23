/*
 * Copyright (c) 2003-2016, GameDuell GmbH
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * 1. Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * 2. Redistributions in binary form must reproduce the above copyright notice,
 * this list of conditions and the following disclaimer in the documentation
 * and/or other materials provided with the distribution.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
 * ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
 * WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY
 * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
 * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
 * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
 * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
