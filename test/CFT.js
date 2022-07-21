const CFT = artifacts.require("./CFT");
const FlexibilityDP = artifacts.require("./FlexibilityDP");
const ActivationRequest = artifacts.require("./ActivationRequest");
const ActivationOrder = artifacts.require("./ActivationOrder");

contract("CFT", (accounts) => {
  before(async () => {
    this.cft = await CFT.new(
      "0x5FB5fC13237326bB9c1437D926AD25e47e132B63",
      "0x5FB5fC13237326bB9c1437D926AD25e47e132B63",
      30,
      1657179695,
      1657266095,
      "A"
    );
  });

  it("deploys successfully", async () => {
    const address = await this.cft.address;
    assert.notEqual(address, 0x0);
    assert.notEqual(address, "");
    assert.notEqual(address, null);
    assert.notEqual(address, undefined);
  });

  it("There is no bids", async () => {
    const bids = await this.cft.getAllBids();
    assert.equal(bids.length, 0);
  });

  it("There is no activation requests", async () => {
    const AR = await this.cft.getAllARs();
    assert.equal(AR.length, 0);
  });

  it("There is no Delivery Period", async () => {
    const DPs = await this.cft.getAllDPs();
    assert.equal(DPs.length, 0);
  });

  it("there is one activation request", async () => {
    const AR = await this.cft.createActivationRequest(
      "0x5FB5fC13237326bB9c1437D926AD25e47e132B63",
      30,
      1657179699
    );
    const ARList = await this.cft.getAllARs();
    assert.notEqual(ARList.length, 0);
  });

  it("there is one bid", async () => {
    const bid = await this.cft.createBid(
      "0x0C56eb408fa0cA8aBe002ca71ab0d4acB70dDb0B",
      "AQ",
      2,
      13,
      "A",
      1657179700
    );
    const bidList = await this.cft.getAllBids();
    assert.notEqual(bidList.length, 0);
  });

  it("there are two activation requests", async () => {
    const AR = await this.cft.createActivationRequest(
      "0x5FB5fC13237326bB9c1437D926AD25e47e132B63",
      30,
      1657179699
    );
    const ARList = await this.cft.getAllARs();
    console.log(ARList);
    assert.equal(ARList.length, 2);
  });

  it("there are two bids", async () => {
    const bid = await this.cft.createBid(
      "0x0C56eb408fa0cA8aBe002ca71ab0d4acB70dDb0B",
      "AQ",
      1,
      10,
      "A",
      1657179700
    );
    const bidList = await this.cft.getAllBids();
    console.log(bidList);
    assert.equal(bidList.length, 2);
  });

  it("there is one delivery period", async () => {
    const DP = await this.cft.createFlexibilityDP(1657179695);
    const DPList = await this.cft.getAllDPs();
    const ARL = await this.cft.getARL();
    const MOL = await this.cft.getMOL();
    console.log(ARL);
    console.log(MOL);
    console.log(DPList);
    assert.notEqual(DPList.length, 0);
  });

  it("There are no activation orders", async () => {
    const DPList = await this.cft.getAllDPs();
    const instance = await FlexibilityDP.at(DPList[0]);

    const ao = await instance.getAllActivationOrders();
    assert.equal(ao.length, 0);
  });

  it("There is one activation order", async () => {
    const DPList = await this.cft.getAllDPs();
    const instance = await FlexibilityDP.at(DPList[0]);

    const task = await instance.dispatch();
    const ao = await instance.getAllActivationOrders();
    const aoInstance = await ActivationOrder.at(ao[0]);
    const details = await aoInstance.acceptOrder();
    console.log(details);
  });
});
