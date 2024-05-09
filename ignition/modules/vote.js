const { buildModule } = require("@nomicfoundation/hardhat-ignition/modules");

const VotoCoin = buildModule("VotoCoin", (m) => {
  const votocoin = m.contract("VotoCoin");

  return { votocoin };
});

module.exports = VotoCoin;
