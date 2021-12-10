import math, strutils, parseutils

const OPERATORS = ["+", "-", "*", "/", "%", "mod", "^", "pow"]

func eval*(input: string): float {.extern: "evalMath".} =
    ##[
        Evaluates `input` as a basic mathematical term.
        Following operators are allowed:
            `+`, `-`, `*`, `/`, `%`, `mod`, `^`, `pow`
    ]##

    var
        operator: string
        a: string
        b: string 
        res: float

    for op in OPERATORS:
        if input.contains(op):
            operator = op
            let opLoc = input.find(op)
            
            a = input[0..opLoc-1].strip
            b = input[opLoc+op.len..^1].strip

            break

    case operator
    of "+":
        res = eval(a) + eval(b)
    of "-":
        res = eval(a) - eval(b)
    of "*":
        res = eval(a) * eval(b)
    of "/":
        res = eval(a) / eval(b)
    of "%", "mod":
        res = eval(a) mod eval(b)
    of "^", "pow":
        res = eval(a).pow eval(b)
    else:
        case input.strip.toLower
        of "pi":
            res = PI
        of "e":
            res = E
        of "tau":
            res = TAU
        else:
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