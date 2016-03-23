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

import sys.FileSystem;

import duell.objects.Server;
import duell.helpers.DuellLibHelper;
import duell.helpers.CommandHelper;
import duell.objects.Arguments;

import duell.helpers.LogHelper;

import sys.FileSystem;

import haxe.io.Path;

class RunMain
{
    public static function main()
    {
        if (!Arguments.validateArguments())
        {
            return;
        }

        var rawArgs = Arguments.getRawArguments();
        rawArgs.shift(); // remove run
        rawArgs.shift(); // remove nodejs

        if (rawArgs[0] == DUELL_HELP_ARGUMENT)
        {
            return; // Duell tool shows help.
        }

        /// no argument, just show help
        if (rawArgs.length == 0)
        {
            Arguments.printPluginHelp();
            return;
        }

        if (rawArgs[0] != "-setup") /// SETUP NOT REQUESTED
        {
            switch (Setup.getSetupState())
            {
                case NEEDS_UPDATE:
                    LogHelper.exitWithFormattedError("[Nodejs] Your NodeJS setup is not up to date, please run 'duell run npm -setup'");
                case NOT_DONE:
                    LogHelper.exitWithFormattedError("[Nodejs] Setup not complete, please run 'duell run npm -setup'");
                case DONE:
            }
        }
        else /// SETUP
        {
            Setup.setup();
            return;
        }

        Setup.addNodeBinariesToPath();

        if (rawArgs[0] == "-npm")
        {
            rawArgs.shift(); // remove -npm
            Sys.exit(NPM.run(rawArgs));
        }
    }
}
