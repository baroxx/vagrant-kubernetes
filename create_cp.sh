#!/bin/bash

vagrant up --provider libvirt --provision-with main,containerd,kubernetes,control,calico,final
