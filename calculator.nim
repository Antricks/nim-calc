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

const
    OPERATORS = {
        "+":    func(a: float, b: float): float = a + b,
        "-":    func(a: float, b: float): float = a - b,
        "*":    func(a: float, b: float): float = a * b,
        "/":    func(a: float, b: float): float = a / b,
        "%":    func(a: float, b: float): float = a mod b,
        "mod":  func(a: float, b: float): float = a mod b,
        "^":    func(a: float, b: float): float = a.pow(b),
        "pow":  func(a: float, b: float): float = a.pow(b)
    }.toTable

    CONSTANTS = {
        "pi": PI,
        "e": E,
        "tau": TAU
    }.toTable

func evalTerm*(input: string): float {.extern: "evalTerm".} =
    ##[
        Evaluates `input` as a basic mathematical term.
        Following operators are allowed:
            `+`, `-`, `*`, `/`, `%`, `mod`, `^`, `pow`
    ]##

    var
        operator: string = ""
        a: string
        b: string 
        res: float

    for op in OPERATORS.keys:
        if input.contains(op):
            operator = op
            let opLoc = input.find(op)
            
            a = input[0..opLoc-1].strip
            b = input[opLoc+op.len..^1].strip

            break

    block getResult:
        for op, function in OPERATORS.pairs:
            if op == operator:
                res = function(a.evalTerm, b.evalTerm)
                break getResult

        for c in CONSTANTS.keys:
            if c == input.strip.toLower:
                res = CONSTANTS[input.strip.toLower]
                break getResult
        
        discard input.parseFloat(res)

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

        echo input.evalTerm