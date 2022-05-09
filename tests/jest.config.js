module.exports = {
    "roots": [
        "<rootDir>/src"
    ],
    "testMatch": [
        "**/__tests__/**/*.+(ts|tsx|js)",
        "**/?(*.)+(spec|test).+(ts|tsx|js)"
    ],
    "transform": {
        "^.+\\.(ts|tsx)$": "ts-jest"
    },
    "testTimeout": 130000,
    setupFilesAfterEnv: [
        '<rootDir>/jest.setup.js'
    ],
    transformIgnorePatterns: ["/node_modules/(?!@broadcom/test4z)"],
}