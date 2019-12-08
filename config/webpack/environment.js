const { environment } = require('@rails/webpacker');
const webpack = require('webpack');
const erb = require('./loaders/erb');

environment.loaders.append('erb', erb);

environment.plugins.prepend(
  'Provide',
  new webpack.ProvidePlugin({
    $: 'jquery',
    jQuery: 'jquery',
  }),
);

module.exports = environment;
