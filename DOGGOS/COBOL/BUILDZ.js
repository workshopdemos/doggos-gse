//
// requires for the stdlib - path prefix is "bldz/std/exp"
var compile = require("bldz/std/exp/rules/compile");
var binder = require("bldz/std/exp/rules/binder");
var group = require("bldz/std/exp/rules/group");

// build-in bldz modules requires
var os = require("bldz/os");

// general COBOL compile rules - create a compile rule per *.cbl file found
var generated = compile.cobol({
    // the location to search for COPYBOOKs
    srcs: "*.CBL",
    copyPaths: [`//'${os.user()}.DOGGOS.COPYBOOK'`],
    opts : [
        "OFFSET",
        "MAP(HEX)"
    ]
        
    
});

// Bind the objects into an executable

var binderGenerated = binder.bind({
    outs: "doggos",
    syslibs: ["//CEE.SCEELKED"],
    deps: generated.rules
});

group.outputs({
    name: "all",
    depsOutPropPrefix: "binary",
    deps: binderGenerated.rules
});