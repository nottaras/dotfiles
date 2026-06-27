BEGIN { incode = 0 }
{ lines[NR] = $0 }
END {
  i = 1
  while (i <= NR) {
    line = lines[i]
    if (line ~ /^```/) { incode = !incode; print line; lastp = line; i++; continue }
    if (incode)        { print line; lastp = line; i++; continue }
    if (line ~ /^[ \t]*$/) {
      j = i
      while (j <= NR && lines[j] ~ /^[ \t]*$/) j++
      nxt = (j <= NR) ? lines[j] : ""
      if (isprose(lastp) && isprose(nxt)) { print ""; lastp = "" }
      i = j
      continue
    }
    print line; lastp = line; i++
  }
}
function isprose(s) {
  if (s ~ /^[ \t]*$/)           return 0
  if (s ~ /^#/)                 return 0
  if (s ~ /^[ \t]*[-*+] /)      return 0
  if (s ~ /^[ \t]*[0-9]+[.)] /) return 0
  if (s ~ /^[ \t]*>/)           return 0
  if (s ~ /^[ \t]*\|/)          return 0
  if (s ~ /^```/)               return 0
  return 1
}
