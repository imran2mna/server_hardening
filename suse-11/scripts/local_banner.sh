#!/bin/env bash

grep "Banner $1" /etc/issue && grep "{{ banner_msg }}" /etc/issue
