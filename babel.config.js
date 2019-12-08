const presetEnv = require('@babel/preset-env');
const pluginMacros = require('babel-plugin-macros');
const pluginSyntaxDynamicImport = require(
  '@babel/plugin-syntax-dynamic-import',
);
const pluginDynamicImportNode = require(
  'babel-plugin-dynamic-import-node',
);
const pluginTransformDestructuring = require(
  '@babel/plugin-transform-destructuring',
);
const pluginProposalClassProperties = require(
  '@babel/plugin-proposal-class-properties',
);
const pluginProposalObjectRestSpread = require(
  '@babel/plugin-proposal-object-rest-spread',
);
const pluginTransformRuntime = require(
  '@babel/plugin-transform-runtime',
);
const pluginTransformRegenerator = require(
  '@babel/plugin-transform-regenerator',
);

module.exports = (api) => {
  const validEnv = ['development', 'test', 'production'];
  const currentEnv = api.env();
  const isDevelopmentEnv = api.env('development');
  const isProductionEnv = api.env('production');
  const isTestEnv = api.env('test');

  if (!validEnv.includes(currentEnv)) {
    throw new Error(
      `${'Please specify a valid `NODE_ENV` or '
        + '`BABEL_ENV` environment variables. Valid values are "development", '
        + '"test", and "production". Instead, received: '}${
        JSON.stringify(currentEnv)
      }.`,
    );
  }

  return {
    presets: [
      isTestEnv && [
        presetEnv.default,
        {
          targets: {
            node: 'current',
          },
        },
      ],
      (isProductionEnv || isDevelopmentEnv) && [
        presetEnv.default,
        {
          forceAllTransforms: true,
          useBuiltIns: 'entry',
          corejs: 3,
          modules: false,
          exclude: ['transform-typeof-symbol'],
        },
      ],
    ].filter(Boolean),
    plugins: [
      pluginMacros,
      pluginSyntaxDynamicImport.default,
      isTestEnv && pluginDynamicImportNode,
      pluginTransformDestructuring.default,
      [
        pluginProposalClassProperties.default,
        {
          loose: true,
        },
      ],
      [
        pluginProposalObjectRestSpread.default,
        {
          useBuiltIns: true,
        },
      ],
      [
        pluginTransformRuntime.default,
        {
          helpers: false,
          regenerator: true,
          corejs: false,
        },
      ],
      [
        pluginTransformRegenerator.default,
        {
          async: false,
        },
      ],
    ].filter(Boolean),
  };
};
