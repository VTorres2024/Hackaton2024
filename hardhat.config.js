/** 
 * @type import('hardhat/config').HardhatUserConfig
 * 
 */

require("@dotenv").comfig();
require("@nomiclabs/hardhat-ethers");

const {API_URL, PRIVATE_KEY} = process.env;

module.exports = {
  solidity: "0.8.0",
  defaultNetwork: "volta",
  networks: {
    hardhat: {},
    ropsten: {
      url: API_URL,
      account: [`${PRIVATE_KEY}`]

    }

  },
}
