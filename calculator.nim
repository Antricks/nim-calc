import math, strutils, parseutils, tables

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

func eval*(input: string): float {.extern: "evalMath".} =
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
                res = function(eval(a), eval(b))
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

        echo eval(input)