# Stripe2qif


Converts Stripe balance transactions to QIF format (primarily) for uploading to FreeAgent.

    usage:  stripe2qf [OPTIONS] <apikey>
      Output qif for up to 100 stripe transactions.

      --help, -h              Display this message
      --from DATE             Display transactions from the date
      --tito                  Truncate descriptions before the word "ticket" to make FreeAgent explanations easier

The Tito option is all about FreeAgent transaction explanations - when running conferences from [Tito](https://ti.to/home) it is much easier if the descriptions match so that tickets for a single can be explained in one go.

Stripe fees for each ticket are added as a separate transaction, for correct VAT processing - VAT should be paid on the ticket before the Stripe fees are deducted.

Note that only 100 transactions are downloaded at a time. It should be possible to automate downloding all matching transactions with multiple requests, but this is not currently implemented.


