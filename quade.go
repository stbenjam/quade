//go:generate goyacc -o parser/parser.go parser/parser.y

package main

import (
    "github.com/stbenjam/quade/lexer"
    "github.com/stbenjam/quade/parser"
    "flag"
    "fmt"
    "io/ioutil"
    "log"
    "os"
)

func main() {
    //output := flag.String("output", "STDOUT", "Write output to a file")
    flag.Parse()

    if(len(flag.Args()) == 0) {
        flag.Usage()
        os.Exit(1)
    }

    buf, err := ioutil.ReadFile(flag.Args()[0])
    if(err != nil) {
        log.Fatal(err)
    }

    tokenStream := lexer.Lex(string(buf))
    for token := range tokenStream {
        log.Print(fmt.Sprintf("RECEIVED TOKEN: %s\n", parser.TokenName(token.Type)))
    }
}
