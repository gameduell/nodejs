package duell.build.plugin.library.sample;

import duell.build.objects.DuellProjectXML;
import duell.build.objects.Configuration;

import duell.build.plugin.library.sample.LibraryConfiguration;

import duell.helpers.XMLHelper;

import haxe.xml.Fast;

class LibraryXMLParser
{
    /**
        Expects an element with the tag `<config-id />` to parse.
    **/
    public static function parse(xml: Fast): Void
    {
        Configuration.getData().LIBRARY.SAMPLE = LibraryConfiguration.getData();

        for (element in xml.elements)
        {
            if (!XMLHelper.isValidElement(element, DuellProjectXML.getConfig().parsingConditions))
                continue;

            switch(element.name)
            {
                case 'config-id':
                    parseConfigIdElement(element);
            }
        }
    }

    /**
        Expects an to parse an attribute `value` with the tag `config-id`.

        Example:
        `<sample>
            <config-id value="12345678" />
        </sample>`
    **/
    private static function parseConfigIdElement(element: Fast): Void
    {
        if (element.has.value)
        {
            LibraryConfiguration.getData().CONFIG_ID = element.att.value;
        }
    }
}
