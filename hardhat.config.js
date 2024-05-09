/** @type import('hardhat/config').HardhatUserConfig */
require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-ethers");
require("@nomicfoundation/hardhat-ignition-ethers");
const dotenv = require("dotenv");

dotenv.config();

module.exports = {
	networks: {
		sepolia: {
			url: "https://rpc-sepolia.rockx.com",
			accounts: [`0x${process.env.PRIVATE_KEY}`],
			gas: 210000000,
			gasPrice: 800000000000
		},
	},
	solidity: "0.8.24",
};

