import math, strutils, parseutils

const OPERATORS = ["+", "-", "*", "/", "%", "mod", "^", "pow"]

proc eval*(input: string): float {.noSideEffect, extern: "evalMath".} =
    var
        operator: string
        a: string
        b: string 
        res: float = -99999

    for op in OPERATORS:
        if input.contains(op):
            operator = op
            let opLoc = input.find(op)
            
            a = input[0..opLoc-1].strip
            b = input[opLoc+op.len..high(input)].strip

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
        res = pow(eval(a), eval(b))
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
    var input: string
    while true:
        stdout.write(">>> ")
        
        try:
            input = stdin.readLine()
        except Exception:
            echo "Bye, bye!"
            quit(0)

        echo eval(input)