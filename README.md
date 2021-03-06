# nimCalc

A calculator exporting a function to evaluate basic mathematical terms

## Procs

```nim
func evalTerm(input: string): float {.extern: "evalTerm",
                                      raises: [KeyError, ParseError], tags: [].}
```

Evaluates the string `input` as a basic mathematical term.

* Following operators can be used: `+`, `-`, `*`, `/`, `%`, `mod`, `^`, `pow`

    (Where `%` and `mod` are equivalent and `^` and `pow` are equivalent)

* Following constants can be used: `PI`, `E`, `TAU`

* Brackets are not yet implemented but are WIP

## Nimble tasks

* `docgen`: Generate HTML documentation
* `runCalc`: Run calculator
