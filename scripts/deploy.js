async function main() {
    const Voting = await ethers.getContractFactory("Voting");

    //start deployment
    const voting = await Voting.deploy(["Claudia Sheinbaum", "Bertha Xochitl", "Jorge Alvarez"],60);
    console.log("Contrato desplegado para la dirección:", voting.address);
    

}

main()
.then(() => process.exit(0))
.catch(error => {
    console.error(error);
    process.exit(1);
});