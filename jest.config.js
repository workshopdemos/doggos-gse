module.exports = {
  roots: ["<rootDir>/test"],
  testMatch: [
    "**/__tests__/**/*.+(ts|tsx|js)",
    "**/?(*.)+(spec|test).+(ts|tsx|js)",
  ],
  transform: {
    "^.+\\.(ts|tsx)$": "ts-jest",
  },
  testTimeout: 130000,
  transformIgnorePatterns: ["/node_modules/(?!@broadcom/test4z)"],
};
