#!/bin/bash
#export LC_NUMERIC=C

echo "$(tput setaf 4)[15-414] Bug Catching: Automated Program Verification$(tput sgr 0)"

for f in formulas/*.cnf ;
  do 
  # run your solver
  exec/main.native $f > /tmp/why3cnf.txt
  unsat=0
  case $f in 
    (*unsat*) unsat=1;
  esac

  unsat_solver=`grep -c -w unsat /tmp/why3cnf.txt`
  sat_solver=`grep -c -w sat /tmp/why3cnf.txt`
  if [[ (($unsat_solver -eq 1) && ($unsat -eq 1)) || (($sat_solver -eq 1) && ($unsat -eq 0)) ]] ; then
    echo -e "$(tput setaf 4)[15-414]$(tput sgr 0) Benchmark $(tput bold)$f$(tput sgr 0)\t\t\t$(tput setaf 2)[OK]$(tput sgr 0)"
  elif [[ (($unsat_solver -eq 0) && ($unsat -eq 1)) || (($sat_solver -eq 0) && ($unsat -eq 1)) ]] ; then
    echo -e "$(tput setaf 4)[15-414]$(tput sgr 0) Benchmark $(tput bold)$f$(tput sgr 0)\t\t\t$(tput setaf 1)[WRONG]$(tput sgr 0)"
  else 
    echo -e "$(tput setaf 4)[15-414]$(tput sgr 0) Benchmark $(tput bold)$f$(tput sgr 0)\t\t\t$(tput setaf 1)[UNKNOWN]$(tput sgr 0)"
  fi
done

rm -f /tmp/why3cnf.txt
