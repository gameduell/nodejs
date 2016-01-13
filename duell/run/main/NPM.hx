/*
 * Copyright (c) 2003-2015 GameDuell GmbH, All Rights Reserved
 * This document is strictly confidential and sole property of GameDuell GmbH, Berlin, Germany
 */

package duell.run.main;

import duell.run.main.Defines.*;

import duell.helpers.CommandHelper;

import haxe.io.Path;

class NPM
{
    public static function run(args: Array<String>): Int
    {
        var path = Path.join([getNodeFolder(), "bin", "npm"]);

        return CommandHelper.runCommand("", "npm", args, {
            logOnlyIfVerbose : true
        });
    }
}
