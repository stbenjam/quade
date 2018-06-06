// Lexer based on Rob Pike's functional lexing approach
//     Source: https://talks.golang.org/2011/lex.slide

package main

import (
    "fmt"
    "unicode"
	"unicode/utf8"
)

type TokenType int

const (
	StartQuad TokenType = iota
	CloseQuad

	Temporary
	Identifier

	// Operations
	OpAddSigned
)

type Token struct {
	Type  TokenType
	Value string
}

type lexState func(*lexer) lexState

type lexer struct {
	input    string
	start    int
	position int
	tokens   chan Token
}

const eof = -1

func Lex(src string) chan Token {
	_, tokenStream := lex(src, startState)
	return tokenStream
}

func lex(src string, start lexState) (*lexer, chan Token) {
	l := &lexer{
		input:    src,
		start:    0,
		position: 0,
		tokens:   make(chan Token),
	}

	go l.run()
	return l, l.tokens
}

func startState(l *lexer) lexState {
	for {
		switch r := l.next(); r {
		case '(':
			l.emit(StartQuad)
			return insideQuadIR
		case '#', '`':
			return insideComment
		case ' ', '\t', '\n':
			continue
		case eof:
			break
		}
	}

	return nil
}

func insideComment(l *lexer) lexState {
	for {
		switch r := l.next(); r {
		default:
			continue
		case '\n':
			return startState
		case eof:
			return nil
		}
	}
}

func temporary(l *lexer) lexState {
    l.emit(Temporary)
    return nil
}

func insideQuadIR(l *lexer) lexState {
	for {
		switch r := l.next(); r {
		case eof:
			return l.err("unexpected eof")
		case ')':
			l.emit(CloseQuad)
			return startState
		case 't':
			if n := l.peek(); unicode.IsDigit(n) {
				return temporary
			}

			return nil 
			// case digit
			//      return number
			// case default
			//      return identifierOrOperation
		}
	}
}

func (l *lexer) run() {
	for state := startState; state != nil; {
		state = state(l)
	}

	close(l.tokens)
}

func (l *lexer) emit(token TokenType) {
	l.tokens <- Token{token, l.input[l.start:l.position]}
	l.start = l.position
}

func (l *lexer) next() (rune) {
	if l.position > len(l.input) {
		return eof
	}

	r, width := utf8.DecodeRuneInString(l.input[l.position:])
	l.position += width
	return r
}

func (l *lexer) peek() (rune) {
    r := l.next()
	l.position -= utf8.RuneLen(r)
	return r
}

func (l *lexer) unput(r rune) {
    l.position -= utf8.RuneLen(r)
}

func (l *lexer) err(msg string) (lexState) {
    fmt.Println(msg)
    return nil
}
