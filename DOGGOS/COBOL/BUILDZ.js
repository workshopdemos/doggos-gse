// requires for the stdlib - path prefix is "bldz/std/exp"
// using new stdlib - bldz version >= 1.43.5
var cobol = require("bldz/std/exp/rules/cobol")
var files = require("bldz/std/exp/rules/files");
var intertest = require("bldz/std/exp/rules/intertest")
var os = require("bldz/os");

var loadlibDSN = `${os.user()}.PUBLIC.LOADLIB`;
var PROTSYMDSN = `${os.user()}.PUBLIC.PROTSYM`;

// alloc loadlib
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

// compile and bind cobol files into an executable object, named as "DOGGOS"
var cobol_binary = cobol.compileAndBind({
    name: "DOGGOS",
    srcs: "*.cbl",
    syslibs: [`//'${os.user()}.DOGGOS.COPYBOOK'`],
    opts: [...intertest.options.cobol, "TEST"],
    opts_binder: ["RENT"],
    syslibs_binder: [
        "//CEE.SCEELKED",
    ],

})

// initialize PROTSYM
// step1 - IDCAMS creates VSAM PROTSYM
// step2 - IN25UTIL defines report
var initProtsym = intertest.initProtsym({
    protsym_dsn: PROTSYMDSN
})

// execute IN25COB2 which loads listing into PROTSYM
var loadCoblist = intertest.cobol({
    deps: initProtsym,
    srcDeps: ["DOGGOS"],
    srcDepsProp: "compile_listing",
})

// execute IN25UTIL which creates report for PROTSYM
intertest.reportProtsym({
    name: "reportPROTSYM",
    deps: [
        ...initProtsym,
        ...loadCoblist
    ]
})

// copy the executable object into a load library
files.ds.copy({
    name: "copyLoad",
    dsn: loadlibDSN,
    deps: dataset_rules.rules.concat(cobol_binary),
    executable: true,
});
