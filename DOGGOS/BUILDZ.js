////////////////////////////////////////////////////////////////////////////////
// validate that the required version of bldz is installed
//require("./scripts/version").requires("1.24.3");

////////////////////////////////////////////////////////////////////////////////
// rule that groups everything under a single target "all"
genrule_usscmd({
    name: "all",
    exec: "",
    deps: [
        // "//COBOL:all",
        "//COBOL:copyLoad",
        "//COBOL:in25cob2"
        // "in25cob2"
    ]
});

// //Allocate VSAM for PROTSYM adsfa
// genrule_script({
//     name: "PROTSYM_Alloc",
//     script_file: "scripts/protsym.js"
// });

// //initialize PROTSYM
// genrule_script({
//     name: "initPROTSYM",
//     script_file: "scripts/report.js",
//     deps: [
//         "PROTSYM_Alloc"
//     ]
// })

// // preprare PROTSYM
// genrule_script({
//     name: "in25cob2",
//     script_file: "scripts/in25cob2.js",
//     deps: [
//         "initPROTSYM"
//     ]
// });