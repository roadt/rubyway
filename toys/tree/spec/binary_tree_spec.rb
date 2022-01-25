require 'spec_helper'


## BinaryTreeNode
describe BinaryTreeNode do

  let(:n1) { BinaryTreeNode.new(1, nil, nil, nil) }
  let(:n2) { BinaryTreeNode.new(2, nil, nil, nil) }
  let(:n3) { BinaryTreeNode.new(3, nil, nil, nil) }

  it "intialize with attribute and right set attribute value" do
    v = 1
    n = BinaryTreeNode.new(v, v, v, v)
    [n.value, n.parent, n.left, n.right].should == [v, v,v,v]
  end

  it "link left will link node to left child of this node" do
    n1.left = n2
    n1.left.should == n2
    n2.parent.should == n1  #linked

    n1.left = n3
    n1.left.should == n3
    n3.parent.should == n1 

    # also prevous left node's parent should be nil
    n2.parent.should be_nil
  end


  it "link right will link right node" do

    n1.right = n2
    n1.right.should == n2
    n2.parent.should == n1

    n1.right = n3
    n1.right.should == n3
    n3.parent.should == n1

    # also previous right node's parent
    n2.parent.should be_nil
  end
  
end


## BinaryTree
describe BinaryTree do

  let(:tree) { BinaryTree.new }
  let(:arr) { (1..20).to_a.shuffle }
  let(:arr2) { arr }

  it "can insert value" do
    arr.each {|v| tree.insert(v)}
    tree.map.sort.should == arr.sort
  end

  it "can delete value" do
    arr.each{|v| tree.insert(v) }
    tree.delete(10)
    tree.map.index(10).should be_nil
  end

  it "can traverse value" do
    arr.each {|v| tree.insert(v)}
    num = 0
    tree.each{|e| num = num + 1}
    num.should == 20
  end

  it "cam map value" do
    arr.each{|v| tree.insert(v)}
    tree.map{|v| v}.count.should == 20
  end
    
  it "can map tree to a array in order" do
    arr.each{|v| tree.insert(v)}
    tree.map.count.should == 20
  end

end


## BinarySearchTree
describe BinarySearchTree do
  
  let(:arr) {  (1..20).to_a }
  let(:tree) do 
    t = BinarySearchTree.new; 
    (1..20).to_a.shuffle.each{|v|t.insert(v)}
    t
  end

  let(:arr2) { arr }

  it "initialize with root is nil " do
    t = BinarySearchTree.new
    t.root.should be_nil
  end

  it "can find inserted value" do
    tree.search(12).should_not be_nil
  end 

  it "can insert vaue" do
    t = BinarySearchTree.new
    # root nil case
    t.insert(13)
    t.root.value.should == 13

    # root non-nil case
    t.insert(14)
    t.search(14).should_not be_nil
  end

  it "can delete value" do
    tree.delete(12)
    tree.search(12).should be_nil
    tree.delete(7)
    tree.delete(16)
    print tree.map
  end

  it "can do in order traverse" do
    arr = []
    tree.each {|e|  arr << e}
    arr.should == arr
  end

  it " map" do
    res = tree.map
    res.should == arr
  end


  describe "private methods" do 

    it "rotate right doesn't change tree order" do
      tree.instance_eval { rotate_right}
      tree.map == arr
      tree.instance_eval { rotate_right }
      tree.map == arr
    end

    it "rotate left doesn't chagne tree order" do
      tree.instance_eval { rotate_left }
      tree.map == arr
      tree.instance_eval { rotate_left }
      tree.map == arr
    end

  end
end
