// Lexer for Quade
//   Based on Rob Pike's functional lexing approach
//   Source: https://talks.golang.org/2011/lex.slide

package lexer

import (
	"fmt"
	. "github.com/stbenjam/quade/parser"
	"log"
	"unicode"
	"unicode/utf8"
)

type Token struct {
	Type  int
	Value string
}

type yySymType Token

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
		switch {
		case r == '(':
			l.emit(OpenParen)
			return startState
		case r == ')':
			l.emit(CloseParen)
			return startState
		case r == ',':
			l.emit(Comma)
			return startState
		case r == '#':
			return insideComment
		case r == 't':
			if n := l.peek(); unicode.IsDigit(n) {
				return temporary
			}
			return identifierOrOperation
		case r == ' ' || r == '\t' || r == '\n':
			continue
		case unicode.IsLetter(r) || r == '_':
			return identifierOrOperation
		case r == eof:
			return nil
		case unicode.IsDigit(r):
			return number
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

FOR:
	for {
		r := l.next()

		switch {
		case r == eof:
			break FOR
		case unicode.IsLetter(r) || r == '_':
			// Oops this is an identifierOrOperation
			return identifierOrOperation
		case !unicode.IsDigit(r):
			l.unput(r)
			break FOR
		}
	}

	l.emit(Temporary)
	return startState
}

func identifierOrOperation(l *lexer) lexState {
	debug("STATE: Identifier or Operation")

	for {
		r := l.next()

		if r == eof {
			break
		}

		if !(unicode.IsLetter(r) || unicode.IsDigit(r) || r == '_') {
			l.unput(r)
			break
		}
	}

	switch l.value() {
	case "addressOf":
		l.emit(OpAddressOf)
	case "loadWord":
		l.emit(OpLoadWord)
	case "loadHalfWord":
		l.emit(OpLoadHalfWord)
	case "loadSignedHalfWord":
		l.emit(OpLoadSignedHalfWord)
	case "loadByte":
		l.emit(OpLoadByte)
	case "loadSignedByte":
		l.emit(OpLoadSignedByte)
	case "storeWord":
		l.emit(OpStoreWord)
	case "storeHalfWord":
		l.emit(OpStoreHalfWord)
	case "storeByte":
		l.emit(OpStoreByte)
	case "multSignedWord":
		l.emit(OpMultSignedWord)
	case "multUnsignedWord":
		l.emit(OpMultUnsignedWord)
	case "divSignedWord":
		l.emit(OpDivSignedWord)
	case "divUnsignedWord":
		l.emit(OpDivUnsignedWord)
	case "remSignedWord":
		l.emit(OpRemSignedWord)
	case "remUnsignedWord":
		l.emit(OpRemUnsignedWord)
	case "addSignedWord":
		l.emit(OpAddSignedWord)
	case "addUnsignedWord":
		l.emit(OpAddUnsignedWord)
	case "subSignedWord":
		l.emit(OpSubSignedWord)
	case "subUnsignedWord":
		l.emit(OpSubUnsignedWord)
	case "leftShiftWord":
		l.emit(OpLeftShiftWord)
	case "rightShiftSignedWord":
		l.emit(OpRightShiftSignedWord)
	case "rightShiftUnsignedWord":
		l.emit(OpRightShiftUnsignedWord)
	case "ltSignedWord":
		l.emit(OpLtSignedWord)
	case "ltUnsignedWord":
		l.emit(OpLtUnsignedWord)
	case "leSignedWord":
		l.emit(OpLeSignedWord)
	case "leUnsignedWord":
		l.emit(OpLeUnsignedWord)
	case "geSignedWord":
		l.emit(OpGeSignedWord)
	case "geUnsignedWord":
		l.emit(OpGeUnsignedWord)
	case "gtSignedWord":
		l.emit(OpGtSignedWord)
	case "gtUnsignedWord":
		l.emit(OpGtUnsignedWord)
	case "eqWord":
		l.emit(OpEqWord)
	case "neWord":
		l.emit(OpNeWord)
	case "bitwiseAndWord":
		l.emit(OpBitwiseAndWord)
	case "bitwiseXorWord":
		l.emit(OpBitwiseXorWord)
	case "bitwiseOrWord":
		l.emit(OpBitwiseOrWord)
	case "unaryMinus":
		l.emit(OpUnaryMinus)
	case "unaryLogicalNegation":
		l.emit(OpUnaryLogicalNegation)
	case "unaryBitwiseNegation":
		l.emit(OpUnaryBitwiseNegation)
	case "constInt":
		l.emit(OpConstInt)
	case "castWordToHalfWord":
		l.emit(OpCastWordToHalfWord)
	case "castWordToByte":
		l.emit(OpCastWordToByte)
	case "castHalfWordToUnsignedWord":
		l.emit(OpCastHalfWordToUnsignedWord)
	case "castHalfWordToSignedWord":
		l.emit(OpCastHalfWordToSignedWord)
	case "castByteToUnsignedWord":
		l.emit(OpCastByteToUnsignedWord)
	case "castByteToSignedWord":
		l.emit(OpCastByteToSignedWord)
	case "label":
		l.emit(OpLabel)
	case "goto":
		l.emit(OpGoto)
	case "gotoIfFalse":
		l.emit(OpGotoIfFalse)
	case "gotoIfTrue":
		l.emit(OpGotoIfTrue)
	case "phi":
		l.emit(OpPhi)
    case "procBegin":
        l.emit(OpProcBegin)
    case "procEnd":
        l.emit(OpProcEnd)

	default:
		l.emit(Identifier)
	}

	return startState
}

func number(l *lexer) lexState {
	debug("STATE: Number")

	for {
		r := l.next()

		if r == eof {
			break
		}

		if !(unicode.IsDigit(r) || r == 'x') {
			l.unput(r)
			break
		}
	}

	l.emit(Number)
	return startState
}

func (l *lexer) run() {
	debug("Running...")

	for state := startState; state != nil; {
		state = state(l)
	}

	close(l.tokens)
	debug("Done")
}

func (l *lexer) value() string {
	return l.input[l.start:l.position]
}

func (l *lexer) emit(token int) {
	debug(fmt.Sprintf("Token: %s, Value: %s", TokenName(token), l.value()))

	l.tokens <- Token{token, l.value()}
	l.start = l.position
}

func (l *lexer) next() rune {
	if l.position > len(l.input) {
		l.position -= 1
		return eof
	}

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
