# Stripe2qif


Converts Stripe balance transactions to QIF format (primarily) for uploading to FreeAgent.

    usage:  stripe2qf [OPTIONS] <apikey>
      Output qif for up to 100 stripe transactions.

      --help, -h              Display this message
      --until DATE            Display transactions up to, and including, this date. yyyy-mm-dd
      --tito                  Truncate descriptions before the word "ticket" to make FreeAgent explanations easier

The Tito option is all about FreeAgent transaction explanations - when running conferences from [Tito](https://ti.to/home) it is much easier if the descriptions match so that tickets for a single can be explained in one go.

Stripe fees for each ticket are added as a separate transaction, for correct VAT processing - VAT should be paid on the ticket before the Stripe fees are deducted.

Note that only 100 transactions are downloaded at a time. It should be possible to automate downloding all matching transactions with multiple requests, but this is not currently implemented.

# Build

Assuming you're [set up for Elixir](http://elixir-lang.org/getting_started/1.html), clone

    mix test
    mix escript.build

# Download and run

1. Make sure you have [Erlang installed](http://www.erlang.org/doc/installation_guide/INSTALL.html). On a Mac with Homebrew _brew install erlang_ should do the trick.
2. [Download](https://github.com/paulanthonywilson/stripe2qif/releases/download/v0.3.0/stripe2qif) and stick on the path.


