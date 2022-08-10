const CFT = artifacts.require("./CFT");
const FlexibilityDP = artifacts.require("./FlexibilityDP");
const ActivationRequest = artifacts.require("./ActivationRequest");
const Bid = artifacts.require("./Bid");

contract("Open a call for tenders", (accounts) => {
  before(async () => {

    this.cft = await CFT.new(
      "0xfAC5784E8cFE5b1E22edb226DA9d5b109A10757B",
      "0xfAC5784E8cFE5b1E22edb226DA9d5b109A10757B",
      10,
      1658966400,
      1659139200,
      "A"
    );

  });

  it("deploys successfully", async () => {

    const address = await this.cft.address;
    const cftDetails = await this.cft.getCFTDetails();
    console.log(cftDetails);
    assert.notEqual(address, 0x0);
    assert.notEqual(address, "");
    assert.notEqual(address, null);
    assert.notEqual(address, undefined);

  });

  it("2 activation requests is submitted", async () => {
    const AR1 = await this.cft.createActivationRequest(
      "0xfAC5784E8cFE5b1E22edb226DA9d5b109A10757B",
      2,
      1658970000
    );
    const AR2 = await this.cft.createActivationRequest(
      "0xfAC5784E8cFE5b1E22edb226DA9d5b109A10757B",
      2,
      1658970000
    );
    const ARList = await this.cft.getAllARs();
    console.log(ARList);
    assert.notEqual(ARList.length, 0);

  });

  it("Two Bids are submitted", async () => {

    const bid1 = await this.cft.createBid(
      "0x2bB80E81A8Ebf3CDDE72bb495833726b70a55FDc",
      "AQ",
      1,
      1,
      "*",
      1658970000
    );

    const bid2 = await this.cft.createBid(
      "0xDf1f7A02F48eFAF89C7397A92F369A4D5f5Cc8CF",
      "AQ",
      1,
      1,
      "*",
      1658970000
    );

    const bidList = await this.cft.getAllBids();
    console.log(bidList);
    assert.notEqual(bidList.length, 0);

  });

  it("One delivery period is created", async () => {

    const arl = await this.cft.setCurrentARL(1658966400, 1658973600);
    const mol = await this.cft.setCurrentMOL(1658966400, 1658973600);
    const filtered_arl = await this.cft.filter();
    const DP = await this.cft.createFlexibilityDP();
    const DPList = await this.cft.getAllDPs();
    console.log(DPList);
    assert.notEqual(DPList.length, 0);
    
  });

  it("There is two activation orders", async () => {

    const DPList = await this.cft.getAllDPs();
    const instance = await FlexibilityDP.at(DPList[0]);
    const h = await instance.dispatch();
    const ao = await instance.getAllActivationOrders();
    console.log(ao);
    assert.equal(ao.length, 2);
    
  });

});
