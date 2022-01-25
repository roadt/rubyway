# -*- coding: utf-8 -*-

=begin

Chapter 7. Classes and Modules

We've seen that Ruby is a very dynamic language; you can insert new methods into classes at runtime, create aliases for existing methods, and even define methods on individual objects. In addition, it has a rich API for reflection. Reflection, also called introspection, simply means that a program can examine its state and its structure. A Ruby program can, for example, obtain the list of methods defined by the Hash class, query the value of a named instance variable within a specified object, or iterate through all Regexp objects currently defined by the interpreter. The reflection API actually goes further and allows a program to alter its state and structure. A Ruby program can dynamically set named variables, invoke named methods, and even define new classes and new methods. 

Ruby's reflection API—along with its generally dynamic nature, its blocks-and-iterators control structures, and its parentheses-optional syntax—makes it an ideal language for metaprogramming. Loosely defined, metaprogramming is writing programs (or frameworks) that help you write programs. To put it another way, metaprogramming is a set of techniques for extending Ruby's syntax in ways that make programming easier. Metaprogramming is closely tied to the idea of writing domain-specific languages, or DSLs. DSLs in Ruby typically use method invocations and blocks as if they were keywords in a task-specific extension to the language. 

This chapter starts with several sections that introduce Ruby's reflection API. This API is surprisingly rich and consists of quite a few methods. These methods are defined, for the most part, by Kernel, Object, and Module.

As you read these introductory sections, keep in mind that reflection is not, by itself, metaprogramming. Metaprogramming typically extends the syntax or the behavior of Ruby in some way, and often involves more than one kind of reflection. After introducing Ruby's core reflection API, this chapter moves on to demonstrate, by example, common metaprogramming techniques that use that API. 


Note that this chapter covers advanced topics. You can be a productive Ruby programmer without ever reading this chapter. You may find it helpful to read the remaining chapters of this book first, and then return to this chapter. Consider this chapter a kind of final exam: if you understand the examples (particularly the longer ones at the end), then you have mastered Ruby! 



=end
