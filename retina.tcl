# the idea behind retina is to create a semantic map of the entire text by feeding in the entire text to this module
# that way I can later reference a particular word, a particular phrase or sentance
# that should return the following:
  # 1. a similarity score.
  # 2. key words extraction.
  # 3. a possible proximity score if semantic similarity isn't good enough.

# conceptual steps:
  # 1. chop up the text starting at 2 word pairs and going up to paragraphs or chapers.
  # 2. Reorganize each and every word-size-level according to levenshtein distance or  alllcs.
    # a. do this by finding the most common substring or the most common longest substring. or rather...
    # a. do this by finding the context which has the highest score with the most other contexts and place that one in the middle of the grid. or...
    # a. do this by taking the first context in the list and placing it at the beginning... OR RATHER....
    # a. Don't do this at all. Since its comming from a text book we can assume its already organized in a semantic logical way.
  # 3. build semantic maps of each word and each collection of words at every level of contextual representation.

#  Official Retina: http://www.cortical.io/static/downloads/semantic-folding-theory-white-paper.pdf
#  • Definition	of	a	reference	text	corpus	of	documents	that	represents	the	Semantic
#  Universe the	system	is	supposed	to	work	in.	The	system	will	know	all	vocabulary
#  and	its	practical	use	as	it	occurs	in	this	Language	Definition	Corpus	(LDC).
#  • Every	document	from	the	LDC	is	cut	into	text	snippets	with	each	snippet
#  representing	a	single	context.
#  • The	reference	collection	snippets	are	distributed	over	a	2D	matrix	(e.g.	128x128
#  bits)	in	a	way	that	snippets	with	similar	topics	(that	share	many	common	words)
#  are	placed	closer	to	each	other	on	the	map,	and	snippets	with	different	topics
#  (few	common	words)	are	placed	more	distant	to	each	other	on	the	map.	That
#  produces	a	2D	semantic	map.
#  • In	the	next	step, a	list	of	every	word contained	in	the	reference	corpus is	created.
#  • By	going	down	this	list	word	by	word,	all	the	contexts	a	word	occurs	in	are	set	to
#  1	in	the	corresponding	bit-position	of	a	2D	mapped	vector.	This	produces	a	large,
#  binary,	very	sparsely	filled	vector	for	each	word.	This	vector	is	called	the
#  Semantic	Fingerprint of	the	word.	The	structure	of	the	2D	map	(the	Semantic
#  Universe) is	therefore	“folded	into”	each	representation	of	a	word	(Semantic
#  Fingerprint).	The	list	of	words	with	their	fingerprints	is	stored	in	a	database that
#  is	indexed	to	allow	for	fast	matching.	The	system	that	converts	a	given	word	into
#  a	fingerprint	is	called	Retina, as	it	acts	as	a	“sensorial	organ	for	text”.	The
#  fingerprint	database	is	called	Retina Database (Retina	DB).



# Reorganize brainstorm: contexts:
# lets say having the same letters in the wrong order is +1,
# in the same order is +1
#---------------------
#     ab  ac  yz  zy  cy  cz  xx  xy  zx
# ab  4
# ac  2   4
# yz  0   0   4
# zy  0   0   2   4
# cy  0   1   1   2   4
# cz  0   1   2   1   2   4
# xx  0   0   0   0   0   0   4
# xy  0   0   1   2   2   0   2   4
# zx  0   0   1   2   0   1   2   1   4
#---------------------
# might produce something like this:
# xx  xy  cy
# yz  zy  cz
# zx  ab  ac
#---------------------
# why try to stuff it into a 2d surface? no real need right? just keep it in the multi-dimentional grid like above.
# anyway.

# to query this database for question and answers you might have this:
# 1. determine the approapriate size of the context level.
# 2. get the top 4% contexts of matching by alllcs.
# 3. take that 4% SDR and find the word in the database that matches that SDR best. (out of your options).

# the goal with the aboves strategy is to create a robust way to filter noise.
# noise as in "Of the following ... which ... ?" in other words the parts of the question.
# its trying to match the definition to a set of contexts, not trying to understand the question. 
