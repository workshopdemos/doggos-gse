const {
  toBeSuccessfulResult,
  toBeHaveTestData,
  toBeSuccessful,
} = require("test/Test4zMatchers");
expect.extend({
  toBeHaveTestData,
  toBeSuccessfulResult,
  toBeSuccessful,
});
