
;;; Code:
(require 'cc-defs)

;; From http://cc-mode.sourceforge.net/

;; imenu integration
(defvar cc-imenu-c-prototype-macro-regexp nil
  "RE matching macro names used to conditionally specify function prototypes.

For example:

    #ifdef __STDC__
      #define _P(x) x
    #else
      #define _P(x) /*nothing*/
    #endif

    int main _P( (int argc, char *argv[]) )

A sample value might look like: `\\(_P\\|_PROTO\\)'.")

;;			  *Warning for cc-mode developers*
;;
;; `cc-imenu-objc-generic-expression' elements depend on
;; `cc-imenu-c++-generic-expression'. So if you change this
;; expression, you need to change following variables,
;; `cc-imenu-objc-generic-expression-*-index',
;; too. `cc-imenu-objc-function' uses these *-index variables, in
;; order to know where the each regexp *group \\(foobar\\)* elements
;; are started.
;;
;; *-index variables are initialized during `cc-imenu-objc-generic-expression'
;; being initialized.
;;

(defvar cc-imenu-c++-generic-expression
  `(
    ;; Try to match ::operator definitions first. Otherwise `X::operator new ()'
    ;; will be incorrectly recognized as function `new ()' because the regexps
    ;; work by backtracking from the end of the definition.
    (nil
     ,(concat
       "^\\<.*"
       "[^" c-alnum "_:<>~]"		      ; match any non-identifier char
					      ; (note: this can be `\n')
       "\\("
	  "\\([" c-alnum "_:<>~]*::\\)?"      ; match an operator
	  "operator\\>[ \t]*"
	  "\\(()\\|[^(]*\\)"		      ; special case for `()' operator
       "\\)"

       "[ \t]*([^)]*)[ \t]*[^ \t;]"	      ; followed by ws, arg list,
					      ; require something other than
					      ; a `;' after the (...) to
					      ; avoid prototypes.  Can't
					      ; catch cases with () inside
					      ; the parentheses surrounding
					      ; the parameters.  e.g.:
					      ; `int foo(int a=bar()) {...}'
       ) 1)
    ;; Special case to match a line like `main() {}'
    ;; e.g. no return type, not even on the previous line.
    (nil
     ,(concat
       "^"
       "\\([" c-alpha "_][" c-alnum "_:<>~]*\\)" ; match function name
       "[ \t]*("			      ; see above, BUT
       "[ \t]*\\([^ \t(*][^)]*\\)?)"	      ; the arg list must not start
       "[ \t]*[^ \t;(]"			      ; with an asterisk or parentheses
       ) 1)
    ;; General function name regexp
    (nil
     ,(concat
       "^\\<"				      ; line MUST start with word char
       "[^()]*"				      ; no parentheses before
       "[^" c-alnum "_:<>~]"		      ; match any non-identifier char
       "\\([" c-alpha "_][" c-alnum "_:<>~]*\\)" ; match function name
       "\\([ \t\n]\\|\\\\\n\\)*("	      ; see above, BUT the arg list
       "\\([ \t\n]\\|\\\\\n\\)*"	      ; must not start
       "\\([^ \t\n(*]"			      ; with an asterisk or parentheses
       "[^()]*\\(([^()]*)[^()]*\\)*"	      ; Maybe function pointer arguments
       "\\)?)"
       "\\([ \t\n]\\|\\\\\n\\)*[^ \t\n;(]"
       ) 1)
    ;; Special case for definitions using phony prototype macros like:
    ;; `int main _PROTO( (int argc,char *argv[]) )'.
    ;; This case is only included if cc-imenu-c-prototype-macro-regexp is set.
    ;; Only supported in c-code, so no `:<>~' chars in function name!
    ,@(if cc-imenu-c-prototype-macro-regexp
	    `((nil
		 ,(concat
		   "^\\<.*"		      ; line MUST start with word char
		   "[^" c-alnum "_]"	      ; match any non-identifier char
		   "\\([" c-alpha "_][" c-alnum "_]*\\)" ; match function name
		   "[ \t]*"		      ; whitespace before macro name
		   cc-imenu-c-prototype-macro-regexp
		   "[ \t]*("		      ; ws followed by first paren.
		   "[ \t]*([^)]*)[ \t]*)[ \t]*[^ \t;]" ; see above
		   ) 1)))
    ;; Class definitions
    ("Class"
     ,(concat
	 "^"				      ; beginning of line is required
	 "\\(template[ \t]*<[^>]+>[ \t]*\\)?" ; there may be a `template <...>'
	 "\\(class\\|struct\\)[ \t]+"
	 "\\("				      ; the string we want to get
	 "[" c-alnum "_]+"		      ; class name
	 "\\(<[^>]+>\\)?"		      ; possibly explicitly specialized
	 "\\)"
	 "\\([ \t\n]\\|\\\\\n\\)*[:{]"
	 ) 3))
  "Imenu generic expression for C++ mode.  See `imenu-generic-expression'.")

(defvar cc-imenu-c-generic-expression
  cc-imenu-c++-generic-expression
  "Imenu generic expression for C mode.  See `imenu-generic-expression'.")

(provide 'cc-imenu)
;;; cc-imenu.el ends here
