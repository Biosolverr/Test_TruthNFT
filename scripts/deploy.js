const hre = require("hardhat");

async function main() {
  const [deployer] = await hre.ethers.getSigners();
  console.log("Deployer:", deployer.address);

  const TruthNFT = await hre.ethers.getContractFactory("TruthNFT");
  const nft = await TruthNFT.deploy();
  await nft.waitForDeployment();

  const address = await nft.getAddress();
  console.log("TruthNFT:", address);

  for (let tokenId = 1; tokenId <= 5; tokenId++) {
    const uri = `https://YOUR-VERCEL-DOMAIN.vercel.app/metadata/${tokenId}.json`;
    const tx = await nft.setTokenURI(tokenId, uri);
    await tx.wait();
    console.log(`Token ${tokenId} URI set: ${uri}`);
  }

  console.log("\nReplace YOUR-VERCEL-DOMAIN with your actual Vercel domain and rerun the URI loop if needed.");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
