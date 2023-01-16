#!/bin/bash

# Choose crio or containerd
vagrant up --provider virtualbox --provision-with main,crio,kubernetes,control,calico,final
