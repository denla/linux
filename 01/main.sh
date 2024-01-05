#!/bin/bash

reg_ex_number='^[+-]?[0-9]+([.][0-9]+)?$'

error_incorrect_input="Incorrect input, use only one and non-number parameter."
parameter_1=$1
number_of_parameters=$#

if [ $number_of_parameters -ne 1 ]
then
  echo $error_incorrect_input;
  exit 1;
elif [[ "$parameter_1" =~ $reg_ex_number ]]
then
  echo $error_incorrect_input;
  exit 1;
else
  echo $parameter_1
fi