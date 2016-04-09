/*****************************************************************************/
/* The first part deals with lexical analysis. Our lexical analyzer is very  */
/* simple, it can distinguish between consecutive tokens only if they are    */
/* separated by at least one space.                                          */
/*****************************************************************************/


/*****************************************************************************/
/* The lexical analyzer takes a string as its input and produces a list of   */
/* strings as its output. Suppose we would like to analyze the following     */
/* string: "begin a := 2 ; end . ". The lexical analyzer will produce the    */
/* following result: ["begin" , "a" , ":=" , "2" , ";" , "end" , "."], a     */
/* list containing all tokens, given that tokens are delimited by at least   */
/* one space.                                                                */
/*****************************************************************************/


/*****************************************************************************/
/* delete_initial_delimiters(InputString,Delimiter,OutputString).            */
/*****************************************************************************/
/* This predicate takes the 'InputString' string, removes all occurences of  */
/* the character 'Delimiter' from its beginning and returns the output in    */
/* the 'OutputString' string.                                                */
/*****************************************************************************/
delete_initial_delimiters([Delimiter|RemainingInputString],Delimiter,Result) :-
	delete_initial_delimiters(RemainingInputString,Delimiter,Result),
	!.

delete_initial_delimiters(InputString,_,InputString).
/*****************************************************************************/


/*****************************************************************************/
/* first_token(InputString,FirstToken,RemainingInputString).                 */
/*****************************************************************************/
/* This predicate takes the 'InputString' string and returns the first token */
/* in the variable 'FirstToken' and the remaining string after the removal   */
/* of the first token in the variable 'RemainingInputString'.		     */
/*****************************************************************************/
first_token(InputString,FirstToken,RemainingInputString) :-
	first_token(InputString,FirstToken,RemainingInputString,0' ).
/*****************************************************************************/


/*****************************************************************************/
/* first_token(InputString,FirstToken,RemainingInputString,Delimiter).       */
/*****************************************************************************/
/* This predicate behaves exactly like the previous one, only that in the    */
/* process of parsing tokens, it uses the 'Delimiter' character to separate  */
/* tokens from each other. As you can see, this predicate is called by the   */
/* previous one, with "0' " as the delimiter. The combination "0' " without  */
/* the quotation marks means 'SPACE' in PROLOG.                              */
/*****************************************************************************/
first_token(InputString,FirstToken,RemainingInputString,Delimiter) :-
	delete_initial_delimiters(InputString,Delimiter,NewInputString),
	append(FirstToken,[Delimiter|RemainingInputString],NewInputString),
	!.
/*****************************************************************************/


/*****************************************************************************/
/* tokens(InputString,ListOfTokens).                                         */
/*****************************************************************************/
/* This is the predicate that launches the lexical analysis. It takes the    */
/* 'InputString' string and produces a list with all the tokens encountered  */
/* within the input string.                                                  */
/*****************************************************************************/
tokens(InputString,[FirstToken|RemainingTokens]) :-
	first_token(InputString,FirstToken,RemainingInputString),
	!,
	tokens(RemainingInputString,RemainingTokens).

tokens(_,[]).
/*****************************************************************************/


/*****************************************************************************/
/* The second part deals with syntactic analysis. After the input string is  */
/* tokenized (atoms are separated from each other), we can test whether	or   */
/* not their succession respects all the rules in our grammar.               */
/*****************************************************************************/


/*****************************************************************************/
/* compound_instruction ->  BEGIN list_of_instructions END		     */
/*****************************************************************************/
compound_instruction(Tokens,RemainingTokens) :-
	Tokens = ["begin" | TokensAfterBegin],
	list_of_instructions(TokensAfterBegin,TokensAfterListOfInstructions),
	TokensAfterListOfInstructions = ["end" | RemainingTokens].
/*****************************************************************************/


/*****************************************************************************/
/* list_of_instructions -> instruction ; list_of_instructions | instruction  */
/*****************************************************************************/
% list_of_instructions -> instruction rest_of_list_of_instructions
list_of_instructions(Tokens,RemainingTokens) :-
	instruction(Tokens,TokensAfterInstruction),
	rest_of_list_of_instructions(TokensAfterInstruction,RemainingTokens).

/*****************************************************************************/
/* rest_of_list_of_instructions -> ; list_of_instructions | epsilon          */
/*****************************************************************************/
% rest_of_list_of_instructions -> ; list_of_instructions
rest_of_list_of_instructions(Tokens,RemainingTokens) :-
	Tokens = [";" | TokensAfterSemiColon],
	list_of_instructions(TokensAfterSemiColon,RemainingTokens).

% rest_of_list_of_instructions -> epsilon
rest_of_list_of_instructions(Tokens,RemainingTokens) :-
	RemainingTokens = Tokens.
/*****************************************************************************/


/*****************************************************************************/
/* instruction -> compound_instruction | assignment | if_then_else | epsilon */
/*****************************************************************************/
% instruction -> while
instruction(Tokens, RemainingTokens) :-
	while(Tokens,RemainingTokens).

% instruction -> for
instruction(Tokens, RemainingTokens) :-
	for(Tokens, RemainingTokens).

% instruction -> compound_instruction
instruction(Tokens,RemainingTokens) :-
	compound_instruction(Tokens,RemainingTokens).

% instruction -> assignment
instruction(Tokens,RemainingTokens) :-
	assignment(Tokens,RemainingTokens).

% instruction -> if_then_else
instruction(Tokens,RemainingTokens) :-
	if_then_else(Tokens,RemainingTokens).

% instruction -> epsilon
instruction(Tokens,RemainingTokens) :-
	RemainingTokens = Tokens.
/*****************************************************************************/

/*****************************************************************************/
/* while -> WHILE expression DO instructions                                 */
/*****************************************************************************/
while(Tokens,RemainingTokens) :-
	Tokens = ["while" | TokensAfterWhile],
	expression(TokensAfterWhile,TokensAfterExpression),
	TokensAfterExpression = ["do" | TokensAfterDo],
	instruction(TokensAfterDo,RemainingTokens).
/*****************************************************************************/


/*****************************************************************************/
/* while -> WHILE expression DO instructions                                 */
/*****************************************************************************/
for(Tokens,RemainingTokens) :-
	Tokens = ["for" | TokensAfterFor],
	TokensAfterFor = [Identifier, ":=" | TokensAfterFor],
	identifier(Identifier),
	expression(TokensAfterFor,TokensAfterExpression),
	direction(TokensAfterExpression, TokensAfterDirection),
	expression(TokensAfterDirection, TokensAfterForBody),
	TokensAfterForBody = ["do" | TokensAfterDo],
	instruction(TokensAfterDo, RemainingTokens).
/*****************************************************************************/


/*****************************************************************************/
/* assignment -> identifier := expression                                    */
/*****************************************************************************/
assignment(Tokens,RemainingTokens) :-
	Tokens = [Identifier, ":=" | TokensAfterAssignmentOperator],
	identifier(Identifier),
	expression(TokensAfterAssignmentOperator,RemainingTokens).
/*****************************************************************************/


/*****************************************************************************/
/* if_then_else -> IF expression THEN instruction ELSE instruction           */
/*****************************************************************************/
if_then_else(Tokens,RemainingTokens) :-
	Tokens = ["if" | TokensAfterIf],
	expression(TokensAfterIf,TokensAfterExpression),
	TokensAfterExpression = ["then" | TokensAfterThen],
	instruction(TokensAfterThen,TokensAfterInstruction),
	TokensAfterInstruction = ["else" | TokensAfterElse],
	instruction(TokensAfterElse,RemainingTokens).
/*****************************************************************************/


/*****************************************************************************/
/* expression -> term rest_of_expression                                     */
/*****************************************************************************/
expression(Tokens,RemainingTokens) :-
	term(Tokens,TokensAfterTerm),
	rest_of_expression(TokensAfterTerm,RemainingTokens).
/*****************************************************************************/


/*****************************************************************************/
/* rest_of_expression -> additive_operator term rest_of_expression | epsilon */
/*****************************************************************************/
% rest_of_expression -> additive_operator term rest_of_expression
rest_of_expression(Tokens,RemainingTokens) :-
	additive_operator(Tokens,TokensAfterAdditiveOperator),
	term(TokensAfterAdditiveOperator,TokensAfterTerm),
	rest_of_expression(TokensAfterTerm,RemainingTokens).

% rest_of_expression -> epsilon
rest_of_expression(Tokens,RemainingTokens) :-
	RemainingTokens = Tokens.
/*****************************************************************************/


/*****************************************************************************/
/* additive_operator -> + | -                                                */
/*****************************************************************************/
% additive_operator -> +
additive_operator(["+" | RemainingTokens],RemainingTokens).

% additive_operator -> -
additive_operator(["-" | RemainingTokens],RemainingTokens).
/*****************************************************************************/

/*****************************************************************************/
/* multiplicative_operator -> * | /                                          */
/*****************************************************************************/
% multiplicative_operator -> *
multiplicative_operator(["*" | RemainingTokens],RemainingTokens).

% additive_operator -> /
multiplicative_operator(["/" | RemainingTokens],RemainingTokens).
/*****************************************************************************/

/*****************************************************************************/
/* factor -> (expression) | identifier | number                              */
/*****************************************************************************/
% factor -> (expression)
factor(Tokens,RemainingTokens) :-
	Tokens = ["(" | TokensAfterOpeningBracket],
	expression(TokensAfterOpeningBracket,TokensAfterExpression),
	TokensAfterExpression = [")" | RemainingTokens].

% factor -> identifier
factor([Identifier | RemainingTokens],RemainingTokens) :-
	identifier(Identifier),!.

% factor -> number
factor([NumberAsString | RemainingTokens],RemainingTokens) :-
	number_chars(Number,NumberAsString),
	number(Number).

% number is a predefined predicate in PROLOG
% number_chars generates an error if the string doesn't contain a valid number
/*****************************************************************************/


/*****************************************************************************/
/* term -> (expression) | identifier | number                                */
/*****************************************************************************/
remaining_term(Tokens, RemainingTokens) :-
	multiplicative_operator(Tokens, TokensAfterOp),
	factor(TokensAfterOp, TokensAfterFactor),
	remaining_term(TokensAfterFactor, RemainingTokens).

remaining_term(Tokens,RemainingTokens) :-
	RemainingTokens = Tokens.

term(Tokens, RemainingTokens) :-
	factor(Tokens, RemainingTermAfterFactor),
	remaining_term(RemainingTermAfterFactor, RemainingTokens).

% term -> (expression)
term(Tokens,RemainingTokens) :-
	Tokens = ["(" | TokensAfterOpeningBracket],
	expression(TokensAfterOpeningBracket,TokensAfterExpression),
	TokensAfterExpression = [")" | RemainingTokens].

% term -> identifier
term([Identifier | RemainingTokens],RemainingTokens) :-
	identifier(Identifier),!.

% term -> number
term([NumberAsString | RemainingTokens],RemainingTokens) :-
	number_chars(Number,NumberAsString),
	number(Number).

% number is a predefined predicate in PROLOG
% number_chars generates an error if the string doesn't contain a valid number
/*****************************************************************************/


/*****************************************************************************/
/* identifier -> letter identifier | epsilon                                 */
/*****************************************************************************/
% identifier -> letter identifier
identifier([Letter | Remaining]) :-
	letter(Letter),
	identifier(Remaining).

% identifier -> epsilon
identifier([]).

% letter -> anything between 'a' and 'z'
letter(Letter) :-
	Letter >= 0'a,
	Letter =< 0'z.

% direction -> to | downto
direction(Tokens, RemainingTokens) :-
	Tokens = ["to" | RemainingTokens];
	Tokens = ["downto" | RemainingTokens].
/*****************************************************************************/


/*****************************************************************************/
/* This is the predicate that launches the syntactic analysis. After parsing */
/* a compound instruction from the input string and removing it, the input   */
/* string should look like "." and that is the meaning of the last line.     */
/*****************************************************************************/
valid_pascal_source(InputString) :-
	tokens(InputString,Tokens),
	compound_instruction(Tokens,["."]).
