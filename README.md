# E-Commerce Application High level design

## Services -

* Auth Service
* Profile Service
* Product Catalogue Service
* Product Recommendation Service
* Product Search Service
* Cart Service
* Order Service
* Payment gateway service
* Inventory Service 
* Notification Service


### Auth service

#### Post - /sign-up
Description - User sign-up with email or phone number with password \
        request \
                {\
                    "email" or "phone number" \
                    "password" \
                }

        if (signup) {
            jwt token generated
            Notification Service triggered 
            kafka - topic ("email") or ("SMS")
                type = welcome
            return http response status
        } else {
            return error
        }

### POST - /login
Description - User logout with email or phone number with password \
            request
                {
                    "email" or "phone number" \
                    "password" 
                }

            if (signup) {
                jwt token generated
                Notification Service triggered
                kafka - topic ("email") or ("SMS")
                    type = login alert
                return http response status
            } else {
                return error
            }

### POST - /logout
Description - user will be logout and session will be archived    

        get id from context 

### POST - /refresh-token
Description - refresh token will be generated \
        request { token }

        if (token) {
            access token will be generated with refresh token
        } else {
            return error
        }

        
        
