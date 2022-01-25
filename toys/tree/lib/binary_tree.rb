
require 'langutil'


# 
# Node for Binary Tree implementation
#
class BinaryTreeNode

  attr_accessor :parent, :left, :right,  :value

  def initialize(value, parent, left, right)
    @value = value
    @parent = parent
    @left = left
    @right = right
  end

  def left=(v)
    v = self.class.new(v, nil, nil, nil) if not v.kind_of? self.class

    # unlink v's parent
    v.unlink_parent
    
    # unlink my left
    unlink_left
    
    # link
    link_left(v)
  end

  def right=(v)
    v = new(v, nil, nil, nil) if not v.kind_of? self.class
    
    v.unlink_parent

    unlink_right
    
    link_right(v)
  end


  def each dir=:inorder, &block

    return if not block_given?

    yield value if dir == :preorder

    left.each do |e|
      yield e
    end unless left.nil?

    yield value if dir == :inorder
    
    right.each do |e|
      yield e
    end unless right.nil?

    yield value if dir == :postorder
  end

  
  def map dir = :inorder, &block
    block = proc {|e| e}  if not block_given?
    arr = []

    arr << value if dir == :preoder

    unless left.nil?
      l = left.map do |e|
        block.call(e)
      end
      arr.concat(l)
    end

    arr << value if dir == :inorder

    unless right.nil?
      r = right.map do |e|
        block.call(e)
      end 
      arr.concat(r)
    end
    
    arr << value if dir == :postorder

    arr
  end
  
  
  def inspect
    to_s
  end

  def to_s
    no_child = left.nil?  && right.nil?
    "#{value}#{no_child ? '':'('}#{left.nil? ? '': left}#{right.nil? ? '': ' '+right.to_s}#{no_child ? '': ')'}"
  end

  # unlink relation between me and my parent
  def unlink_parent
    return nil unless @parent
    o = @parent
    @parent.left = nil if @parent.left = self
    @parent.right = nil if @parent.right = self
    @parent = nil
    o 
  end

  # unlink relation between me and my left child
  def unlink_left
    return nil unless @left
    o = @left
    @left.parent = nil 
    @left = nil
    o
  end

  # unlink relation between me and my right child
  def unlink_right
    return nil unless @right
    o = @right
    @right.parent = nil
    @right = nil
    o
  end

  #
  def link_left(n)
    n.parent = self
    @left = n
  end

  def link_right(n)
    n.parent = self
    @right = n
  end

end


#
#  a Tree has a root node. thus a ref to root node.
#  can be empty. root ref is nil
#  can insert value, delete value, and search value
#  can traverse in pre,in,post order.  (each, map)




class BinaryTree
  include LangUtil

  symbol_constant  :preorder, :inorder, :postorder

  attr_accessor :root

  def initialze 
    @root = nil
  end

  def insert(n)
    vn = BinaryTreeNode.new(n, nil, nil, nil)
    if @root.nil?
      @root = vn
    else
      self.class.insert_value_node_to_node(vn, @root)
    end
  end


  def delete(n)
  end

  def each(dir=:inorder, &block)
    @root.each(dir, &block) if @root
  end

  def map(dir=:inorder, &block) 
    @root ? @root.map(dir, &block) : []
  end

  private

  # method to determine which direction of child that new node is moved/inserted into.
  def self.child_direction_of_node(node, base_node)
    [:left, :right].sample
  end

  def self.insert_value_node_to_node(vn, n)
    while true do
      # just match
      return n if vn.value == n.value

      dir = child_direction_of_node(vn, n)
      case dir 
      when :left 
        if not n.left.nil?
          n = n.left  
        else
          n.left = vn
          break
        end
      when :right
        if  not n.right.nil? 
          n = n.right
        else
          n.right = vn
          break
        end
      end
    end  # while
    vn
  end
end


#
# BinarySearchTree is a BinaryTree. with order rule as:
# 1, all node of left substree  < the node
# 2, all node value of right substree > the node
#
class BinarySearchTree

  attr_accessor :root

  def initialize
    @root = nil
  end

  def insert(v)
    # if no root, make it root
    return @root = BinaryTreeNode.new(v, nil, nil, nil) if @root.nil?
    
    # find position to insert
    # balanced tree rule:
    #  left node < me < right node.
    #  left substree nodes < me < right substree nodes
    vn = BinaryTreeNode.new(v, nil, nil, nil)
    insert_value_node_to_node(vn, root)
  end


  def delete(v)
    n = root
    left = true
    while true do

      return nil if n.nil?

      if v < n.value
        if not n.left.nil?
          n = n.left  
          left = true
        else
          return nil # no hit
        end
        
      elsif v > n.value 
        if  not n.right.nil? 
          n = n.right
          left = false
        else
          return nil # not hit
        end

      else # match, remove node

        # remove node means 
        # 1, right node take place the postition. 
        # 2, left node insert to right node.

        if n.right and n.left
          insert_value_node_to_node(n.left, n.right)
          n.left = nil
        end

        vn = nil
        vn = n.right if n.right
        vn = n.left if n.left

        vn.parent = n.parent if vn
        left ? n.parent.left = vn : n.parent.right = vn if n.parent
        
        return n
      end

    end # while
  end

  #
  def search(v)
    n = root
    while true do

      if v < n.value  # left substree
        if not n.left.nil?  # move left
          n = n.left  
        else  # end no match
          return nil # no hit
        end
        
      elsif v > n.value   #right substree
        if  not n.right.nil?   #move right
          n = n.right
        else  # end, no match
          return nil 
        end

      else # match
        return n
      end

    end # while
  end

  
  def each dir=:inorder, &block
    return if @root.nil?
    @root.each &block
  end

  def map dir=:inorder, &block
    return [] if @root.nil?
    @root.map &block
  end

  private
  def rotate_right
    return unless root.left

    # store next root
    t = root.left  
    r = root

    # reserve root 's parent first.
    t.parent = r.parent

    #root node change
    r.parent = t
    r.left = t.right;

    # t change
    t.right.parent = root if t.right
    t.right = r

    @root = t
  end

  def rotate_left
    return unless root.right
    t = root.right
    r = root

    #reserve root's parent first
    t.parent = r.parent

    # root change
    r.parent = t
    r.right = t.left

    # t change
    t.left.parent = r if t.left
    t.left = r

    root = t
  end

  def insert_value_node_to_node(vn, n)
    while true do

      if vn.value < n.value
        if not n.left.nil?
          n = n.left  
        else
          n.left = vn
          vn.parent = n
          break
        end
        
      elsif vn.value > n.value 
        if  not n.right.nil? 
          n = n.right
        else
          n.right = vn
          vn.parent = n
          break
        end
      else
        vn = n  # already have value do nothing
        break
      end

    end # while
    vn
  end


  def balance_if_required
    
  end
end





class SelfBalancedBinarySearchTree
end
