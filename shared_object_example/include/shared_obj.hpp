// shared_obj.hpp
#ifndef ME_SO_HPP
#define ME_SO_HPP
#include <string>
#include <iostream>
#include "i_shared_obj.hpp"

namespace my_example{

    class SharedObj : public ISharedObj {
        public:
            SharedObj();
            void PrintMessage();
            void SetMessage(const std::string &my_string);
            std::string GetMessage();
        private:
            std::string message_string;
    };
} // namespace my_example
#endif