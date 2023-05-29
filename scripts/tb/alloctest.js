var mvs = require("mvs");
var fs = require("fs");
var os = require("bldz/os");
var files = require("bldz/std/exp/rules/files");

//define profile lib
var profileDSN = `${os.user()}.PUBLIC.PROFLIB`;


// function buildScript(params){
    console.log("DSN:" + profileDSN);

var allocretur = files.ds.alloc([
    {
        attributes : {
            dsn: profileDSN,
            lrecl: 6144,
            recfm: "F",
            blksize: 6144,
            // space: 
        },
        opts: {
            delete: true
        }
    }
    
]);

console.log("rule:" + allocretur);

// return {
//     rc: 0,
//     output: [
//         {
//             name: "sample alloc script",
//             content: "this is output for alloc script"
//         }
//     ]
// }

// }
