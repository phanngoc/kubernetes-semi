#!/bin/bash

# Node to query
NODE_IP="10.244.1.218"
NODE_PORT="6379"

# Check slot coverage
redis-cli -h $NODE_IP -p $NODE_PORT cluster slots | awk '
BEGIN {
  total_slots = 0
  slot_start = 0
  slot_end = 0
}
{
  if (NR % 7 == 1) slot_start = $2
  if (NR % 7 == 2) {
    slot_end = $2
    total_slots += (slot_end - slot_start + 1)
  }
}
END {
  print "Total Slots Covered: " total_slots
}
'