## Flexibility backend

### Requirements
1 - Install Ganache desktop : <br />
Windows : https://trufflesuite.com/ganache <br />
Linux : Follow steps in https://www.edureka.co/community/39540/how-to-install-ganache-on-linux  <br />
2 - Install Metamask wallet extension : <br />
Firefox : https://addons.mozilla.org/fr/firefox/addon/ether-metamask <br />
Google Chrome : https://metamask.io <br />
3 - Install git commands :  <br />
Linux : `sudo apt install git-all`. <br />
Windows : Go to https://git-scm.com/download/win  <br />

### I - Clone this repository and install dependencies :
1 - `git clone (Flexibility-backend repository)`. <br />
2 - `npm install` . <br />

### II - Create a local Ethereum network and run the project 
1 - Open Ganache. <br />
2 - Create new workspace. <br />
3 - Click on "add project". <br />
4 - Import truffle-config.js file from this repository. <br />
5 - Run `truffle migrate`. (In case it doesn't work try : `npx truffle migrate`). <br />

### III - Once you ran the project, you can track all the transactions and block created in Ethernal dashboard.
Open Ethernal dashboard : <br />
1 - Go to https://app.tryethernal.com and sign up. <br />
2 - Import the project link : HTTP://127.0.0.1:8545 with network Id : 5777. <br />
3 - Go to repository terminal. <br />
4 - run `ethernal login` (In case it doesn't work try : `sudo npx ethernal login`). <br />
5 - enter credentials : Email and password (same as you used when signing up). <br />
6 - run `ethernal listen`. <br />

Follow steps in Flexibility-frontend repository to start the user interface.

 