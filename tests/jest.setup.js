const {toBeSuccessfulResult, toBeHaveTestData, toBeSuccessful} = require("./src/test/Test4zMatchers")
expect.extend({
    toBeHaveTestData,
    toBeSuccessfulResult,
    toBeSuccessful
});