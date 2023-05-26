var process = require("bldz/process")

/**
 * Compare two versions.
 *
 * If first version is bigger, it returns `1`,
 * if it's lower then it returns `-1` and if
 * they are the same, it returns `0`.
 *
 * If missing part of version it's considered lower:
 * ```
 * compare("1.2", "1.2.0") // output: -1
 * ```
 *
 * @param {string} ver_a first version to compare
 * @param {string} ver_b second version to compare
 */
function compare(ver_a, ver_b) {
    var parts_a = ver_a.split(".")
    var parts_b = ver_b.split(".")
    var numeric = /^[0-9]+$/

    function cmpIdent(a, b) {
        var anum = numeric.test(a)
        var bnum = numeric.test(b)
        if (anum && bnum) {
            a = +a
            b = +b
        }
        return a === b ? 0
            : (anum && !bnum) ? 1
                : (bnum && !anum) ? -1
                    : a < b ? -1
                        : 1
    }

    return (
        cmpIdent(parts_a[0], parts_b[0]) ||
        cmpIdent(parts_a[1], parts_b[1]) ||
        cmpIdent(parts_a[2], parts_b[2])
    )
}

/**
 * Checks if the current bldz version is equal to or greater than the required 
 * version. If not, throws an error. 
 * @param {string} required the required version (e.g. 1.1.0)
 */
function requires(required) {
    if (compare(process.version, required) < 0)
        throw new Error(`'bldz' version '${required}' or greater required to run this build.`);
}

////////////////////////////////////////////////////////////////////////////////
// exports
exports.compare = compare;
exports.requires = requires;