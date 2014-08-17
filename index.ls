empty-obj = (.length is 0) . Object.keys
compact-obj = -> {[k,v] for k,v of it when v? and (v.length or not empty-obj v)}
compact = -> [x for x in it when x?]

col-name = (col, spec)->
	spec.column ? col

string-type = ({size})->
	| size?     => "varchar(#size)"
	| otherwise => \text

type = ({type}:spec)->
	if (switch type ? spec
		| Number    => \decimal
		| \integer  => \integer
		| Boolean   => \bit
		| String    => string-type spec)
	then ([that] ++ extras spec) .join " "

extras = ({primary, required, unique, autoincrement})->
	compact [
		"primary key"   if primary
		"not null"      if required and not primary
		"unique"        if unique   and not primary
		"autoincrement"	if autoincrement
	]

col-spec = (col, spec)-> compact-obj {
	property: col if spec.column?
	data-type: type spec
}

taike = (schema)-> compact-obj {[
	col-name col, spec
	col-spec col, spec
] for col, spec of schema}

taike.decorators =
	column: (column, obj)--> obj import {column}
	size:   (size,   obj)--> obj import {size}

bool-deco = (prop)->
	taike.decorators[prop] = (obj)->
		(if typeof obj is \object then obj else type:obj) import (prop):true

<[ primary required unique autoincrement ]> .for-each bool-deco

module.exports = taike
