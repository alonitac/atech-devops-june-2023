#!/bin/bash


ssh -i $KEY_PATH ubuntu@$1 "ssh -i $KEY_PATH ubuntu@$2 "
