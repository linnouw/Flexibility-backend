module.exports = {
  /*rpc:{
    host: "localhost",
    port: 8545,
  },*/
  networks: {
    //geth private blockchain
    /*development: {
      host: "localhost",
      port: 8545,
      network_id: "14333", // Match any network id
      from: "0x3D4051972De86902E121e166217BeEf93D57B6Ca",
      },
    */

      //ganache
      development: {
        host: "localhost",
        port: 8545,
        network_id: "*", // Match any network id
        gas: "8003929",
      },
  },
  compilers: {
    solc: {
      version: "^0.8.0",
      settings: {
        optimizer: {
          enabled: true, // Default: false
          runs: 200, // Default: 200
        },
      },
    },
  },
};
