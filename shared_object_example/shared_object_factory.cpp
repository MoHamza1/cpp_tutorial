#include "shared_object_factory.hpp"

my_example::ObjectFactory::ObjectFactory(){
    std::cout << "created factory" << std::endl;
}

void my_example::ObjectFactory::GetSharedObj(ISharedObj **shared_obj){
    *shared_obj = new my_example::SharedObj();
}