// shared_object_factory.hpp
#ifndef ME_SO_F_HPP
#define ME_SO_F_HPP
#include <string>
#include "i_shared_obj.hpp"
#include "shared_obj.hpp"
#include "i_shared_object_factory.hpp"

namespace my_example{

    class ObjectFactory : public IObjectFactory {
        public:
            ObjectFactory();
            void GetSharedObj(ISharedObj **shared_obj);
    };
} // namespace my_example
#endif