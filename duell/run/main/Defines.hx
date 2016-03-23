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
