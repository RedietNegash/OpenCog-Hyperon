;List operations in MeTTa

; 1.Length
; This function has two cases 
; The base case returns 0 if it is an empty list.
; The second case takes a list and adds 1 to the length of the tail of the list  recursively calling the length function until the base case is reached.

(= (length Nil) 0)
(= (length (Cons $x $xs))
   (+ 1 (length $xs)))
! (length (Cons A (Cons B (Cons C Nil))))


; 2.Append
; Append function combines two lists into one 
; let $y be the second list
; The function has two cases:
; 1. The base case returns the second list if the first list is empty
; 2. The second case add the first element of the first list to the result of appending the rest of the first list to the second list.


(= (append Nil $ys) $ys)   

(= (append (Cons $x $xs) $ys)
   (Cons $x (append $xs $ys))) 

; The Expected output should be => (Cons A (Cons B (Cons C (Cons D Nil))))
!(append (Cons A (Cons B Nil)) (Cons C (Cons D Nil))) 



; 3.max-value 
; The base case returns the element if the list contains only 1 element.
; The second case Compare the current element $x with the max of the rest of the list.
; $y for storing the max-value in each recursive call.
(= (max-value (Cons $x Nil)) $x)  

(= (max-value (Cons $x $xs))
   (case (max-value $xs)
     (($y (if (> $x $y) $x $y)))  ; 
   )
)

;The expected output should be 3
!(max-value (Cons 1 (Cons 3 (Cons 2 Nil))))


; 4.min-value 
; The base case returns the element if the list contains only 1 element.
; The second case Compare the current element $x with the min of the rest of the list.
; $y for storing the min-value in each recursive call.
(: min-value (-> List Number))
(= (min-value (Cons $x Nil)) $x)
(= (min-value (Cons $x $xs)) 
   (case (min-value $xs)
         (($y (if (< $x $y) $x $y)))
   )
)

; The Expected output should be => 1
!(min-value (Cons 1 (Cons 3 (Cons 2 Nil)))) 

; 5.push
; The function push takes an element and a list
; returning a list with the elment added to the front of the list.
(= (push $x $xs) (Cons $x $xs))

; The Expected output should be => (Cons 0 (Cons 1 (Cons 2 Nil)))
!(push 0 (Cons 1 (Cons 2 Nil)))   


; 6.pop
; The function pop takes an element and a list
; returning a list with the elment removed from the front(top) of the list.

(= (pop Nil) Nil)
(= (pop (Cons $x $xs)) $xs)

; The expected output should be => [(Cons 1 (Cons 2 Nil))]
!(pop (Cons 0 (Cons 1 (Cons 2 Nil))))

; 7.remove-element
; This function has 3 cases
; 1. if the list is empty it returns empty list
; 2. if the element to be removes is in the head of the list it returns the list without that element
; 3. if the element to be removes is not the head of the list it returns a new list where the head element is preserved.
     ; then the function recursively calls itself to process the rest of the list.

(= (remove-element _ Nil) Nil)
(= (remove-element $x (Cons $x $xs)) $xs)
(= (remove-element $x (Cons $y $xs))
   (Cons $y (remove-element $x $xs))
)

 ; The Expected output should be => (Cons 1 (Cons 2 Nil))
!(remove-element 3 (Cons 1 (Cons 2 (Cons 3 Nil))))





; 8.map
; A map function applies a function to each element of the list.
; first i created a square function that takes a single number and returns the sequare of that number.
(: square (-> Number Number))
(= (square $x) (* $x $x))

;Then the map function will apply the square function to each element of the list

(= (map _ Nil) Nil)
(= (map $f (Cons $x $xs)) (Cons ($f $x) (map $f $xs)))


; The expected output should be [(Cons 1 (Cons 4 (Cons 9 Nil)))]
!(map square (Cons 1 (Cons 2 (Cons 3 Nil)))) ;


; 9.foldr

; First i created add function which takes two elements and return their number.
(= (add $a $b) (+ $a $b))

; The Expected output should be 5.
!(add 2 3) 

; The foldr function takes a function, inital value and a list.
; It recursively applies the function starting from the rightmost element of the list and accumlating the result until it reaches the base case.

(= (foldr $f $init $list)
   (case $list
     ((Nil $init)
      ((Cons $x $xs) ($f $x (foldr $f $init $xs))))
   )
)
; The Expected output should be => 6.
!(foldr add 0 (Cons 1 (Cons 2 (Cons 3 Nil)))) ; 

; 10.foldl

; The foldl function takes a function, inital value and a list.
; It recursively applies the function starting from the first(leftmost) element of the list and accumlating the result until it reaches the base case.

(= (foldl $f $init Nil) $init)
(= (foldl $f $init (Cons $x $xs)) (foldl $f ($f $init $x) $xs))

; The Expected output should be => 6.
!(foldl add 0 (Cons 1 (Cons 2 (Cons 3 Nil)))) ; Expected output: 6



; 11,sort
; The insert function is a helper function that takes a number and a sorted list of numbers then compares the number with the first element of the sorted list.
; if the number is smaller than the first element if it is it places the number before the first element.
; if the number is greater, it recursively inserts the number into the rest of the sorted list.
(: insert (-> Number (List Number) (List Number)))
(= (insert $x Nil) (Cons $x Nil))
(= (insert $x (Cons $y $ys))
   (if (< $x $y)
       (Cons $x (Cons $y $ys))
       (Cons $y (insert $x $ys))))

; The sort function sorts an unsorted list of numbers.
; It takes the first element from the unsorted list and recursively sorts the rest of the list.
; Then, it uses the insert function to place the first element into the correct position
; within the sorted rest of the list, resulting in a fully sorted list.
(: sort (-> (List Number) (List Number)))
(= (sort Nil) Nil)
(= (sort (Cons $x $xs)) (insert $x (sort $xs)))


; the expected output should be => (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))).
!(sort (Cons 3 (Cons 1 (Cons 4 (Cons 2 Nil))))) ;

; 12.reverse

; The reverse function takes a list and produces a new list with elements in the opposite order.
; It uses an accumulator to build the reversed list.
; The recursive case takes the first element of the list and adds it to the front of the accumulated list,
; then recursively processes the rest of the list.

(= (reverse Nil) Nil)
(= (reverse (Cons $x $xs))
   (reverse-acc $xs (Cons $x Nil)))

; This is the helper function. It works by moving each item from the original list to the start of the accumulator.
; Once the original list is empty it returns the accumulator as the reversed list.

(: reverse-acc (-> (List Number) (List Number) (List Number)))
(= (reverse-acc Nil $acc) $acc)
(= (reverse-acc (Cons $x $xs) $acc)
   (reverse-acc $xs (Cons $x $acc)))


;The expected output should be => (Cons 4 (Cons 3 (Cons 2 (Cons 1 Nil)))).
!(reverse (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil))))) ;


; 13.is-member
; This function checks if a given element is present in the list.
; It has two cases:
; 1. If the list is Nil (empty), the element is not in the list, so it returns False.
; 2. If the list is not Nil, it compares the target element with the head of the list:
;    If the target is less than the head, it recursively checks if the target is in the tail.
;    If the target is greater than the head, it recursively checks if the target is in the tail.
;    If the target equals the head, it returns True.

(: is-member (-> Number (List Number) Bool))
(= (is-member _ Nil) False) 
(= (is-member $target (Cons $x $xs))
   (if (< $target $x)
       (is-member $target $xs) 
       (if (> $target $x)
           (is-member $target $xs) 
           True))) 

;The Expected outout should be => True
!(is-member 2 (Cons 1 (Cons 2 (Cons 3 Nil)))) 






;I tried to implment the remove-duplicate and the reverse function but i couldn't get the exact output i was expecting.

; 14.remove-duplicate

; This function has two cases:
; 1. If the list is empty, it returns an empty list.
; 2. If the list is not empty it checks if the head of the list is a duplicate.
;    - To do this, it recursively removes duplicates from the tail of the list and then checks if the head is already in the processed tail.
;    - If the head is not in the processed tail it adds it to the result list.

(: remove-duplicate (-> (List Number) (List Number)))
(= (remove-duplicate Nil) Nil) 
(= (remove-duplicate (Cons $x $xs))
   (remove-duplicate-helper $x $xs (remove-duplicate $xs))) 


(: remove-duplicate-helper (-> Number (List Number) (List Number) (List Number)))
(= (remove-duplicate-helper _ Nil $acc) $acc)
(= (remove-duplicate-helper $x (Cons $y $ys) $acc)
   (if (= $x $y)
       (remove-duplicate-helper $x $ys $acc) 
       (remove-duplicate-helper $x $ys (Cons $y $acc))) 
)


; The Expected output should be => (Cons 1 Nil)
!(remove-duplicate (Cons 1 (Cons 1 (Cons 1 Nil)))) 


; 15. filter
; The filter function applies a function to each element of the list.
; Then it returns a new list containing only the elements that satisfy the that function.


; Base case: If the input list is empty, the result is also an empty list.
(= (filter _ Nil) Nil)

; This case Checks if the head element $x of the list satisfies the function $pred.
(= (filter $pred (Cons $x $xs))
   (if ($pred $x)
       (Cons $x (filter $pred $xs))
       (filter $pred $xs))
)

; The predicate function will be to test if a number is even.
(: is-even (-> Number Bool))
(= (is-even $x)
   (= (mod $x 2) 0)) 


; The expected output should be  => (Cons 2 (Cons 4 Nil)).
!(filter is-even (Cons 1 (Cons 2 (Cons 3 (Cons 4 Nil)))))
