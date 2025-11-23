#!/bin/bash
# Arithmetic in shell is done using $((expression))

a=15
b=10

sum=$((a + b))       # addition
diff=$((a - b))      # subtraction
mul=$((a * b))       # multiplication
div=$((a / b))       # division

echo "Sum: $sum"
echo "Difference: $diff"
echo "Multiplication: $mul"
echo "Division: $div"
