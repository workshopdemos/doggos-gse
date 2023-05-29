var mvs = require("bldz/mvs");
var fs = require("bldz/fs");
//var path = require("bldz/path");
var logger = require("bldz/logger");

var pgm = "IDCAMS";
console.log("******* IDCAMS ******");
console.log("*   VSAM ALLOC      *");

logger.trace("test");

var sysinInput = [
    " SET MAXCC=0",
        " DEFINE CLUSTER (NAME(JANMI04.PUBLIC.PROTSYM)              -",
        "               REC(10000)                                  -",
        "               CISZ(2048)       /* DO NOT CHANGE */        -",
        "                RECSZ(2040 2040)                           -",
        "                SHR(4 4)                                   -",
        "                NUMBERED)                                  -",
        "       DATA (NAME(JANMI04.PUBLIC.PROTSYM.DATA))"
]

mvs.bpxwdyn("ALLOC FI(SYSIN) RECFM(F,B) LRECL(80) SPACE(5,1) CYL MSG(2)");
mvs.bpxwdyn("ALLOC FI(SYSPRINT) LRECL(133) RECFM(F,B,A) SPACE(5,1)");

fs.write("//DD:SYSIN", sysinInput.join("\n"));

var idcamsRC = mvs.attach(pgm);

console.log(fs.read("//DD:SYSPRINT"));
console.log("done!!!" + idcamsRC);