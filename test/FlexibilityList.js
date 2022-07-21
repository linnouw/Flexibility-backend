const FlexibilityList = artifacts.require("./FlexibilityList");

contract("FlexibilityList", (accounts) => {
  before(async () => {
    this.flexibilityList = await FlexibilityList.deployed();
  });

  it("deploys successfully", async () => {
    const address = await this.flexibilityList.address;
    assert.notEqual(address, 0x0);
    assert.notEqual(address, "");
    assert.notEqual(address, null);
    assert.notEqual(address, undefined);
  });

  it("there is two products: mFRR and aFRR", async () => {
    const mFRR = await this.flexibilityList.createProduct(
      accounts[2],
      "3JP",
      "mFRR",
      "card",
      "-",
      50
    );
    const aFRR = await this.flexibilityList.createProduct(
      accounts[2],
      "2KL",
      "aFRR",
      "card",
      "+",
      12
    );
    const productsList = await this.flexibilityList.getAllProducts();
    assert.equal(productsList.length, 2);
  });

  it("there are no CFTs", async () => {
    const cftsList = await this.flexibilityList.getAllCFTs();
    assert.equal(cftsList.length, 0);
  });

  it("there is one CFT", async () => {
    //create mFRR product
    const productsList = await this.flexibilityList.getAllProducts();
    const newCFT = await this.flexibilityList.createCFT(
      accounts[0],
      productsList[0],
      30,
      1657179695,
      1657266095,
      "A"
    );
    const cftsList = await this.flexibilityList.getAllCFTs();
    assert.equal(cftsList.length, 1);
  });

  it("there are 2 CFTs", async () => {
    //create aFRR product
    const productsList = await this.flexibilityList.getAllProducts();
    const newCFT = await this.flexibilityList.createCFT(
      accounts[1],
      productsList[1],
      30,
      1657179695,
      1657266095,
      "B"
    );
    const cftsList = await this.flexibilityList.getAllCFTs();
    assert.equal(cftsList.length, 2);
  });
});
