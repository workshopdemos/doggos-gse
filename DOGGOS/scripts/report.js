var mvs = require("bldz/mvs");
var fs = require("bldz/fs");
// var ws = require("bldz/workspace");
var dd = require("bldz/std/exp/utils/dd")
var os = require("bldz/os")
var process = require("bldz/process")
process.setenv("_BPXK_JOBLOG", "STDERR");


function buildScript(params){

var dsn = `${os.user()}.PUBLIC.PROTSYM`;
// dd.alloc("dd", {
//     attributes: {
//         dsntype: "LIBRARY",
//         // pathmode: 
//     }
// })

// var listings = ws.getDepsProperty("object_out_file")
// listings = listings.map(function(list) {
//     return path.changeExt(list, "list");
// })

var pgm = "IN25UTIL";

console.log("--- IN25UTIL ---");
console.log("- - - ---- - - -");

// allocations
// PROTSYM - point to the dataset
//mvs.
if (fs.dsExists(dsn))
        mvs.bpxwdyn("ALLOC FI(PROTSYM) DA(" + dsn + ") SHR MSG(1)");
// else allocate

// INPUT - point to listing (try path first)

// dd.alloc("INPUT", {
//     attributes: {
//         pathdisp: "KEEP",
//         pathopts: "ORDONLY",
//         recfm: "FBA",
//         lrecl: 133,
//         path: "/a/janmi04/vega/doggos/GSECONF/DOGGOS/build-out/COBOL/DOGGOS.CBL.list",
//         filedata: "TEXT",
//     }
// });

// CARDS - parameters
// var cardInput = [
//     "PASSWORD=12345678",                          
//     "INITIALIZE,MAXPGMVER=1",                     
//     "REPORT"        
// ]

var cardInput = [
    "PASSWORD=12345678",                          
    "INITIALIZE,MAXPGMVER=1",                     
    "REPORT"        
]

mvs.bpxwdyn("ALLOC FI(CARDS) RECFM(F,B) LRECL(80) SPACE(5,1) CYL MSG(2)");
fs.write("//DD:CARDS", cardInput.join("\n"));

// OUTPUT - SYSOUT
mvs.bpxwdyn("ALLOC FI(OUTPUT) LRECL(133) RECFM(F,B,A) BLKSIZE(3990) SPACE(5,1)");
// mvs.bpxwdyn("ALLOC FI(OUTPUT) SYSOUT LRECL(133) RECFM(F,B,A) BLKSIZE(3990)");

// MESSAGE - SYSOUT
mvs.bpxwdyn("ALLOC FI(MESSAGE) SYSOUT");

// dd.alloc("MESSAGE", {
//     type: "stderr" 
// })
// mvs.bpxwdyn("ALLOC FI(MESSAGE) LRECL(133) RECFM(F,B) BLKSIZE(3990) SPACE(5,1)");

var in25utilRC = mvs.attach(pgm);

// console.log(fs.read("//DD:OUTPUT"));
// console.log("------------------  MESSAGE -----------------");
// console.log(fs.read("//DD:MESSAGE"));

// console.log("**** IN25UTIL end **** RC = " + in25cob2RC);

return {
    rc: in25utilRC,
    output: [
        {
            name: "IN25UTIL init/report",
            content: fs.read("//DD:OUTPUT")
        }
    ]
};
}