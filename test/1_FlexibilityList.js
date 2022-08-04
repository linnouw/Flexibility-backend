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
    const productsList = await this.flexibilityList.getAllProducts();
    console.log(productsList);
    assert.equal(productsList.length, 2);
  });

  it("Open one call for tenders", async () => {
    const cft = await this.flexibilityList.createCFT( "0xfAC5784E8cFE5b1E22edb226DA9d5b109A10757B",
    "0xfAC5784E8cFE5b1E22edb226DA9d5b109A10757B",
    10,
    1658966400,
    1659139200,
    "A");
    const cfts = await this.flexibilityList.getAllCFTs();
    console.log(cfts);
    assert.notEqual(cfts.length, 0);
  })
});
