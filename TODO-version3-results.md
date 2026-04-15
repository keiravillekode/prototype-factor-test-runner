# TODO: Upgrade to version 3 test results

The cleanest approach to version 3 results wouldn't parse Factor's stdout at all — it would write a custom Factor word that runs tests programmatically and outputs JSON directly. Factor's `tools.test` internals (`test-failures`, the test case structure) are accessible. A small Factor script could iterate test cases, run each one, catch errors, and build a JSON results array. That avoids fragile text parsing entirely.
