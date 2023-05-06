// i_shared_obj.hpp
#ifndef ME_I_SO_F_HPP
#define ME_I_SO_F_HPP

#include <string>

namespace my_example{

    class IObjectFactory {
        public:
            void GetSharedObj(SharedObj **shared_obj);
    };
} // namespace my_example
#endif