var files = require("bldz/std/exp/rules/files");
var os = require("bldz/os");
var fs = require("bldz/fs");

var properties = JSON.parse(fs.read("properties.json"));
var copybookDSN = `${os.user()}.DOGGOS.COPYBOOK`;
var profileDSN = `${os.user()}.PUBLIC.PROFLIB`;

// create data set rules (for copybooks)
var dataset_rules = files.ds.alloc([
    {
        attributes: {
            dsn: copybookDSN,
            lrecl: 80,
            recfm: "F,B",
            dsorg: "PO",
            dsntype: "LIBRARY",
            blksize: 6160,
            vol: properties.volser
        },
        opts: {
            delete: true
        }
    }
]);

// create rule to copy copybooks to data set
files.ds.copy({
    dsn: copybookDSN,
    deps: dataset_rules.rules,
    binary: false,
    files: "COPY/*.CPY"
});


// create PROFLIB for Intertest debug session
files.ds.alloc([
    {
        attributes : {
            space_units: "CYL",
            dsn: profileDSN,
            lrecl: 6144,
            recfm: "F",
            dsorg: "PO",
            blksize: 6144,
            space: [6, 2],
            dir: 3

        },
        opts: {
            delete: true
        }
    }
]);

