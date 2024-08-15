import { buildModule } from "@nomicfoundation/hardhat-ignition/modules";

const DeploymentModule = buildModule("DeploymentModule", (m) => {
  // Deploy the SupplyMateNFT contract
  const SupplyMateNFT = m.contract("SupplyMateNFT", [m.getAccount(0)]); // Pass initial owner as the first account

  return { SupplyMateNFT };
});

export default DeploymentModule;
