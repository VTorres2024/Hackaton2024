const { ethers } = require("hardhat");


async function main()
{
	const VotoCoin = await ethers.getContractFactory('VotoCoin');
	const Urna = await ethers.getContractFactory('Urna');

	const votocoin = await VotoCoin.attach("0x5FbDB2315678afecb367f032d93F642f64180aa3");
	const urna1 = await Urna.deploy(1715247040, 1715420440, ["op1", "op2", "op3"], votocoin);

	await urna1.waitForDeployment();
	console.log("Contrato urna @", await urna1.getAddress());

	return { urna1 };
}

main()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error);
		process.exit(1);
	});
