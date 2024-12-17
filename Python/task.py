'''FizzBuzz - Write a program that prints the numbers from 1 to 100. 
But for multiples of three print "Fizz" instead of the number and for the multiples of five print "Buzz". 
 For numbers which are multiples of both three and five, print "FizzBuzz"'''
def fizzbuzz():
    for i in range(1, 101):
        if i % 15 == 0:
            print("FizzBuzz")
        elif i % 3 == 0:
            print("Fizz")
        elif i % 5 == 0:
            print("Buzz")
        else:
            print(i)
# fizzbuzz()


'''Find the Largest Element in a List - Write a function that finds the largest element in a list.'''

numbers = [4, 7, 1, 9, 2, 5]
largest = numbers[0]
for num in numbers:
    if num > largest:
        largest = num
print("The largest element is:", largest)



'''.Find the second largest number in a list - Write a function that finds the second largest element in a list without using builtin methods. '''

numbers = [12, 35, 1, 10, 34, 1]
largest = None
second_largest = None
for num in numbers:
    if largest is None or num > largest:
        second_largest = largest
        largest = num
    elif second_largest is None or (num > second_largest and num != largest):
        second_largest = num

print("The second largest number is:", second_largest)


'''Find the second smallest number in a list - Write a function that finds the second smallest element in a list'''

numbers = [4, 7, 1, 9, 2, 5]

smallest = None
second_smallest = None

for num in numbers:
    if smallest is None or num < smallest:
        second_smallest = smallest
        smallest = num
    elif second_smallest is None or (num > smallest and num < second_smallest):
        second_smallest = num
print("The second smallest number is:", second_smallest)


'''Calculate the sum of a list of numbers – Write a function the calculates the sum of a list of numbers without built-in functions '''

numbers = [4, 7, 1, 9, 2, 5]
total_sum = 0
for num in numbers:
    total_sum += num

print("The sum of the list is:", total_sum)


'''Finding the element with maximum frequency in a list - Write a function that gives an element with maximum frequency of each element in a list. '''

numbers = [4, 7, 1, 7, 9, 7, 2, 4, 4, 4, 5]
frequency_dict = {}

# Count the frequency of each element in the list
for num in numbers:
    if num in frequency_dict:
        frequency_dict[num] += 1
    else:
        frequency_dict[num] = 1

# Find the element with the maximum frequency
max_frequency = 0
max_element = None

for key, value in frequency_dict.items():
    if value > max_frequency:
        max_frequency = value
        max_element = key

# Print the element with maximum frequency and its frequency
print("Element with maximum frequency:", max_element)
print("Frequency:", max_frequency)





"""Reverse a String - Write a function to reverse a string without using any built-in functions or slicing."""

string = "hello world"
reversed_string = ""
for char in string:
    reversed_string = char + reversed_string

print("Reversed string:", reversed_string)
