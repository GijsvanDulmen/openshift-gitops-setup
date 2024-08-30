#!/bin/bash
helm template . -f ./debug.yaml -f ./values.yaml -f ./clusters/dev.yaml --debug