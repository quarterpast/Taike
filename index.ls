compact-obj = -> {[k,v] for k,v of it when v?}

col-name = (col, spec)->
	spec.column ? col

string-type = ({length}:spec)->
	| spec is String => \text
	| length?   => "varchar(#that)"
	| otherwise => \text

type = (spec)-> switch spec
	| Number   => \decimal
	| \integer => \int
	| Boolean  => \bit
	| String   => string-type spec

col-spec = (col, spec)-> compact-obj {
	property: col if spec.column?
	data-type: type spec
}

taike = (schema)->
	{[
		col-name col, spec
		compact-obj col-spec col, spec
	] for col, spec of schema}

taike.decorators = column: (column, obj)--> obj import {column}
bool-deco = (prop)-> taike.decorators[prop] = (import (prop):true)
<[ primary required unique autoincrement ]> .for-each bool-deco

module.exports = taike
