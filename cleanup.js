const spawnSync = require('child_process').spawnSync;
const path = require("path");

const proc = spawnSync('bash', [path.join(__dirname, 'cleanup.sh')], {stdio: 'inherit'});
process.exit(proc.status)