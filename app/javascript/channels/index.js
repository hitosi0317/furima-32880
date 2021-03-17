// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel..

const channels = require.context('.', true, /_channel\.$/)
channels.keys().forEach(channels)
