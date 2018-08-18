package lexer_test

import (
	"github.com/stbenjam/quade/lexer"
	. "github.com/stbenjam/quade/parser"
	"testing"
)

func TestTokens(t *testing.T) {
	expectTokens(t, "(", OpenParen)
	expectTokens(t, ")", CloseParen)
	expectTokens(t, ",", Comma)

	expectTokens(t, "_identifier", Identifier)
	expectTokens(t, "9number", Number, Identifier)
	expectTokens(t, "number9", Identifier)

	expectTokens(t, "t0", Temporary)
	expectTokens(t, "t01892", Temporary)
	expectTokens(t, "t99", Temporary)
	expectTokens(t, "t9a", Identifier)
	expectTokens(t, "t9,a", Temporary, Comma, Identifier)
	expectTokens(t, "t", Identifier)

	expectTokens(t, "(addSignedWord, t0, t1, t2)", OpenParen, OpAddSignedWord, Comma, Temporary, Comma, Temporary, Comma, Temporary, CloseParen)
}

func TestComments(t *testing.T) {
	expectTokens(t, "(  # (ignored, t0, t1, t2)", OpenParen)
}

func expectTokens(t *testing.T, input string, expectedTokens ...int) {
	tokenStream := lexer.Lex(input)

	for _, expectedToken := range expectedTokens {
		token := <-tokenStream
		if token.Type != expectedToken {
			t.Errorf("Did not receive expected token. Expected %s, got %s.  :-(", lexer.TokenString[expectedToken], lexer.TokenString[token.Type])
		}
	}

	received, ok := <-tokenStream

	if ok {
		t.Errorf("There are more tokens in the channel then expected.  Next token: %s", lexer.TokenString[received.Type])
	}
}
