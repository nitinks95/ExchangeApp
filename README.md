# Exchange.Umbrella

Read real time data from Coinbase websocket about the incoming requests to the exchange for buy and sell orders of Bitcoin using Aggregator. Phoenix Live view server refreshes the stats every 5sec using genserver. Both these applications are bundled under a single umbrella project.

## Usage

* Git clone the repo
* Fetch the dependencies and compile the app
`mix do deps.get, deps.compile, compile`
* Build and release the app
`MIX_ENV=prod mix release exchange`
* Start the application and get the live update which refreshes every 5 sec
`_build/prod/rel/exchange/bin/exchange start`
