/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
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
