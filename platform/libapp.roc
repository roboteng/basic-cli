app "stub"
    packages { pf: "main.roc" }
    imports [pf.Task.{ Task }]
    provides [main] to pf

# Throw an error here so we can easily confirm the host 
# executable built correctly just by running it.
#
# e.g. 
# ```
# $ ./target/debug/host 
# Program exited early with error: JustAStub
# ```
main = Task.err (JustAStub)
