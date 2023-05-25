var mvs = require("bldz/mvs");
var fs = require("bldz/fs");

var pgm = "IDCAMS";
var sysinInput = [
    " DELETE JANMI04.PUBLIC.PROTSYM CLUSTER PURGE"
]

mvs.bpxwdyn("ALLOC FI(SYSIN) RECFM(F,B) LRECL(80) SPACE(5,1) CYL MSG(2)");
mvs.bpxwdyn("ALLOC FI(SYSPRINT) LRECL(133) RECFM(F,B,A) SPACE(5,1)");

fs.write("//DD:SYSIN", sysinInput.join("\n"));

var idcamsRC = mvs.attach(pgm);

console.log(fs.read("//DD:SYSPRINT"));
console.log("PROTSYM DS deleted!!! RC = " + idcamsRC);