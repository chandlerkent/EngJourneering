#!/usr/bin/env objj

@import <Foundation/CPObject.j>

@implementation OLTestRunner : CPObject
{
}

- (void)startWithArguments:(CPArray)arguments
{
    var arg = @"Tests/*/*Test*.j";
    var globbedArguments = [self globArgument:arg];
    var ojtestOptions = {args:globbedArguments};
    
    print("Running 'ojtest " + arg + "'...");
    runCommand("ojtest", ojtestOptions);
}

- (CPArray)globArgument:(CPString)argument
{
    var arguments = [];
    var paths = [""];
    var tokens = argument.split("/");
    
    for (var i = 0; i < tokens.length; i++)
    {
        var token = tokens[i];
        var newPaths = [];
        for (var j = 0; j < paths.length; j++)
        {
            var path = paths[j];
            if (path !== "")
            {
                path += "/";
            }
            var newPath = [self globPath:path withToken:token];
            for (var k = 0; k < newPath.length; k++)
            {
                newPaths.push(newPath[k]);
            }
        }
        paths = newPaths;
    }
    
    return paths;
}

- (CPArray)globPath:(CPString)currentPath withToken:(CPString)token
{    
    var paths = [];
    var wildcardLocation = token.indexOf("*");
    if (wildcardLocation === -1)
    {
        if (currentPath === "")
        {
            paths.push(token);
        }
        else
        {
            paths.push(currentPath + token);
        }
    }
    else
    {
        var regExString = token.split("*").join(".*");
        var regEx = new RegExp(regExString, "i");
    
        var filesOrFolders = [self runlsForPath:currentPath];
        for (var j = 0; j < filesOrFolders.length; j++)
        {
            var fileOrFolder = filesOrFolders[j];
            if (fileOrFolder && regEx.test(fileOrFolder))
            {
                paths.push(currentPath + fileOrFolder);
            }
        }
    }
    
    return paths;
}

- (JSObject)runlsForPath:(CPString)path
{
    var options = {output: ''};
    if (path === "")
    {
        runCommand("ls", options);
    }
    else
    {
        runCommand("ls", path, options);
    }
    return options.output.split("\n");
}

@end

var testRunner = [[OLTestRunner alloc] init];
[testRunner startWithArguments:args];