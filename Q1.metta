; Binary tree consists of a set of nodes . Each node contains a single value and may have 0, 1, or 2 children .
; and a leaf node which is a node with no child.


; This Node data structure represents a node  with a value, a left child, and a right child.
; It takes a value and two BinaryTree elements (left and right children) and returns a BinaryTree.
(: Node (-> Number BinaryTree BinaryTree BinaryTree))

; A leaf node typically has no value both left child and right child.
(: Leaf (-> BinaryTree))

; an empty BinaryTree while Nil refers to empty
(define Nil (Leaf))


; The example-tree function creates a binary tree with a root node of value 4.
; The left child of the root node is another node with value 1 and the right child is a node with value 9.
(: example-tree (-> BinaryTree))
(= (example-tree) 
   (Node 4 (Node 1 Nil Nil) (Node 9 Nil Nil)))

; The Expected output should be => (Node 4 (Node 1 Nil Nil) (Node 9 Nil Nil))
!(example-tree) 

; The left function extracts and returns the left child of a given node.
(: left (-> BinaryTree BinaryTree))
(= (left (Node $value $left $right)) $left)

; The Expected output should be => (Node 1 Nil Nil)
!(left (example-tree)) 


; The right function extracts and returns the right child of a given node.
(: right (-> BinaryTree BinaryTree))
(= (right (Node $value $left $right)) $right)

; The Expected output should be => (Node 9 Nil Nil)
!(right (example-tree))



; The value function retrieves the value stored in a given node.
(: value (-> BinaryTree Number))
(= (value (Node $value $left $right)) $value)


; The Expected output should be => 1
!(value (left (example-tree))) 

; The Expected output should be => 4
!(value (example-tree)) 


; The member function checks if a given value exists in the binary tree.
; It has two cases:
; 1.  The base cases checks if the tree is Nil or empty the value is not found.
; 2. Otherwise it compares the target value with the current node's value.
;    - If the target value is less than the current node's value it recursively searches the left subtree.
;    - If the target value is greater it recursively searches the right subtree.
;    - If the target value is equal to the current node's value it returns True.
(: member (-> Number BinaryTree Bool))
(= (member _ Nil) False)
(= (member $target (Node $value $left $right))
   (if (< $target $value) 
       (member $target $left)
       (if (> $target $value)
           (member $target $right)
           True)))


; The test-member function checks if a given value is in the binary tree and returns a string message accordingly.
(: test-member (-> Number String))
(= (test-member $value)
   (str $value (if (member $value (example-tree)) " is in the tree" " is not in the tree")))

;The Expected outout should be => "[(str 1 " is in the tree")]"
!(test-member 1) ; Expected output: "1 is in the tree"

