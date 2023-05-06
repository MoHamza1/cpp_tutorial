// i_shared_obj.hpp
#ifndef ME_I_SO_HPP
#define ME_I_SO_HPP

#include <string>

namespace my_example{

    class ISharedObj {
        public:
            virtual void PrintMessage() = 0;
            virtual void SetMessage(const std::string &my_string) = 0;
            virtual std::string GetMessage() = 0;
    };
} // namespace my_example
#endif