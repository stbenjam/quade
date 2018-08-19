package parser_test

import (
    "github.com/stbenjam/quade/parser"
    "testing"
)

func TestTokName(t *testing.T) {
    tokName := parser.TokenName(parser.OpProcBegin)
    expected := "OpProcBegin"
    if tokName != expected {
        t.Errorf("Did not receive expected token string value. Expected %s, got %s. :-(", expected, tokName)
    }
}
