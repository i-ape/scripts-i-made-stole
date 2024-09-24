#import of stuff

import random
import string

#defining stuff

def generate_password(min_length, numbers=True, special_chars=True):
    letters = string.ascii_letters
    digits = string.digits
    special_chars = string.punctuation
    
    characters = letters
    if numbers:
        characters += digits
    if special_chars:
        characters += special_chars
        
    pwd = ""
    meets_criteria = False
    has_numbers = False
    has_special_chars = False
    
    while not meets_criteria or len(pwd) < min_length:
        new_char = random.choice(characters)
        pwd += new_char
        
        if new_char in digits:
            has_numbers = True
        elif new_char in special_chars:
            has_special_chars = True
        
        meets_criteria = True
        if numbers:
            meets_criteria = has_numbers
        if special_chars:
            meets_criteria = meets_criteria and has_special_chars
    return pwd
    

#ui
min_length = int(input("<>: "))
has_numbers = input("#: (y/n)?").lower() == "y"
has_special_chars = input("$%&: (y/n)?").lower() == "y"

pwd = generate_password(min_length=min_length, numbers=has_numbers, special_chars=has_special_chars)    
print(pwd)

#password generator  v1 py-pj1
#i-ape
#26/5/23