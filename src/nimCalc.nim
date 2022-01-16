#[
MIT License

Copyright (c) 2021 Antricks

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]#

import math, strutils, tables
from parseutils import parseFloat

## A calculator exporting a function to evaluate basic mathematical terms

type ParseError* = object of CatchableError ## An error while parsing

const
    OPERATORS = {
        "+": func(a: float, b: float): float = a + b,
        "-": func(a: float, b: float): float = a - b,
        "*": func(a: float, b: float): float = a * b,
        "/": func(a: float, b: float): float = a / b,
        "%": func(a: float, b: float): float = a mod b,
        "mod": func(a: float, b: float): float = a mod b,
        "^": func(a: float, b: float): float = a.pow(b),
        "pow": func(a: float, b: float): float = a.pow(b),
        "log": func(a: float, b: float): float = log(a, b)
    }.toTable

    CONSTANTS = {
        "pi": PI,
        "e": E,
        "tau": TAU
    }.toTable


func evalTerm*(input: string): float {.extern: "evalTerm".} =
    ##[
        Evaluates the string `input` as a basic mathematical term.

        * Following **operators** can be used: `+`, `-`, `*`, `/`, `%`, `mod`, `^`, `pow`, `log`

          (Where `%` and `mod` are equivalent and `^` and `pow` are equivalent)

        * Following **constants** can be used: `PI`, `E`, `TAU`

        **Note**: Brackets are not yet implemented but are WIP
    ]##

    var
        operator: string = ""
        a: string
        b: string 
        res: float

    let term: string = input.strip.toLower

    for op in OPERATORS.keys:
        if term.contains(op):
            operator = op
            let opPos = term.find(op)
            
            a = term[0..opPos-1].strip
            b = term[opPos+op.len..^1].strip

            break

    block evaluate:
        # no brackets
        for op, function in OPERATORS.pairs:
            if op == operator:
                res = function(a.evalTerm, b.evalTerm)
                break evaluate

        # no operators
        for c in CONSTANTS.keys:
            if c == term:
                res = CONSTANTS[term]
                break evaluate

        if term.parseFloat(res) == 0 and term.len > 0:
            raise newException(ParseError, "Error parsing '" & term & "'")
        else:
            break evaluate

    return res


when isMainModule:
    proc bye() {.noconv.} =
        echo "Bye, bye!"
        quit(0)
    
    setControlCHook(bye)

    var input: string
    
    while true:
        stdout.write(">>> ")
        
        try:
            input = stdin.readLine()
        except Exception:
            bye()

        try:
            echo input.evalTerm
        except ParseError:
            echo getCurrentExceptionMsg()