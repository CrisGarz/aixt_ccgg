// Project Name: Aixt, https://github.com/fermarsan/aixt.git
// Author: Fernando Martínez Santa
// Date: 2023-2024
// License: MIT
module aixt_cgen

import v.ast

// hash_stmt: code generation for hash statements (C preprocessor).
fn (mut gen Gen) hash_stmt(node ast.HashStmt) string {
	// println('########### ${node.ct_conds} ###########')
	if node.kind == 'include' {
		if !gen.includes.contains(node.val) {
			gen.includes << '#${node.val}\n'
		}
	} else {
		gen.macros << '#${node.val}\n'
	}
	return ''
}