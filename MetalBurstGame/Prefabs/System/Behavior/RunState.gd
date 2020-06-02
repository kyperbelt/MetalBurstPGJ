
#treated as an enum
class_name RunState

const Nothing : int = -1 #No state has been set, not used right now - will remove if cant remember usecase
const Running : int = 0  #Currently running
const Failed : int = 1   #Has finished running and failed 
const Success: int = 2   #Has finished running and succeeded

