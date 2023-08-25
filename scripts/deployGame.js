const hre = require('hardhat');

async function main() {

  const Game = await hre.ethers.getContractFactory(
    'G20240911BillsJets',
  );

  const name = "G20240911BillsJets"
  const symbol = "GBJ"

  const game = await Game.deploy(
    name,
    symbol
  );

  await game.waitForDeployment();

  console.log(`game deployed to ${await game.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});