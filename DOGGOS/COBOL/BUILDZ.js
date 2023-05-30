//
// requires for the stdlib - path prefix is "bldz/std/exp"
var compile = require("bldz/std/exp/rules/compile");
var binder = require("bldz/std/exp/rules/binder");
var group = require("bldz/std/exp/rules/group");
var files = require("bldz/std/exp/rules/files");

var os = require("bldz/os");
// build-in bldz modules requires
var loadlibDSN = `${os.user()}.PUBLIC.LOADLIB`;



var dataset_rules = files.ds.alloc([
    {
        attributes: {
            dsn: loadlibDSN,
            lrecl: 0,
            recfm: "U",
            dsorg: "PO",
            dsntype: "LIBRARY",
            blksize: 6160,
            vol: "TSU006",
        },
        opts: {
            delete: true
        }
    }
]);

// general COBOL compile rules - create a compile rule per *.cbl file found
var generated = compile.cobol({
    name: "cobcompile",
    // the location to search for COPYBOOKs
    srcs: "*.CBL",
    copyPaths: [`//'${os.user()}.DOGGOS.COPYBOOK'`],
    opts : [
        // "OFFSET",
        // "MAP(HEX)",
        "APOST",
        "LIST",
        "RENT",
        "MAP",
        "NONUMBER",
        "XREF",
        "NOSTGOPT",
        "OPT(0)"
    ]
        
    
});

// Bind the objects into an executable

var binderGenerated = binder.bind({
    outs: "doggos",
    syslibs: ["//CEE.SCEELKED"],
    deps: generated.rules
});

// preprare PROTSYM
var symbol = genrule_script({
    name: "in25cob2",
    script_file: "../scripts/in25cob2.js",
    deps: generated.rules
    // deps: [
    //     "cobcompile"
    // ]
});

// group.outputs({
//     name: "all",
//     depsOutPropPrefix: "binary",
//     deps: binderGenerated.rules
// });

files.ds.copy({
    name: "copyLoad",
    dsn: loadlibDSN,
    deps: dataset_rules.rules.concat(binderGenerated.rules),
    // [
    //     dataset_rules.rules,
    //     binderGenerated.rules
    // ],
    // binary: false,
    executable: true,
    
    // files: "../build-out/COBOL/doggos",
    // files: binderGenerated.rules.
});