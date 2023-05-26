var mvs = require("bldz/mvs");
var fs = require("bldz/fs");
var os = require("bldz/os");
// var ws = require("bldz/workspace");
var dd = require("bldz/std/exp/utils/dd")
var process = require("bldz/process")
process.setenv("_BPXK_JOBLOG", "STDERR");


function buildScript(params){
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

var pgm = "IN25COB2";

console.log("--- IN25COB2 ---");
console.log("- - - ---- - - -");

// allocations
// PROTSYM - point to the dataset
var protsymdsn = `${os.user()}.PUBLIC.PROTSYM`;
console.log("PROTSYM = " + protsymdsn); 

// if (fs.dsExists("JANMI04.PUBLIC.PROTSYM"))  //TODO parametrize ds name
//         mvs.bpxwdyn("ALLOC FI(PROTSYM) DA(JANMI04.PUBLIC.PROTSYM) SHR MSG(1)");
if (fs.dsExists(protsymdsn))  //TODO parametrize ds name
        mvs.bpxwdyn("ALLOC FI(PROTSYM) DA(" + protsymdsn + ") SHR MSG(1)");
// else allocate and initialize

// INPUT - point to listing (try path first)

//TODO parametrize listings
dd.alloc("INPUT", {
    attributes: {
        pathdisp: "KEEP",
        pathopts: "ORDONLY",
        recfm: "FBA",
        lrecl: 133,
        path: "/a/janmi04/vega/doggos/GSECONF/DOGGOS/build-out/COBOL/DOGGOS.CBL.list",
        filedata: "TEXT",
    }
});

// CARDS - parameters
// parametrize member
var cardInput = [
    "DOGGOS,LISTER=ALL,CUTPRINT=ALL"
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

var in25cob2RC = mvs.attach(pgm);

// console.log(fs.read("//DD:OUTPUT"));
// console.log("------------------  MESSAGE -----------------");
// console.log(fs.read("//DD:MESSAGE"));

console.log("**** IN25COB2 end **** RC = " + in25cob2RC);

return {
    rc: in25cob2RC,
    output: [
        {
            name: "IN25COB2 symbol processing",
            content: fs.read("//DD:OUTPUT")
        }
    ]
};

}
