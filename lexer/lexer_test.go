package lexer_test

import (
	"github.com/stbenjam/quade/lexer"
	"testing"
)

func TestTokens(t *testing.T) {
	expectTokens(t, "(", lexer.OpenParen)
	expectTokens(t, ")", lexer.CloseParen)
	expectTokens(t, ",", lexer.Comma)

	expectTokens(t, "_identifier", lexer.Identifier)
	expectTokens(t, "9number", lexer.Number, lexer.Identifier)
	expectTokens(t, "number9", lexer.Identifier)

	expectTokens(t, "t0", lexer.Temporary)
	expectTokens(t, "t01892", lexer.Temporary)
	expectTokens(t, "t99", lexer.Temporary)
	expectTokens(t, "t9a", lexer.Identifier)
	expectTokens(t, "t9,a", lexer.Temporary, lexer.Comma, lexer.Identifier)
	expectTokens(t, "t", lexer.Identifier)

	expectTokens(t, "(addSignedWord, t0, t1, t2)", lexer.OpenParen, lexer.OpAddSignedWord, lexer.Comma, lexer.Temporary, lexer.Comma, lexer.Temporary, lexer.Comma, lexer.Temporary, lexer.CloseParen)
}

func TestComments(t *testing.T) {
    expectTokens(t, "(  # (ignored, t0, t1, t2)", lexer.OpenParen)
}

func expectTokens(t *testing.T, input string, expectedTokens ...lexer.TokenType) {
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
