##Flexibility backend

Requirements :
    Install Ganache desktop : 
        Windows : https://trufflesuite.com/ganache/
        Linux : Follow steps in https://www.edureka.co/community/39540/how-to-install-ganache-on-linux
    Install Metamask wallet extension : 
        Firefox : https://addons.mozilla.org/fr/firefox/addon/ether-metamask/ 
        Google Chrome : https://metamask.io/
    Install git commands : 
        Linux : `sudo apt install git-all`
        Windows : Go to https://git-scm.com/download/win 

I - Clone this repository and install dependencies :
    1. `git clone (Flexibility-backend repository)`
    2 - `npm install`

II - Create a local Ethereum network and run the project
    1 - Open Ganache.
    2 - Create new workspace.
    3 - Click on "add project".
    4 - Import truffle-config.js file from this repository.
    5 - Run `truffle migrate`. (In case it doesn't work try : `npx truffle migrate`).

III - Once you ran the project, you can track all the transactions and block created in Ethernal dashboard.
Open Ethernal dashboard :
    1 - Go to https://app.tryethernal.com and sign up
    2 - Import the project link : HTTP://127.0.0.1:8545 with network Id : 5777
    3 - Go to repository terminal
    4 - run `ethernal login` (In case it doesn't work try : `sudo npx ethernal login`).
    5 - enter credentials : Email and password (same as you used when signing up).
    6 - run `ethernal listen`.

Follow steps in Flexibility-frontend repository to start the user interface.

 