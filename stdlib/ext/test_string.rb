


/*
 *  call-seq:
 *     str[index]                 -> new_str or nil
 *     str[start, length]         -> new_str or nil
 *     str[range]                 -> new_str or nil
 *     str[regexp]                -> new_str or nil
 *     str[regexp, capture]       -> new_str or nil
 *     str[match_str]             -> new_str or nil
 *     str.slice(index)           -> new_str or nil
 *     str.slice(start, length)   -> new_str or nil
 *     str.slice(range)           -> new_str or nil
 *     str.slice(regexp)          -> new_str or nil
 *     str.slice(regexp, capture) -> new_str or nil
 *     str.slice(match_str)       -> new_str or nil
*/
s = 'abcdefghijklmnopqrstuvwxyz'
s[0]
s[1]
s[-1]

s[0,3]
s[1,3]

s[1..3]

s[/\w/]
s[/\w+/]
s[/\w{3}/]
s[/abc(?<xx>\w{3})/, 'xx']
s['xyz']




/*
 *  call-seq:
 *     str[fixnum] = new_str
 *     str[fixnum, fixnum] = new_str
 *     str[range] = aString
 *     str[regexp] = new_str
 *     str[regexp, fixnum] = new_str
 *     str[regexp, name] = new_str
 *     str[other_str] = new_str
*/


