// Lexer for Quade based on Rob Pike's functional lexing approach
// Source: https://talks.golang.org/2011/lex.slide
package lexer

import (
	"fmt"
	"log"
	"unicode"
	"unicode/utf8"
)

type TokenType int

const (
	Error TokenType = iota
	StartQuad
	CloseQuad

	Temporary
	Identifier

	// Operations
	OpAddSigned
)

var TokenString = map[TokenType]string{
	Error:     `Error`,
	StartQuad: `StartQuad`,
	CloseQuad: `CloseQuad`,

	Temporary:   `Temporary`,
	Identifier:  `Identifier`,
	OpAddSigned: `OpAddSigned`,
}

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

const Debug = 1
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

	debug("Starting lexer")

	go l.run()
	return l, l.tokens
}

func startState(l *lexer) lexState {
	debug("STATE: Start")

	for {
		r := l.next()
		switch r {
		case '(':
			l.emit(StartQuad)
			return insideQuadIR
		case '#', '`':
			return insideComment
		case ' ', '\t', '\n':
			continue
		case eof:
			return nil
		}
	}

	return nil
}

func insideComment(l *lexer) lexState {
	debug("STATE: Inside Comment")

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
	debug("STATE: Temporary")

	l.emit(Temporary)
	return nil
}

func insideQuadIR(l *lexer) lexState {
	debug("STATE: Inside Quad IR")

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
	debug("Running...")

	for state := startState; state != nil; {
		state = state(l)
	}

	close(l.tokens)
	debug("Done")
}

func (l *lexer) emit(token TokenType) {
	value := l.input[l.start:l.position]

	debug(fmt.Sprintf("Token: %s, Value: %s", TokenString[token], value))

	l.tokens <- Token{token, value}
	l.start = l.position
}

func (l *lexer) next() rune {
	r, width := utf8.DecodeRuneInString(l.input[l.position:])

	if r == utf8.RuneError {
		return eof
	}

	l.position += width
	return r
}

func (l *lexer) peek() rune {
	r := l.next()
	l.position -= utf8.RuneLen(r)
	return r
}

func (l *lexer) unput(r rune) {
	l.position -= utf8.RuneLen(r)
}

func (l *lexer) err(msg string) lexState {
	l.tokens <- Token{Error, msg}
	l.start = l.position
	return nil
}

func debug(msg string) {
	if Debug != 1 {
		return
	}

	log.Printf(msg)
}
