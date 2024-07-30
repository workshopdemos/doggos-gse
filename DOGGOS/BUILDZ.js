////////////////////////////////////////////////////////////////////////////////
// validate that the required version of bldz is installed
require("./scripts/version").requires("1.43.5");

////////////////////////////////////////////////////////////////////////////////
// rule that groups everything under a single target "all"
genrule_usscmd({
    name: "all",
    exec: "",
    deps: [
        "//COBOL:copyLoad",
        "//COBOL:reportPROTSYM"
    ]
});
