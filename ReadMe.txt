Notes to graders: 


Not all the code is verified. Specifically, only the following pieces of code were attempted:


num_of_decreases
        
partial_eval_clause
        Helpers: 
        is_clause_sat
        is_clause_conflict
        is_clause_unit_unr2
                Helper:
                is_clause_unit_unr


partial_eval_cnf
        Helpers: 
        is_Sat
        is_Conflict
        is_Unit


backtrack


pure_literal_rule (the SAT improvement)
Note: This function considers both all-positive literals and all-negative literals “pure”. The instructions were a little vague as to whether all-negative literals were pure, so I went ahead and added all-negative literals to the algorithm to be on the safe side.
Helpers: 
is_in_pos
pure_positive_rule
is_in_neg
pure_negative rule