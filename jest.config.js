module.exports = {
  "coverageDirectory": "coverage-js",
  "coverageReporters": [
    "cobertura",
    "html",
    "text"
  ],
  "moduleDirectories": [
    "app/assets",
    "node_modules"
  ],
  "reporters": [
    "default",
    "jest-junit"
  ],
  "roots": [
    "app/assets"
  ]
};
