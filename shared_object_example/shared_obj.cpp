#include "shared_obj.hpp"

my_example::SharedObj::SharedObj() : ISharedObj(){
    std::cout << "Created New Shared Object" << std::endl;
    this->message_string = "";
}
void my_example::SharedObj::PrintMessage(){
    std::cout << message_string << std::endl;
}
void my_example::SharedObj::SetMessage(const std::string &my_string){
    this->message_string = my_string;
}
std::string my_example::SharedObj::GetMessage(){
    return this->message_string;
}
    
