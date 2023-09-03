// Project Name: Aixt project, https://gitlab.com/fermarsan/aixt-project.git
// File Name: file.v
// Author: Fernando Martínez Santa
// Date: 2023
// License: MIT
//
// Description: ast.File generation.
module aixt_cgen

import v.ast

fn (mut gen Gen) ast_file(node ast.File) string {
    mut out := '// This '
    out += if gen.setup.value('backend').string() == 'nxc' { 'NXC ' }  else { 'C ' }
    out += 'code was automatically generated by Aixt Project\n'
	out += '// Device = ${gen.setup.value('device').string()}\n'
	out += '// Board = ${gen.setup.value('board').string()}\n'
	out += '// Backend = ${gen.setup.value('backend').string()}\n\n' 
    for h in gen.setup.value('headers').array() {			// append the header files
        out +=  if h.string() != '' { '#include <${h.string()}>\n' } else { '' }
	}
    out += '\n'
	api_path := '${gen.base_path}/ports/${gen.setup.value('path').string()}/api'
    out += '#include "${api_path}/builtin.c"\n'
    for m in gen.setup.value('macros').array() { 			// append the macros
        out += if m.string() != '' { '#define ${m.string()}\n' } else { '' }
	}
    out += '\n'
    for c in gen.setup.value('configuration').array() {		// append the configuration lines
        out += '${gen.setup.value('config_operator').string()} ${c.string()}\n'    
	}
	for st in node.stmts {
		out += gen.ast_node(st)
	}
	return out
}