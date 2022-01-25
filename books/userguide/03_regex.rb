
=begin
[]	 range specificication (e.g., [a-z] means a letter in the range a to z)
\w	 word character; same as [0-9A-Za-z_]
\W	 non-word character
\s	 space character; same as [ \t\n\r\f]
\S	 non-space character
\d	 digit character; same as [0-9]
\D	 non-digit character
\b	 backspace (0x08) (only if in a range specification)
\b	 word boundary (if not in a range specification)
\B	 non-word boundary
*	 zero or more repetitions of the preceding
+	 one or more repetitions of the preceding
{m,n}	 at least m and at most n repetitions of the preceding
?	 at most one repetition of the preceding; same as {0,1}
|	 either preceding or next expression may match
()	 grouping
=end


#"Contains a hexadecimal number enclosed in angle brackets"?
def chab(s)
(s =~ /<0(x|X)(\d|[a-f]|[A-F])+>/) != nil
end

puts chab "Not this one."
puts chab "Maybe this? {0x35}"  # wrong kind of bracket
puts chab "Or this? <0x38z7e>"  #bogus hex digit
puts chab "Okay, this: <0xfc004>."

#"=~" is a matching operator with respect to regular expressions; it returns the position in a string where a match was found, or nil if the pattern did not match.

puts "abcdef" =~ /d/
puts "aaaaa" =~ /d/
