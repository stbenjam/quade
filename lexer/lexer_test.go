package lexer_test

import (
    "fmt"
	"github.com/stbenjam/quade/lexer"
	"testing"
)

func TestBadInput(t *testing.T) {
    validateLexerReturnsToken(t, "bad input", lexer.Error)
}

func TestTokens(t *testing.T) {
    validateLexerReturnsToken(t, "(", lexer.StartQuad)
}


func validateLexerReturnsToken(t *testing.T, input string, expectedToken lexer.TokenType) {
	tokenStream := lexer.Lex(input)
	token := <-tokenStream

	if token.Type != expectedToken {
        t.Errorf(fmt.Sprintf("Did not receive expected token. Expected %s, got %s.  :-(", lexer.TokenString[expectedToken], lexer.TokenString[token.Type]))
	}
}
