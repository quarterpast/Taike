compact-obj = -> {[k,v] for k,v of it when v?}
compact = -> [x for x in it when x?]

col-name = (col, spec)->
	spec.column ? col

string-type = ({size})->
	| size?     => "varchar(#size)"
	| otherwise => \text

type = ({type}:spec)->
	if (switch type ? spec
		| Number    => \decimal
		| \integer  => \int
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

taike = (schema)-> {[
	col-name col, spec
	compact-obj col-spec col, spec
] for col, spec of schema}

taike.decorators =
	column: (column, obj)--> obj import {column}
	size:   (size,   obj)--> obj import {size}
bool-deco = (prop)-> taike.decorators[prop] = (import (prop):true)
<[ primary required unique autoincrement ]> .for-each bool-deco
taike.decorators.id = taike.decorators.primary . taike.decorators.autoincrement

module.exports = taike
