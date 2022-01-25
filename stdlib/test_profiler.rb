require 'profiler'


Profiler__.start_profile

10000.times { 
    Random.rand
}



Profiler__.start_profile


Profiler__.print_profile STDOUT
