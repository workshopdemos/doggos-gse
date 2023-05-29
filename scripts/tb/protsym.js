var mvs = require("bldz/mvs");
var fs = require("bldz/fs");
var path = require("bldz/path");
var logger = require("bldz/logger");
var os = require("bldz/os")

function buildScript(params){

var dsn = `${os.user()}.PUBLIC.PROTSYM`;
console.log(dsn);
var pgm = "IDCAMS";
var sysinInput = [
    " DELETE protsymds CLUSTER PURGE"
].join("\n");

sysinInput = sysinInput.replace("protsymds", dsn);

mvs.bpxwdyn("ALLOC FI(SYSIN) RECFM(F,B) LRECL(80) SPACE(5,1) CYL MSG(2)");
mvs.bpxwdyn("ALLOC FI(SYSPRINT) LRECL(133) RECFM(F,B,A) SPACE(5,1)");

fs.write("//DD:SYSIN", sysinInput);

var idcamsRC = mvs.attach(pgm);

console.log(fs.read("//DD:SYSPRINT"));
console.log("PROTSYM DS deleted!!! RC = " + idcamsRC);

mvs.bpxwdyn("FREE FI(SYSIN)");
mvs.bpxwdyn("FREE FI(SYSPRINT)");
// mvs.bpxwdyn("FREE FI(MESSAGE)");
// mvs.bpxwdyn("FREE FI(CARDS)");

console.log("******* IDCAMS ******");
console.log("*     VSAM ALLOC    *");

var sysinInput = [
    " SET MAXCC=0",
        " DEFINE CLUSTER (NAME(protsymds)              -",
        "               REC(10000)                                  -",
        "               CISZ(2048)       /* DO NOT CHANGE */        -",
        "                RECSZ(2040 2040)                           -",
        "                SHR(4 4)                                   -",
        "                NUMBERED)                                  -",
        "       DATA (NAME(protsymds.DATA))"
].join("\n");

while(sysinInput.search("protsymds") != -1) {
    sysinInput = sysinInput.replace("protsymds", dsn);
}

mvs.bpxwdyn("ALLOC FI(SYSIN) RECFM(F,B) LRECL(80) SPACE(5,1) CYL MSG(2)");
mvs.bpxwdyn("ALLOC FI(SYSPRINT) LRECL(133) RECFM(F,B,A) SPACE(5,1)");
fs.write("//DD:SYSIN", sysinInput);

var idcamsRC = mvs.attach(pgm);

return {
    rc: idcamsRC,
    output: [
        {
            name: "PROTSYM allocation",
            content: fs.read("//DD:SYSPRINT")
        }
    ]
};

}