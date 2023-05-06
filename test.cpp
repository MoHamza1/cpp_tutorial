
// C++ Program to demonstrate
// Hello world
#include <iostream>
#include "i_shared_obj.hpp"
#include "shared_object_factory.hpp"

int main()
{
    my_example::ISharedObj *shared_object_pointer;
    my_example::ObjectFactory *my_object_factory = new my_example::ObjectFactory();
    my_object_factory->GetSharedObj(&shared_object_pointer);
    shared_object_pointer->SetMessage("Shared object will print this");
    shared_object_pointer->PrintMessage();

    std::string returned_value = shared_object_pointer->GetMessage();

    std::cout << "returned_value is:" << "hello world" << std::endl;
}
